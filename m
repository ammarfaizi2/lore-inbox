Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263418AbTC2OBe>; Sat, 29 Mar 2003 09:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263420AbTC2OBd>; Sat, 29 Mar 2003 09:01:33 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:14040 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S263418AbTC2OBc>;
	Sat, 29 Mar 2003 09:01:32 -0500
Date: Sat, 29 Mar 2003 15:12:45 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@digeo.com>
Cc: "J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br, vortex@scyld.com
Subject: Re: Bad PCI IDs-Names table in 3c59x.c
Message-ID: <20030329141245.GA2560@werewolf.able.es>
References: <20030329013022.GA2711@werewolf.able.es> <20030328183836.36ccd14b.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030328183836.36ccd14b.akpm@digeo.com>; from akpm@digeo.com on Sat, Mar 29, 2003 at 03:38:36 +0100
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.29, Andrew Morton wrote:
> "J.A. Magallon" <jamagallon@able.es> wrote:
> >
> > +	{ 0x10B7, 0x1201, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C982A },
> > +	{ 0x10B7, 0x1202, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C982B },
> 
> OK.  I'm a bit mystified as to how these ID's got lost.  They do not appear
> in Donald's latest driver, so I assume the catchall PCI ID match picked them
> up.  
> 
> The mainstream PCI code does not have the catchall capability.
> 
> Keeping that big device table in sync is a real pain, which is why it has
> been kept grouped into batches of five entries.  
> 
> Donald's driver describes 0x9805 as a "3c982 Server Tornado".  What makes you
> think it is a "3c980 Python-T"?
> 

That is what is labeled in the card, and as I said before, that it has _only_
one RJ45 connector, so it hardly can be a "Dual Port" card ;).

pci.ids has this:

10b7  3Com Corporation
    ...
    9805  3c980-TX 10/100baseTX NIC [Python-T]
        10b7 1201  3c982-TXM 10/100baseTX Dual Port A [Hydra]
        10b7 1202  3c982-TXM 10/100baseTX Dual Port B [Hydra]
        10b7 9805  3c980 10/100baseTX NIC [Python-T]

and my card gives:

(lspci -n)
00:12.0 Class 0200: 10b7:9805 (rev 78)
(lspci -v)
00:12.0 Ethernet controller: 3Com Corporation 3c980-TX 10/100baseTX NIC [Python-T] (rev 78)
        Subsystem: 3Com Corporation: Unknown device 1000

Donald's driver has:
    { 0x10B7, 0x9800, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C980 },
    { 0x10B7, 0x9805, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_3C9805 },
...
    {"3c980 Cyclone",
     PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },
    {"3c982 Dual Port Server Cyclone",
     PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_HWCKSM, 128, },

ie, associates 0x10B7, 0x9805 with "3c982 Dual Port Server Cyclone".


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Bamboo) for i586
Linux 2.4.21-pre6-jam1 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))
