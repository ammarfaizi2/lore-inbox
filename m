Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261674AbVEJPUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261674AbVEJPUt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVEJPSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:18:25 -0400
Received: from hqemgate01.nvidia.com ([216.228.112.170]:51972 "EHLO
	HQEMGATE01.nvidia.com") by vger.kernel.org with ESMTP
	id S261674AbVEJPOh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:14:37 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: PPC uImage build not reporting correctly
Date: Tue, 10 May 2005 08:14:16 -0700
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B007228DB0@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PPC uImage build not reporting correctly
thread-index: AcVVGMh/1ys2NJ10TkegV9uHRISTwQAWaM0g
From: "Stephen Warren" <SWarren@nvidia.com>
To: "Sam Ravnborg" <sam@ravnborg.org>, "Kumar Gala" <kumar.gala@freescale.com>
Cc: "linuxppc-embedded list" <linuxppc-embedded@ozlabs.org>,
       "Tom Rini" <trini@kernel.crashing.org>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>,
       <cpclark@xmission.com>
X-OriginalArrivalTime: 10 May 2005 15:14:18.0903 (UTC) FILETIME=[EFE08A70:01C55572]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Sam Ravnborg
> On Mon, May 09, 2005 at 10:19:01AM -0500, Kumar Gala wrote:
> > On May 6, 2005, at 6:22 PM, <cpclark@xmission.com> wrote:
> > > Couldn't you eliminate the ($shell ..) construct altogether, like 
> > > this?:
> > >
> > > $(obj)/uImage: $(obj)/vmlinux.gz
> > > ??????? $(Q)rm -f $@
> > > ??????? $(call if_changed,uimage)
> > > ??????? @echo -n '? Image: $@'
> > > ??????? @if [ -f $@ ]; then echo 'is ready' ; else echo 'not
made'; fi
> > 
> > Yes, and this seems to actually work.
> > 
> > Sam, does this look reasonable to you.  If so I will work up a
patch.
>
> Looks ok - but I do not see why use of $(shell ...) did not work out.
> Please bring your working version forward.
 
It's because both any $(xxx) in the command will be expanded prior to
the command being executed ("command" meaning all lines in the complete
command script for the target in question - not on a line-by-line
basis).

Thus, the original $(wildcard), and also the $(shell) above are
evaluated/expanded by gmake prior to running any of the the "rm -rf",
"if_changed", and "echo" commands, and hence run before the uImage file
is created, and hence always think that it doesn't exist.

The only solution is to get the shell to do the evaluation of whether
uImage exists - that way, the evaluation is guaranteed to happen after
the uImage is (hopefully) created.

-- 
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html
