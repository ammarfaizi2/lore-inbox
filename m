Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbVJBOT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVJBOT7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 10:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbVJBOT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 10:19:59 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:53218
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751100AbVJBOT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 10:19:59 -0400
Subject: [ANNOUNCE] ARM integration into generic interrupt system
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: LKML <linux-kernel@vger.kernel.org>
Cc: ARM Kernel <linux-arm-kernel@lists.arm.linux.org.uk>,
       Christoph Hellwig <hch@infradead.org>,
       Robert Schwebel <r.schwebel@pengutronix.de>,
       Ingo Molnar <mingo@elte.hu>, Manfred Gruber <manfred.gruber@contec.at>,
       john cooper <john.cooper@timesys.com>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 02 Oct 2005 16:21:05 +0200
Message-Id: <1128262865.15115.575.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

During a lengthy discussion on arm-linux-kernel mailing list, ARM
maintainer Russell King posted a list of requirements that any
integration of ARM into the generic interrupt layer would have to
implement:

http://marc.theaimsgroup.com/?l=linux-arm-kernel&m=110693029912801&w=2

The background of the discussion was an attempt to modify the ARM
interrupt handling code to make adaption of Ingo's Realtime Preemption
patches for ARM possible. The proposed changes were unacceptable from
Russell's point of view and also Ingo was reluctant to accept a 
non-generic version of his interrupt preemption work open-coded into the
ARM architecture.

After analysing the ARM specific interrupt code a conversion model was
integrated into the generic interrupt layer. The central point is the
seperate entry level handling of the different interrupt types in
contrast to the "all in one super handler" __do_IRQ(). The reasons and
lots of details for this seperate handling are described in the DocBook
docs of the patch along with the documentation of the resulting API. An 
online version is available here: 

  http://www.tglx.de/projects/armirq/DocBook/index.html

The patch has been tested on a broad range of ARM platforms and the
feature set requested by Russell has been verified. There is no
functional change to the other architectures which use the generic
interrupt layer, but the type dependent entry level handler seperation
also has possible benefits for those users.

The patch allows a clean porting of Ingo's Preempt-RT patches to the ARM
platform.

The patch is not intended for immediate inclusion into mainline, as
there are plans in place to get rid of a small number of quirks that are
present for the sake of 1:1 conversion of the ARM platform. If the ARM
platform iterates the first few steps alone then we can get rid of these
quirks and the generic code is not burdened with them.

The patch is published to give it a broader test base and for
integration into Ingos Realtime Preemption patch set.

Russell King committed recently a broken out set of conversion macros
and name changes which reduced the patch size significantly. He also has
some cleanups of the current ARM irq layer in mind which will solve
some 
of the quirks, and the armirq patch can provide a good test environment
for verification without breaking the whole ARM subsystem in the
mainline kernel.

There is broad consensus that the final conversion can only be done in
fine grained steps with intermediate testing periods.

The patch is available at:

http://www.tglx.de/projects/armirq/patch-2.6.14-rc3-armirq1.diff

along with a broken out patch series:

http://www.tglx.de/projects/armirq/broken-out/

http://www.tglx.de/projects/armirq/patch-2.6.14-rc3-armirq1.patches.tar.bz2

Thanks to all the people who helped with review, testing and comments
especially to Russell King, John Cooper, Robert Schwebel, Manfred Gruber
and the ARM kernel hacker folks.

  tglx, Ingo


