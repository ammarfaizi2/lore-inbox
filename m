Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292562AbSBTWwe>; Wed, 20 Feb 2002 17:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292559AbSBTWwZ>; Wed, 20 Feb 2002 17:52:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23054 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292563AbSBTWwN>; Wed, 20 Feb 2002 17:52:13 -0500
Subject: Re: ioremap()/PCI sickness in 2.4.18-rc2 (FIXED ALMOST)
To: jmerkey@vger.timpanogas.org (Jeff V. Merkey)
Date: Wed, 20 Feb 2002 23:06:17 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
In-Reply-To: <20020220152011.A1252@vger.timpanogas.org> from "Jeff V. Merkey" at Feb 20, 2002 03:20:11 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dfoX-00050r-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sigh .... I am only using 2 GB on a 4GB capable processor (actually 
> a 64 GB capable processor).  Looks like a patch is needed.  Who is 
> maintaining vmalloc.c at present so I know who to submit a patch 
> to?

Actually you are using a 64Gb capable processor that is only capable of 
sanely addressing 4Gb at a time, total across both user and kernel space
and takes a hefty hit whenever you switch which 4Gb you are peering at.

If you want to make sensible use of even 4Gb user/4Gb kernel you need to
take a page table reload at syscall time and deal with quite messy handling
for copy to/from user. 

[If someone from Intel disagrees please do so publically - I'd love to have
 someone prove the limit can be dealt with 8)]
