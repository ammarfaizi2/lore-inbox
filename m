Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318182AbSHIIDF>; Fri, 9 Aug 2002 04:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318184AbSHIIDF>; Fri, 9 Aug 2002 04:03:05 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:26557 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318182AbSHIIDE>; Fri, 9 Aug 2002 04:03:04 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Grant Grundler <grundler@dsl2.external.hp.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: PCI<->PCI bridges, transparent resource fix
Date: Fri, 9 Aug 2002 10:06:30 +0200
Message-Id: <20020809080630.13608@smtp.wanadoo.fr>
In-Reply-To: <20020808153042.B14158@jurassic.park.msu.ru>
References: <20020808153042.B14158@jurassic.park.msu.ru>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>-	} else {
>-		/*
>-		 * Ugh. We don't know enough about this bridge. Just assume
>-		 * that it's entirely transparent.
>-		 */
>-		printk(KERN_ERR "Unknown bridge resource %d: assuming transparent\n", 0);
>-		child->resource[0] = child->parent->resource[0];
> 	}

BTW, in the case of really closed resources, you just removed the "else"
case. I don't have the kernel sources at hand at the moment (still
on vacation ;) So I can't check how pci_dev is initialized on alloc,
but shouldn't we make sure the resoure pointer of the child is either
NULL or points to some properly zeroed out resource structure ?

I know the "closed resources" patch we used to have in some PPC kernel
trees did that explicitely in the "else" case here.

Ben.


