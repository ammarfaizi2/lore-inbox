Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314680AbSHIRNd>; Fri, 9 Aug 2002 13:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314811AbSHIRNd>; Fri, 9 Aug 2002 13:13:33 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:23821 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S314680AbSHIRNd>; Fri, 9 Aug 2002 13:13:33 -0400
Date: Fri, 9 Aug 2002 21:16:52 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Grant Grundler <grundler@dsl2.external.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       "David S. Miller" <davem@redhat.com>
Subject: Re: PCI<->PCI bridges, transparent resource fix
Message-ID: <20020809211652.B17979@jurassic.park.msu.ru>
References: <20020808153042.B14158@jurassic.park.msu.ru> <20020809080630.13608@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020809080630.13608@smtp.wanadoo.fr>; from benh@kernel.crashing.org on Fri, Aug 09, 2002 at 10:06:30AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 10:06:30AM +0200, Benjamin Herrenschmidt wrote:
> BTW, in the case of really closed resources, you just removed the "else"
> case. I don't have the kernel sources at hand at the moment (still
> on vacation ;) So I can't check how pci_dev is initialized on alloc,

It's zeroed.

> but shouldn't we make sure the resoure pointer of the child is either
> NULL or points to some properly zeroed out resource structure ?

I'm not sure whether it could happen in current 2.4/2.5 code, but
if pci_read_bridge_bases() is called from hotplug code, and
bridge's window changes from "enabled" to "disabled" (card removed),
then yes, we must set resource.flags = 0.

Ivan.
