Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262105AbSJNTIG>; Mon, 14 Oct 2002 15:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262106AbSJNTIG>; Mon, 14 Oct 2002 15:08:06 -0400
Received: from gate.perex.cz ([194.212.165.105]:12813 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S262105AbSJNTID>;
	Mon, 14 Oct 2002 15:08:03 -0400
Date: Mon, 14 Oct 2002 21:10:04 +0200 (CEST)
From: Jaroslav Kysela <perex@perex.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Adam Belay <ambx1@neo.rr.com>
cc: "torvalds@transmeta.com" <torvalds@transmeta.com>,
       "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
       "greg@kroah.com" <greg@kroah.com>,
       "jdthood@yahoo.co.uk" <jdthood@yahoo.co.uk>,
       "boissiere@nl.linux.org" <boissiere@nl.linux.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PnP Layer Rewrite V0.7 - 2.4.42
In-Reply-To: <20021014135452.GB444@neo.rr.com>
Message-ID: <Pine.LNX.4.33.0210142101000.7202-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, Adam Belay wrote:

> Linux Plug and Play Rewrite V0.7
>
> After much testing the Linux PnP Rewrite is ready to be included. For
> those who would like to try it, be sure to enable debugging or else it
> will operate silently. Also enable both PnP protocols.

A few notes. Please, could you leave the raw proc interface for ISA PnP?
I mean isapnp_proc_bus_read() function. Also, encoding device/vendor to 
7-byte string seems like wasting bytes and CPU cycles. If you use 2/2 byte 
format, you'll spare 3 bytes and comparing of two short values (or one 
int value) is always less expensive.

Anyway, I like this code. It seems that you don't use standard pci_dev / 
pci_bus structures as I was forced by Linus at ISA PnP code inclusion 
time. But it's true that we have new device model, so these things might 
be private. Also, don't forget to remove additional ISA PnP members from 
pci structures when Linus approves pnp_dev and pnp_card structures.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

