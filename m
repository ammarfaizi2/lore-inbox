Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWBEKdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWBEKdx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 05:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWBEKdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 05:33:53 -0500
Received: from fluido.speedxs.nl ([83.98.238.192]:47628 "EHLO fluido.as")
	by vger.kernel.org with ESMTP id S1751397AbWBEKdx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 05:33:53 -0500
Date: Sun, 5 Feb 2006 11:33:33 +0100
From: "Carlo E. Prelz" <fluido@fluido.as>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Message-ID: <20060205103333.GA27735@epio.fluido.as>
References: <20060120123202.GA1138@epio.fluido.as> <20060121010932.5d731f90.akpm@osdl.org> <20060121125741.GA13470@epio.fluido.as> <20060121125822.570b0d99.akpm@osdl.org> <20060122074034.GA1315@epio.fluido.as> <20060121235546.68f50bd5.akpm@osdl.org> <20060122111112.GA15320@epio.fluido.as>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060122111112.GA15320@epio.fluido.as>
X-operating-system: Linux epio 2.6.14
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Time has passed without further mention of this problem. Today I took
some time to discover exactly where the boot process was hanging. I
found the place. 

In drivers/usb/host/pci-quirks.c, in function quirk_usb_disable_ehci
(should start around line 211) there is a stanza that reads:

			/* always say Linux will own the hardware
			 * by setting EHCI_USBLEGSUP_OS.
			 */

			pci_write_config_byte(pdev, offset + 3, 1);

On my sapphire athlon64 motherboard (see the thread for more details),
this call never returns (without generating any output). I commented
it out, and now the EHCI subsystem works OK (currently running
2.6.16rc2).

I do not know what the right patch should be. 

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)
