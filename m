Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTH0RRR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 13:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTH0RRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 13:17:17 -0400
Received: from chaos.analogic.com ([204.178.40.224]:23424 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263475AbTH0RRP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 13:17:15 -0400
Date: Wed, 27 Aug 2003 13:17:15 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Laurent =?iso-8859-1?q?Hug=E9?= <laurent.huge@wanadoo.fr>
cc: herbert@13thfloor.at, Stuart MacDonald <stuartm@connecttech.com>,
       "'Russell King'" <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Reading accurate size of recepts from serial port
In-Reply-To: <200308271853.18821.laurent.huge@wanadoo.fr>
Message-ID: <Pine.LNX.4.53.0308271312060.2174@chaos>
References: <005c01c36bdd$8ae58d30$294b82ce@stuartm> <200308261723.04683.laurent.huge@wanadoo.fr>
 <20030827145041.GC26817@www.13thfloor.at> <200308271853.18821.laurent.huge@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003, Laurent [iso-8859-1] Hugé wrote:

> Le Mercredi 27 Août 2003 16:50, Herbert Pötzl a écrit :
> > hmm, why not do simple framing ...
> > [length]<data>[length]<data> ....
> That's impossible. CCSDS is the committee for space date systems and it
> provides standards that I can't overrule (even if I can't really understand
> why they've done it like that !).
> --
> Laurent Hugé.
>

The transfer frame in your reference specified, contains all
the information necessary for the protocol, even if it's stupid
to use that protocol on a RS-232C link. Nevertheless, there is
a minimim size for the header (5 octets in length). There is
also the 3 octets used for sync, which I'm pretty sure will
not be put onto the RS-232C links. Anyway, you need to read
40 bytes (always), from that, you will learn the length
of the rest of the data. So you use poll()/read() until you
get that header information. Then you will know what the
total read-length should be.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


