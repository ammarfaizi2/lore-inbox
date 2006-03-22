Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWCVE6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWCVE6r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 23:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWCVE6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 23:58:47 -0500
Received: from mga03.intel.com ([143.182.124.21]:21855 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750759AbWCVE6q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 23:58:46 -0500
X-IronPort-AV: i="4.03,116,1141632000"; 
   d="scan'208"; a="14143582:sNHT27222062"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Subject: RE: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Date: Wed, 22 Mar 2006 12:58:36 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F840B417DFC@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.16-rc5: known regressions [TP 600X S3, vanilla DSDT] 
Thread-Index: AcZNaimxgVqfvdClQQiJmikiyaHRZwAAQ63w
From: "Yu, Luming" <luming.yu@intel.com>
To: "Sanjoy Mahajan" <sanjoy@mrao.cam.ac.uk>
Cc: <linux-kernel@vger.kernel.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Andrew Morton" <akpm@osdl.org>, "Tom Seeley" <redhat@tomseeley.co.uk>,
       "Dave Jones" <davej@redhat.com>, "Jiri Slaby" <jirislaby@gmail.com>,
       <michael@mihu.de>, <mchehab@infradead.org>,
       "Brian Marete" <bgmarete@gmail.com>,
       "Ryan Phillips" <rphillips@gentoo.org>, <gregkh@suse.de>,
       "Brown, Len" <len.brown@intel.com>, <linux-acpi@vger.kernel.org>,
       "Mark Lord" <lkml@rtr.ca>, "Randy Dunlap" <rdunlap@xenotime.net>,
       <jgarzik@pobox.com>, "Duncan" <1i5t5.duncan@cox.net>,
       "Pavlik Vojtech" <vojtech@suse.cz>, "Meelis Roos" <mroos@linux.ee>
X-OriginalArrivalTime: 22 Mar 2006 04:58:38.0122 (UTC) FILETIME=[47FDB0A0:01C64D6D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> We can do bisection in EC0.UPDT to find out which statement cause
>> hang?
>
>Yes, though see below for why I don't think it'll help no 
>matter what we
>find there.

Please don't give up . :-)

I need to know which statement  in EC0.UPDT that could trigger the
problem.
That is very important to understand the problem correctly.
If we cannot find out that statement , then, I will dout the testing
results that guiding us to here.

>
>> My assumption is that since Windows works well, then these BIOS code
>> should have been tested ok. The only possible excuse for BIOS is that
>> Linux is using unnecessary/untested code path for 
>Suspend/resume.  So,
>> Eventually, we need to disable unnecessary BIOS call for
>> suspend/resume
>
>Maybe we're not collecting the right data in that case.  We know that
>commenting out the call to UPDT in THM0.TMP fixes the hang.  
>But it does
>not follow that the osl suspend code should avoid running UPDT.

This is still my assumption that some AML code needed to be avoided
in suspend/resume, I need data support. So, we need to dig more in 
EC0.UPDT.


>
>The hang may work like this: Between boot and sleep, calling 
>UPDT messes
>up something in the ec [which is why it takes >1 sleep to 
>cause a hang].
>When the system tries to sleep, that something triggers and the ec
>hangs.  But it may hang somewhere else than UPDT, and avoiding UPDT
>during sleep will not fix it.

If BIOS behaviors NOT correctly , then everything can happen.

>
>However, we do have one more piece of data.  When it hangs, it hangs in
>\_SI._SST, because I see that line on successful sleeps (as the last

I don't know this. I always assume the hang is at _PTS.SMPI

>method before the beep) but not when it hangs (and then I also don't
>hear a beep).  There are lots of calls to EC0.XXX, including to
>EC0.BEEP, within _SST, which isn't surprising if the EC is the problem.

It could be. But there should have something that trigger it.

>So perhaps I should bisect in _SST and put in the debug lines there?
>
>Here's another idea, which is a terrible hack.  But there are lots of
>lines in the DSDT like
>   If (LOr (SPS, WNTF))
>which I imagine is saying "If something or if WinNT".  So, 
>what if Linux
>pretends to be WinNT (or W98F -- which is another common 
>test), at least
>for the 600x?  Maybe those code paths are known to work.
>
Yes, you can try that.

Thanks,
Luming
