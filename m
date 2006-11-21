Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030710AbWKUEbI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030710AbWKUEbI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 23:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934305AbWKUEbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 23:31:08 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:61639 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S934304AbWKUEbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 23:31:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=O3NZeLEI02fXNhPk01wq70hwulyVGvUw+CFqQji40wE1Ya9Aj0DUAQwEdUbewKqnNsKW6cikknOWCzHs35RZCTHibR3/bn4il9sqqmC50/g7134o+w0utc9q33biUbvJyLlLh+b6PsfRB37SkIVfuHqoKO8ZUxKSJjut/XZLTF0=
Message-ID: <456280FE.70607@gmail.com>
Date: Tue, 21 Nov 2006 13:30:54 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: kernel list <linux-kernel@vger.kernel.org>, axboe@suse.de
Subject: Re: SATA powersave patches
References: <20060908110346.GC920@elf.ucw.cz> <45015767.1090002@gmail.com> <20060908123537.GB17640@elf.ucw.cz> <4501655F.5000103@gmail.com> <20060910224815.GC1691@elf.ucw.cz> <4505394F.6060806@gmail.com> <20060918100548.GJ3746@elf.ucw.cz> <450E771E.1070207@gmail.com> <20061106135751.GA13517@elf.ucw.cz> <454F747A.9050209@gmail.com> <20061112183927.GB5081@ucw.cz>
In-Reply-To: <20061112183927.GB5081@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Pavel Machek wrote:
>> If I understood correctly, the high power consumption of 
>> ahci controller can be solved by dynamically turning off 
>> command processing while the controller is idle, which 
>> fits nicely into link powersaving, right?  So, I think 
>> full-fledged leveled dynamic PM would be an overkill for 
>> this particular problem, but then again, maybe the 
> 
> It is single bit, and it should not even need a timeout, AFAICT, so
> perhaps we should just fix it (no need for dynamic PM layers). It
> probably does not even need to be configurable...

I think this has been discussed in linux-ide recently but just to add my 
2 cents.  ALPE and ASP can cause quite some problems.  Many devices 
don't implement link powermanagement mode properly and some locks up 
completely (recent LG dvd-rams, only physical power removal/reapply can 
recover it) while others (wd raptors) spin down on slumber.  If you turn 
on ALPE and ASP on such devices, all hell will break loose.

Even for devices which implement partial and slumber modes properly, I'm 
not very comfortable with ALPE.  It puts the link into power save mode 
as soon as there is no command pending.  IMHO, that's way too 
aggressive.  It's not like being that aggressive will bring any 
noticeable difference in power consumption.  Disk idle period is too 
long for that level of aggressiveness to be effective.

Thanks.

-- 
tejun
