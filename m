Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265748AbRGDOWG>; Wed, 4 Jul 2001 10:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265802AbRGDOV4>; Wed, 4 Jul 2001 10:21:56 -0400
Received: from pulsar.zoreil.com ([212.43.230.120]:4360 "EHLO
	pulsar.zoreil.com") by vger.kernel.org with ESMTP
	id <S265748AbRGDOVt>; Wed, 4 Jul 2001 10:21:49 -0400
Date: Wed, 4 Jul 2001 16:18:45 +0200
From: =?iso-8859-1?Q?Fran=E7ois_romieu?= <romieu@zoreil.com>
To: "Robert J.Dunlop" <rjd@xyzzy.clara.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New FarSync T-Series driver
Message-ID: <20010704161845.A27070@zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010703182803.A13853@xyzzy.clara.co.uk>
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Tue, Jul 03, 2001 at 06:28:03PM +0100, Robert J.Dunlop wrote :
[...]
> Sorry for the big post, but I posted URLs for an earlier version of this
> a couple of months back and got very little feedback.  I know sync card
> drivers ain't sexy.

Just my HO:
* error_1, error_2... error_n labels are ugly;
* ioremap may fail;
* mix of spin_lock and FST_LOCK isn't nice (kill the latter ?);
* 
+                offset = BUF_OFFSET ( rxBuffer[pi][i]);
[...]
+                                card->mem + BUF_OFFSET ( rxBuffer[pi][rxp][0]),

A bit of a macro abuse imho.

*
+        if ( ++port->txpos >= NUM_TX_BUFFER )
+                port->txpos = 0;

Why not:
port->txpos++;
foo = port->txpos%NUM_TX_BUFFER;

--
Ueimor
