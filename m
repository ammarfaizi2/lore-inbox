Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263120AbTCWRBY>; Sun, 23 Mar 2003 12:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263121AbTCWRBY>; Sun, 23 Mar 2003 12:01:24 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34467
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263120AbTCWRBX>; Sun, 23 Mar 2003 12:01:23 -0500
Subject: Re: ISAPNP BUG: 2.4.65 ne2000 driver w. isapnp not working
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "M.H.VanLeeuwen" <vanl@megsinet.net>
Cc: mflt1@micrologica.com.hk, ambx1@neo.rr.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E7DE01B.2B6985DF@megsinet.net>
References: <3E7DE01B.2B6985DF@megsinet.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048443865.10727.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Mar 2003 18:24:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 16:26, M.H.VanLeeuwen wrote:
> NE2k ISAPNP broke around 2.5.64, again.  There are 2 parts to the attached
> patch, one to move the NIC initialization earlier in the boot sequence
> and the second is a HACK to get ne2k to work when compiled into the
> kernel, I've never tried NE2k as a module...
> 
> 1. The level of isapnp_init was moved to after apci.  Since it is now
>    after net_dev_init, ISA PNP NICs fail to initialized at boot.
> 
>    This fix allows ISA PNP NIC cards to work during net_dev_init, and still
>    leaves isapnp_init after apci_init.

We must initialise ACPI before ISAPnP because we need PCI and ACPI to
know what system resources we must not hit. How about moving the
net_dev_init to later ?


