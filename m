Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317402AbSHGNoo>; Wed, 7 Aug 2002 09:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317945AbSHGNon>; Wed, 7 Aug 2002 09:44:43 -0400
Received: from zeus.kernel.org ([204.152.189.113]:3488 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S317402AbSHGNom>;
	Wed, 7 Aug 2002 09:44:42 -0400
Date: Wed, 7 Aug 2002 09:44:30 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: PCI hotplug resource reservation 
In-Reply-To: <10045.1028720321@redhat.com>
Message-ID: <Pine.LNX.4.33.0208070906270.18786-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, David Woodhouse wrote:

>
> scottm@somanetworks.com said:
> > However, in my quest to avoid duplicating the piles of resource
> > manipulation code in the Compaq and IBM hotplug drivers, and use the
> > PCI API in the fashion of the Cardbus driver, I've had to implement an
> > idea mentioned to me by David Woodhouse at OLS, namely boot-time PCI
> > resource reservation.
>
> ISTR I referred to that as an evil hack.

I agree that it's a hack, but after digging around in the PCI code over
the last month and a half it has grown on me. :)

> Is there any particular reason why you can't assign random bits of address
> space to cards and simply fix up the bridges accordingly so that
> transactions for that range are forwarded?

Yes, that idea doesn't work all the time.  If you let pci_assign_resource
allocate from the root of the resource tree, you will get all the resources
you want no problem.  However, it's entirely possible that you will be
allocated resource ranges that are intermingled with the ranges that are
behind other bridges or devices.  There's no sane way to program the
hotplug bridge's BARs in such a situation.

As I said above, I agree that the reservation scheme is hackish, but since
there's no clear way (to me at least) to rework the resource allocation
system to handle this problem, I feel its advantages outweigh its
disadvantages at the moment.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

