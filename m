Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319468AbSIGLeS>; Sat, 7 Sep 2002 07:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319470AbSIGLeS>; Sat, 7 Sep 2002 07:34:18 -0400
Received: from dsl-213-023-038-028.arcor-ip.net ([213.23.38.28]:27576 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319468AbSIGLeS>;
	Sat, 7 Sep 2002 07:34:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Todd Inglett <tinglett@vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: BUG: PCI driver 64-bit bar size
Date: Sat, 7 Sep 2002 13:41:35 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Martin Mares <mj@ucw.cz>
References: <1031249810.12740.72.camel@q.rchland.ibm.com>
In-Reply-To: <1031249810.12740.72.camel@q.rchland.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ndy4-0006Sj-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 September 2002 20:16, Todd Inglett wrote:
> Now in my case, I have an adapter that insists the upper 32-bits of a
> 64-bit BAR must be zero (don't ask me why -- doesn't make sense to me
> either, but they are indeed hard-wired).  So after plugging in ffff's
> into both BARs I effectively get 0x00000000fffff000 (again after masking
> flags).  I would expect a length of 0x1000 for this (extent 0xfff), but
> Linux computes an extent of 0xffffffffffffffff!  Since the spec says the
> length is computed from the first one bit I'll assume this is wrong. 
> The code should account for the lower dword as well as the upper.
> 
> So my fix is attached.  I chose to use pci_size() in the computation of
> the upper dword for consistency.  Perhaps there should be a defined mask
> for the upper dword in pci.h (i.e. PCI_BASE_ADDRESS_MEM_64_MASK?) rather
> than hard coding 0xffffffff.  The patch is against 2.4.20-pre4.

A bug fix like this should at least be cc'd to Marcelo.

-- 
Daniel
