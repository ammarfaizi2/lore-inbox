Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293229AbSBWWZX>; Sat, 23 Feb 2002 17:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293230AbSBWWZM>; Sat, 23 Feb 2002 17:25:12 -0500
Received: from coruscant.franken.de ([193.174.159.226]:58026 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S293227AbSBWWY5>; Sat, 23 Feb 2002 17:24:57 -0500
Date: Sat, 23 Feb 2002 23:10:08 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Raphael Derosso Pereira - DephiNit <dephinit@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changing PCI board's IRQ
Message-ID: <20020223231008.W23307@sunbeam.de.gnumonks.org>
In-Reply-To: <E16cECu-0000Lh-00@mushroom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E16cECu-0000Lh-00@mushroom>; from dephinit@softhome.net on Sat, Feb 16, 2002 at 09:25:27PM -0200
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Setting Orange, the 50th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2002 at 09:25:27PM -0200, Raphael Derosso Pereira - DephiNit wrote:
> Hello,
> 
> One computer that I administer have a IRQ conflict between a sound card and a 
> ethernet card. Both share the IRQ 11.
> I don't have physical access to the computer, so I tried to change the IRQ 
> using the 'setpci' command.
> 
> # setpci -v -s 0:7.5 INTERRUPT_LINE=08
> 00:07.5:3c 08
> #


well, this is obviously the wrong solution.  If both boards are PCI boards,
they can easily share the IRQ between them. 

If one of the boards is an ISA device, configure your BIOS correctly 
(i.e. telling it that IRQ11 is used by a non-pnp legacy ISA device).

> So, it seems that either I cannot change the Interrupt line number throught 
> software (and the -H1 is tricky) or the /proc/pci (and /proc/bus/pci) is not 
> getting updated.

You can't just change the IRQ in pci config space.  You will not change the
real IRQ mapping but just somthing the BIOS wrote there during initialization.

> Is that a problem or am I missing the point?
> 
-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+ 
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)
