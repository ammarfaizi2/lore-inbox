Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279981AbRLWL3E>; Sun, 23 Dec 2001 06:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286868AbRLWL2y>; Sun, 23 Dec 2001 06:28:54 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:57612 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S279981AbRLWL2g>;
	Sun, 23 Dec 2001 06:28:36 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Vasil Kolev <lnxkrnl@mail.ludost.net>
Cc: linux-kernel@vger.kernel.org, sten_wang@davicom.com.tw,
        jgarzik@mandrakesoft.com
Subject: Re: [2.4.17] net/network.o(.text.lock+0x1a88): undefined reference to `local symbols... 
In-Reply-To: Your message of "Sun, 23 Dec 2001 12:27:50 +0200."
             <Pine.LNX.4.33.0112231226260.1032-100000@doom.bastun.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Dec 2001 22:28:19 +1100
Message-ID: <23624.1009106899@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Dec 2001 12:27:50 +0200 (EET), 
Vasil Kolev <lnxkrnl@mail.ludost.net> wrote:
># ./reference_discarded.pl
>Finding objects, 538 objects, ignoring 0 module(s)
>Finding conglomerates, ignoring 48 conglomerate(s)
>Scanning objects
>Error: ./drivers/net/dmfe.o .data refers to 00000514 R_386_32
>.text.exit
>Done

AFAICT dmfe.c is hotplug aware, it has the required probe and remove
pci_driver functions.  But dmfe_remove_one is defined as __exit instead
of __devexit, it should probably be changed to __devexit and change
        remove: dmfe_remove_one
to
        remove:         __devexit_p(dmfe_remove_one)

The dmfe maintainer and/or Jeff Garzik needs to decide.

