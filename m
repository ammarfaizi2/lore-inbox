Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287303AbSAHL5d>; Tue, 8 Jan 2002 06:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287427AbSAHL5X>; Tue, 8 Jan 2002 06:57:23 -0500
Received: from CPE-203-51-31-41.nsw.bigpond.net.au ([203.51.31.41]:59641 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S287303AbSAHL5N>; Tue, 8 Jan 2002 06:57:13 -0500
Message-ID: <3C36460E.BC6BDAF3@eyal.emu.id.au>
Date: Sat, 05 Jan 2002 11:17:18 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jacek =?iso-8859-1?Q?Pop=B3awski?= <jpopl@interia.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: eepro (82595) question
In-Reply-To: <20020104211952.A3508@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jacek Pop³awski wrote:
> 
> I have two 82595FX Ethernet ISA cards. I can load eepro module with

eepro.c is broken in 2.2.19 (and for a while before that).

A minor update went into 2.2.20.

Major updates are in the works now (e.g. see 2.2.21-pre2).

As for the 2.2.19/2.2.20 version, if you want it to recognise
more that one card then apply this simple fix to init_module():
                d->mem_end      = mem[n_eepro];
                d->base_addr    = io[0];
                d->irq          = irq[n_eepro];
                d->init         = eepro_probe;
Change the [0] to [n_eepro] in the second line. But this version
is still unstable under load!

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
