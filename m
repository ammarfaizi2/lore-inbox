Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319200AbSHGTBN>; Wed, 7 Aug 2002 15:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319201AbSHGTBM>; Wed, 7 Aug 2002 15:01:12 -0400
Received: from zeus.kernel.org ([204.152.189.113]:8935 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S319200AbSHGTBL>;
	Wed, 7 Aug 2002 15:01:11 -0400
Date: Wed, 7 Aug 2002 15:01:00 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: PCI hotplug resource reservation 
In-Reply-To: <22223.1028728103@redhat.com>
Message-ID: <Pine.LNX.4.33.0208071214230.21045-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, David Woodhouse wrote:

>
> scottm@somanetworks.com said:
> >  However, it's entirely possible that you will be allocated resource
> > ranges that are intermingled with the ranges that are behind other
> > bridges or devices.  There's no sane way to program the hotplug
> > bridge's BARs in such a situation.
>
> Why? Can't you just forward transactions for the whole of the range,
> including some addresses which are actually behind other bridges?

My copy of "PCI System Architecture, 4th Edition", say on the top of
page 379:

  On power-up, the system must be automatically configured so that each
  device's IO and memory functions occupy mutually-exclusive address
  ranges.

There's no detail on what happens if you violate this, however.  Digging
out the "PCI Local Bus Specification, Revision 2.2", section 3.2.2 (page
27) says:

  When a transaction is initiated on the interface, each potential target
  compares the address with its Base Address register(s) to determine if
  it is the target of the current transaction.  If it is the target, the
  device asserts DEVSEL# to claim the access. For more details about
  DEVSEL# generation, refer to Section 3.6.1.

May take on that, as well as a quick read of section 3.6.1, is that
multiple targets claiming an address results in undefined behaviour,
since no mechanisms for handling that are defined in the spec.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com


