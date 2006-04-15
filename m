Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751615AbWDOVOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWDOVOs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 17:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbWDOVOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 17:14:48 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:29706 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751615AbWDOVOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 17:14:47 -0400
Date: Sat, 15 Apr 2006 23:14:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, rmk+serial@arm.linux.org.uk
Subject: Re: modpost: serial/8250_pci warnings
Message-ID: <20060415211435.GA24887@mars.ravnborg.org>
References: <20060415111712.311372aa.rdunlap@xenotime.net> <20060415132343.544357a2.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060415132343.544357a2.rdunlap@xenotime.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2006 at 01:23:43PM -0700, Randy.Dunlap wrote:
> 
> drivers/serial/8250_pci.o has 23 section mismatch warnings.
> They are all related to (come from) this struct:
> 
> static struct pci_serial_quirk pci_serial_quirks[] = {
> 
> so maybe either "quirk" can go into the whitelist, or
> Russell can tell us if these are false positives or need to be
> fixed.
.init is referenced from pciserial_init_ports() which is NOT marked
__devinit.
And pciserial_init_ports() is exported - so it cannot be marked
__devinit => it is a bug.

	Sam
