Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292659AbSBZSxB>; Tue, 26 Feb 2002 13:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292666AbSBZSww>; Tue, 26 Feb 2002 13:52:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19722 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292659AbSBZSwk>;
	Tue, 26 Feb 2002 13:52:40 -0500
Message-ID: <3C7BD91C.3B758704@zip.com.au>
Date: Tue, 26 Feb 2002 10:51:08 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: christophe =?iso-8859-1?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 3c59x and cardbus
In-Reply-To: <20020226173038.GD803@ufies.org> <3C7BC897.8D607D08@zip.com.au> <20020226175819.GE803@ufies.org>,
		<20020226175819.GE803@ufies.org> <20020226181510.GF803@ufies.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christophe barbé wrote:
> 
> Ok I have found why.
> When I resinsert the card, the driver give it a new id (this driver
> supports multiple cards) and the option as I set it is only defined for
> the card #0. I would expect that the driver give the same id back.
> 

hrm.  OK, hotplugging and slot-positional module parameters weren't
designed to live together.

This should fix it for single cards.   For multiple cards, you'll
have to make sure you eject them in reverse scan order :)

Index: drivers/net/3c59x.c
===================================================================
RCS file: /opt/cvs/lk/drivers/net/3c59x.c,v
retrieving revision 1.74.2.7
diff -u -r1.74.2.7 3c59x.c
--- drivers/net/3c59x.c	2002/02/13 21:03:03	1.74.2.7
+++ drivers/net/3c59x.c	2002/02/26 18:49:24
@@ -2898,6 +2898,9 @@
 		BUG();
 	}
 
+	if (vp->card_idx == vortex_cards_found)
+		vortex_cards_found--;
+
 	vp = dev->priv;
 
 	/* AKPM: FIXME: we should have


-
