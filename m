Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWBFIDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWBFIDD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750737AbWBFIDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:03:03 -0500
Received: from fluido.speedxs.nl ([83.98.238.192]:63246 "EHLO fluido.as")
	by vger.kernel.org with ESMTP id S1750723AbWBFIDB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:03:01 -0500
Date: Mon, 6 Feb 2006 09:02:51 +0100
From: "Carlo E. Prelz" <fluido@fluido.as>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Message-ID: <20060206080251.GA23014@epio.fluido.as>
References: <20060120123202.GA1138@epio.fluido.as> <20060122111112.GA15320@epio.fluido.as> <20060205103333.GA27735@epio.fluido.as> <200602051145.22933.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <200602051145.22933.david-b@pacbell.net>
X-operating-system: Linux epio 2.6.14
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Subject: Re: [linux-usb-devel] Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
	Date: dom 05 feb 06 11:45:22 -0800

Quoting David Brownell (david-b@pacbell.net):

> Interesting ... feels like a BIOS problem.  If you want to experiment,
> there's a right bracket -- "}" -- immediately before that.  Try moving
> it right after that write, so that write_config_byte is covered by the
> preceding "if LEGSUP_BIOS" test; or copying the much later "disable SMI"
> clause into an "else" for that "if".

The first one would be useless - I inserted lots of printouts to find
out where the freeze took place, and I know that the 
EHCI_USBLEGSUP_BIOS flag is on (cap is 0x10001). The value remains the
same after the 'spin till it hands it over' loop - so that this
printout appears:

0000:00:13.2 EHCI: BIOS handoff failed (BIOS bug ?)

About the second thing you suggest: do you refer to this call?

			/* just in case, always disable EHCI SMIs */
			pci_write_config_dword(pdev,
					offset + EHCI_USBLEGCTLSTS,
					0);

In my machine, the write takes place without apparent ill effects. If
I add it as an else clause to the "if LEGSUP_BIOS" test, it won't
execute, because the EHCI_USBLEGSUP_BIOS flag is on.

In case you need it: hcc_params is 0xa012. 

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)
