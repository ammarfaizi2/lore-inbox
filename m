Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290028AbSBKS1s>; Mon, 11 Feb 2002 13:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290017AbSBKS1i>; Mon, 11 Feb 2002 13:27:38 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:26491 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290047AbSBKS10>; Mon, 11 Feb 2002 13:27:26 -0500
Date: Mon, 11 Feb 2002 13:27:25 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: John Weber <weber@nyc.rr.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.4 Sound Driver Problem
Message-ID: <20020211132725.A18726@devserv.devel.redhat.com>
In-Reply-To: <E16aKwN-0007Ro-00@the-village.bc.nu> <3C6809C2.1030808@nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C6809C2.1030808@nyc.rr.com>; from weber@nyc.rr.com on Mon, Feb 11, 2002 at 01:13:22PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Mon, 11 Feb 2002 13:13:22 -0500
> From: John Weber <weber@nyc.rr.com>

> I am looking at both 2.5.4 and 2.4.18-pre9.

OK. Marcelo is not removing virt_to_bus any time soon, so ymfpci
in 2.4.18 is not going to have it removed. There were some other
interesting fixes, so I want 2.4.18 to be testing those. Sure,
for 2.4.19 I can add pci_alloc_XXX. The patch to do it is in my
tree and I am using it on my laptop. It is not a priority though.

Linus tree is different. I feel pretty safe dumping all fixes
that I receive into it as soon as they get tested on my laptop.
If his sound stops working, he'll let me know pretty quick.
Thus, the ymfpci in 2.5.4 uses pci_alloc_consistent.

> In my copy of sound_alloc_dmap(), I see a direct call to 
> __get_free_pages to allocate the buffer and a call to virt_to_bus.

This is wonderful, but how is this related to ymfpci?
Config.in makes you to build sound.o if you select
CONFIG_SOUND_YMFPCI, but that's pretty irrelevant.
The ymfpci should load fine without sound.o, it only needs
soundcore.o.

OTOH, if you just want to fix dmabuf.c, by all means be my guest.

-- Pete

P.S. I changed i810_audio to use pci_alloc_consistent too, it is
somewhere in dledford's queue.
