Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263118AbTDLDWD (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 23:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbTDLDWD (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 23:22:03 -0400
Received: from 000-028-418.area1.spcsdns.net ([68.24.111.225]:14720 "EHLO
	digitasaru.net") by vger.kernel.org with ESMTP id S263118AbTDLDWC (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 23:22:02 -0400
Date: Fri, 11 Apr 2003 22:32:38 -0500
From: Joseph Pingenot <trelane@digitasaru.net>
To: linux-kernel@vger.kernel.org
Subject: Re: toshiba 1605/1625 hibernation issues [problem with ALi 15x3 driver]
Message-ID: <20030412033232.GB887@digitasaru.net>
Reply-To: trelane@digitasaru.net
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-School: University of Iowa
X-vi-or-emacs: vi *and* emacs!
X-MSMail-Priority: High
X-Priority: 1 (Highest)
X-MS-TNEF-Correlator: <AFJAUFHRUOGRESULWAOIHFEAUIOFBVHSHNRAIU.monkey@spamcentral.invalid>
X-MimeOLE: Not Produced By Microsoft MimeOLE V5.50.4522.1200
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[forwarded for posterity]
[From: Joseph Pingenot <trelane@digitasaru.net>]
[To: Gary Schulte <xxx@xxx.org>]
[Subject: Re: toshiba 1605/1625 hibernation issues]


>From Gary Schulte on Thursday, 10 April, 2003:
>Hi Joseph,
>Did you ever get resolution on this problem?  I am experiencing it as 
>well and can't decide what the problem is...
>Thanks in advance,

Yup.
Well, actually, it's a workaround, not a fix.
Remove support for the ALi 15x3 chipset support (under IDE drivers).  Just
  use the generic.
Here's the tradeoff: ALi 15x3-enabled kernels allows the laptop to do DMA.
  However, you can't suspend (it freezes).  Without the ALi 15x3 stuff, it
  doesn't do DMA, but it suspends to disk.
The workaround is to have one kernel with ALi 15x3 enabled.  This will
  somehow let the BIOS know that it's OK to do DMA, and, until you do a
  harder reboot than just using the reboot command, even non-specialized
  kernels (i.e., without ALi 15x3) will then do DMA.  So, you boot up your
  specialized DMA kernel, then, once you get to the appropriate point (I
  wait until disks have been mounted), you CTRL+ALT+DEL reboot (or use the
  reboot command) into your generic IDE kernel.  Then you have DMA (at least
  theoretically) *and* can suspend to disk.
If anyone can give me sufficient documentation, I might be able to poke
  around in the 15x3 driver and maybe see what's being broken.
  Unfortunately, nobody's giving me (nor does semi-assinine "we don't
  support the Linux platform" Toshiba seem anything more than extremely
  reluctant to give me) [or at least give a proper kernel developer] the
  specs to make the 15x3 driver play nice with the BIOS/laptop in general.
  *sigh*.

So, until Toshiba gets around to it, or somebody stumbles upon the proper
  documentation, the workaround is all we've got.  :(
Luckily, I've managed to get everything else on the laptop working [with
  the exception of some weird lid-closing-freezes-things problem] working
  on my Satellite 1605CDS, in case you have any questions.

May I bounce this to the linux-kernel list for posterity?

-Joseph
-- 
Joseph===============================================trelane@digitasaru.net
" I'm all for using the best tool for the job, but what happens when the
 restrictions that go along with that tool take away your rights? I believe
 it then stops being the best tool for the job."  --randy@digitalrights.org

----- End forwarded message -----

-- 
Joseph===============================================trelane@digitasaru.net
" I'm all for using the best tool for the job, but what happens when the
 restrictions that go along with that tool take away your rights? I believe
 it then stops being the best tool for the job."  --randy@digitalrights.org
