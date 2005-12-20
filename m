Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVLTVOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVLTVOE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbVLTVOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:14:03 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:28431 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932116AbVLTVOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:14:00 -0500
Date: Tue, 20 Dec 2005 22:13:59 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>,
       Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: [RFC: 2.6 patch] Makefile: sound/ must come before drivers/
Message-ID: <20051220211359.GA5359@stusta.de>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org> <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local> <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de> <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <20051220202325.GA3850@stusta.de> <Pine.LNX.4.64.0512201240480.4827@g5.osdl.org> <43A86DCD.8010400@superbug.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A86DCD.8010400@superbug.co.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 08:47:09PM +0000, James Courtier-Dutton wrote:
> Linus Torvalds wrote:
> >
> >On Tue, 20 Dec 2005, Adrian Bunk wrote:
> >
> >>But the non-saa7134 access to my soundcard (e.g. rexima or xmms) is no 
> >>longer working.
> >
> >
> >Ahh. I assume it's the sequencer init etc that is missing.
> >
> >Maybe we'll just have to do the late_init thing for at least the 2.6.15 
> >timeframe.
> >
> >		Linus
> >
> 
> But that's not really a useable fix. The problem is with almost all ALSA 
> sound cards.

No, inside sound/ it's working due to the link order.

Thinking about this, what about the patch below?

I don't know whether this might break anything else, but it fixes my 
problem.

cu
Adrian


<--  snip  -->


drivers might require an already initialized sound subsystem.

Fix the link order for a static sound subsystem.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc6/Makefile.old	2005-12-20 21:53:26.000000000 +0100
+++ linux-2.6.15-rc6/Makefile	2005-12-20 21:53:42.000000000 +0100
@@ -470,7 +470,7 @@
 
 # Objects we will link into vmlinux / subdirs we need to visit
 init-y		:= init/
-drivers-y	:= drivers/ sound/
+drivers-y	:= sound/ drivers/
 net-y		:= net/
 libs-y		:= lib/
 core-y		:= usr/

