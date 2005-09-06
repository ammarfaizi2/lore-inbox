Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVIFIdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVIFIdr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 04:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVIFIdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 04:33:47 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:48054 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932446AbVIFIdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 04:33:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Cgy0vm+wNmtxwdA70gc/1MeqShOTmOhf2L7cczVgvQwJfjU9jbtZVhfqkLyCw1WhxpQ5paRYAuHPiw3Op316rvHcLhYKSID+LJdMXHwoMYI3CNj8P/CYNJnUBb1oKcACR3IMpPtOTfsW8AnGZVBeqQuJ2XAndHstnP7HKccgaU8=
Message-ID: <431D5442.1030002@gmail.com>
Date: Tue, 06 Sep 2005 16:33:06 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gl@dsa-ac.de
CC: Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: who sets boot_params[].screen_info.orig_video_isVGA?
References: <Pine.LNX.4.63.0509051646480.11341@pcgl.dsa-ac.de> <E1ECIub-00088O-00@chiark.greenend.org.uk> <Pine.LNX.4.63.0509051736420.11341@pcgl.dsa-ac.de> <431CEEAF.5090701@gmail.com> <Pine.LNX.4.63.0509060918310.11341@pcgl.dsa-ac.de>
In-Reply-To: <Pine.LNX.4.63.0509060918310.11341@pcgl.dsa-ac.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gl@dsa-ac.de wrote:
> On Mon, 5 Sep 2005, Matthew Garrett wrote:
> 
>> Yup. You probably want to take a look at Documentation/fb/vesafb.txt -
>> the modes are the same.
> 
> Great, thanks! I tried VESA 0x111 (Linux 0x311) - it is also what is
> used by xfree86 vesa driver, after I've followed the suggestion from
> Tony (cc'ed and quoted below) and tried X with vesa. The kernel boots,
> intelfb driver doesn't exit, I can even start X over fb and it runs! But:
> 
> 1) both screens - LCD and CRT bocome black as soon as intelfb takes over
> and stay that way also under X
> 
> 2) kernel logs fill with
> 
> intelfb: the cursor was killed - restore it !!
> intelfb: size 8, 16   pos 0, 464
> 
> Buggy video BIOS?...

There might be a bug with the ioremap patch that got in by the time
linux-2.6.13 was released. The intelfb maintainer is still working on it.
You can try to revert that patch (just make sure that the graphics
aperture in the BIOS is set to <= 128MB) or use vesafb for now.

Here's the link to that patch:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;h=6bd49341f2806168c877e12cefca77b93437bac2;hp=89204c40a03346cd951e698d854105db4cfedc28

Tony

