Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272064AbTHSP4g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 11:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270850AbTHSPzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 11:55:43 -0400
Received: from zeus.kernel.org ([204.152.189.113]:64226 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272341AbTHSPyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 11:54:51 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: weird pcmcia problem
References: <87u18efpsc.fsf@mcs.anl.gov>
	<20030819124547.B18205@flint.arm.linux.org.uk>
From: Narayan Desai <desai@mcs.anl.gov>
Date: Tue, 19 Aug 2003 09:19:38 -0500
In-Reply-To: <20030819124547.B18205@flint.arm.linux.org.uk> (Russell King's
 message of "Tue, 19 Aug 2003 12:45:47 +0100")
Message-ID: <87wud9ybk5.fsf@mcs.anl.gov>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Common Lisp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Russell" == Russell King <rmk@arm.linux.org.uk> writes:

  Russell> On Mon, Aug 18, 2003 at 07:34:59PM -0500, Narayan Desai
  Russell> wrote:
  >> Running 2.6.0-test3 (both with and without your recent yenta
  >> socket patches) pcmcia cards present during boot don't show up
  >> until they are removed and reinserted. Once reinserted, they work
  >> fine. This only seems to occur if yenta_socket is build into the
  >> kernel; if support is modular, cards appear to be recognized
  >> properly at boot time. I am running on a thinkpad t21.  Let me
  >> know if I can help with this problem in any way...  thanks

  Russell> As a general thing, when people report this problem (or any
  Russell> other problem), can they please include at least the
  Russell> following details please:

  Russell> - make/model of machine
  Russell> - type of cardbus bridge (from lspci)
  Russell> - type of card (pcmcia or cardbus)
  Russell> - make/model of card
  Russell> - full kernel dmesg (including yenta, card services
  Russell>   messages)
  Russell> - cardmgr messages from system log

This is an IBM thinkpad t21. the cardbus bridge is:
00:02.0 CardBus bridge: Texas Instruments PCI1450 (rev 03)
00:02.1 CardBus bridge: Texas Instruments PCI1450 (rev 03)

The problem is occurring with an orinoco gold pcmcia card.

the unable to map cs memory errors were the only odd thing in the
kernel messages, and it looks like your diagnosis was right on the
money. i these cardmgr messages:
Aug 18 20:38:06 topaz cardmgr[374]: watching 2 sockets
Aug 18 20:38:06 topaz cardmgr[375]: starting, version is 3.2.2
Aug 18 20:38:06 topaz cardmgr[375]: socket 0: Anonymous Memory
Aug 18 20:38:06 topaz cardmgr[375]: executing: 'modprobe memory_cs'
Aug 18 20:38:06 topaz cardmgr[375]: + FATAL: Module memory_cs not found.
Aug 18 20:38:06 topaz cardmgr[375]: modprobe exited with status 1
Aug 18 20:38:06 topaz cardmgr[375]: module /lib/modules/2.6.0-test3-p2/pcmcia/memory_cs.o not available
Aug 18 20:38:06 topaz cardmgr[375]: bind 'memory_cs' to socket 0 failed: Invalid argument

let me know if there is more info that would be useful.
 -nld

