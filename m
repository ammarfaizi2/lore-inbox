Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318317AbSGXXsp>; Wed, 24 Jul 2002 19:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318318AbSGXXsp>; Wed, 24 Jul 2002 19:48:45 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:42233 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318317AbSGXXso>; Wed, 24 Jul 2002 19:48:44 -0400
Subject: Re: [RFC/CFT] cmd640 irqlocking fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020724225826.GF25038@holomorphy.com>
References: <20020724225826.GF25038@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 02:05:11 +0100
Message-Id: <1027559111.6456.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-24 at 23:58, William Lee Irwin III wrote:
> I don't have one of these, and I'm not even sure what it is. But here's
> a wild guess at a fix.

These must be locked against any other PCI access so it needs to share
the lock with arch/i386/kernel/pci*.c. The code is also wrong for other
reasons and there are some fixes in the 2.4.19-ac tree to those
functions that affect the locking and maybe should be merged too.

What is going on here is that we have to probe the CMD640 PCI either via
PCI conf1 or PCI conf2. We cannot use the kernel default functions
because they may trigger a bug in the CMD640 hardware.

get_cmd640_reg_pci[12] are basically reimplementations of the
pci_read_config bits for type 1/type 2 PCI configurations. The register
and lock are thus the same as the core. This lock also needs to match
the same lock on non x86 platforms so the pci config lock name should be
unified now before the brown and sticky impacts on the rotating
propellor blades

