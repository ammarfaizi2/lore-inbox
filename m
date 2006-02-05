Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbWBETp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbWBETp1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 14:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWBETp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 14:45:27 -0500
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:13665 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750703AbWBETp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 14:45:27 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Date: Sun, 5 Feb 2006 11:45:22 -0800
User-Agent: KMail/1.7.1
Cc: "Carlo E. Prelz" <fluido@fluido.as>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20060120123202.GA1138@epio.fluido.as> <20060122111112.GA15320@epio.fluido.as> <20060205103333.GA27735@epio.fluido.as>
In-Reply-To: <20060205103333.GA27735@epio.fluido.as>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602051145.22933.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 05 February 2006 2:33 am, Carlo E. Prelz wrote:
> In drivers/usb/host/pci-quirks.c, in function quirk_usb_disable_ehci
> (should start around line 211) there is a stanza that reads:
> 
> 			/* always say Linux will own the hardware
> 			 * by setting EHCI_USBLEGSUP_OS.
> 			 */
> 			pci_write_config_byte(pdev, offset + 3, 1);
> 
> On my sapphire athlon64 motherboard (see the thread for more details),
> this call never returns (without generating any output). I commented
> it out, and now the EHCI subsystem works OK (currently running
> 2.6.16rc2).

Interesting ... feels like a BIOS problem.  If you want to experiment,
there's a right bracket -- "}" -- immediately before that.  Try moving
it right after that write, so that write_config_byte is covered by the
preceding "if LEGSUP_BIOS" test; or copying the much later "disable SMI"
clause into an "else" for that "if".

- Dave
