Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSGYO3q>; Thu, 25 Jul 2002 10:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSGYO3q>; Thu, 25 Jul 2002 10:29:46 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:27133 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314634AbSGYO3p>; Thu, 25 Jul 2002 10:29:45 -0400
Subject: Re: PCI config locking (WAS Re: [RFC/CFT] cmd640 irqlocking fixes)2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andre Hedrick <andre@linux-ide.org>, martin@dalecki.de,
       Vojtech Pavlik <vojtech@suse.cz>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020725141811.29565@192.168.4.1>
References: <20020725133918.37@192.168.4.1> 
	<20020725141811.29565@192.168.4.1>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 Jul 2002 16:45:15 +0100
Message-Id: <1027611916.9488.79.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-25 at 15:18, Benjamin Herrenschmidt wrote:
> So there seem to be a problem with your patch: pci_config_lock appears
> to be an x86-only thing that lives deep inside arch/i386/xxx/pci-pc.c
> (xxx beeing kernel or pci)
> 
> On the other hand, there is already such a lock provided by
> drivers/pci/access.c (pci_lock). You should probably fix your patch
> to use that one. (and eventually get rid of the pci_config_lock
> in x86, provided I didn't miss something else). But does anybody
> but x86 uses CMD640 ? :)

Possibly. I don't know. The lock in question we want is the config lock.
We are issuing configuration cycles so must lock against a parallel
issue of I/O to the configuration ports.


