Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161138AbWJ3G0d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbWJ3G0d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 01:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbWJ3G0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 01:26:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:45301 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1161138AbWJ3G0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 01:26:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JFiHd/aiQ6hc/0l8joO9sKXaXbKqYN9ya+HdWtRXijompPYEbNzEAmESYZ3szHeUa+eu08zqmz2y4hLus9XVxVYVmBZ2PMSVZUzy5tS8HZrqBGDEiCdf4ktzdMIb2rwDZX4jc9iXwNMqOL0iREQHu7YplChRpjfbjqahEKl4Skc=
Message-ID: <45459B10.6080702@gmail.com>
Date: Mon, 30 Oct 2006 15:26:24 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060928)
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Background scan of sata drives
References: <453EDF44.3090308@cfl.rr.com>
In-Reply-To: <453EDF44.3090308@cfl.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:
> I seem to recall seeing mention flow by on the lkml at some point that 
> sata disks are now scanned in the background rather than blocking in the 
> modprobe, but that there is a new dummy module you can load that just 
> blocks until all drives have been scanned.  I tried but was unable to 
> find the thread that mentioned this, so does anyone know what that 
> module was?

Scanning during boot and module loading is blocking.  modprobe will wait 
in the kernel until the initial scan is complete.  But user initiated 
scan (echo - - - > /sys/class/scsi_host/hostX/scan) doesn't wait for 
completion.  Patch to make user scan blocking is pending.

-- 
tejun
