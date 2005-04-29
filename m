Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVD2Pwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVD2Pwa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 11:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbVD2Pwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 11:52:30 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:649
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262090AbVD2PwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 11:52:24 -0400
Date: Fri, 29 Apr 2005 08:42:42 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Grant Grundler <grundler@parisc-linux.org>
Cc: benh@kernel.crashing.org, grundler@parisc-linux.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       greg@kroah.com, bjorn.helgaas@hp.com, davem@redhat.com
Subject: Re: pci-sysfs resource mmap broken (and PATCH)
Message-Id: <20050429084242.38db3aeb.davem@davemloft.net>
In-Reply-To: <20050428233828.GI10171@colo.lackof.org>
References: <1114493609.7183.55.camel@gaston>
	<20050426163042.GE2612@colo.lackof.org>
	<1114555655.7183.81.camel@gaston>
	<1114643616.7183.183.camel@gaston>
	<20050428053311.GH21784@colo.lackof.org>
	<20050427223702.21051afc.davem@davemloft.net>
	<1114670353.7182.246.camel@gaston>
	<20050427235056.0bd09a94.davem@davemloft.net>
	<20050428151117.GB10171@colo.lackof.org>
	<1114728447.7182.262.camel@gaston>
	<20050428233828.GI10171@colo.lackof.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005 17:38:28 -0600
Grant Grundler <grundler@parisc-linux.org> wrote:

> I suspect the MAP_* attribute/hint needs to be passed in together
> with the mmap call if any arch (ia64?) would return a different
> virtual address depending the attribute (e.g cached vs uncached).

The only problem could me getting the generic mmap() code to
properly pass the flag down into the driver, I seem to recall
that it either does an -EINVAL or masks out any flags which
are not in the standard set.

But then again this conflicts with what I remember seeing in the
XFree86 PCI support, in that IA64 passed in such a mmap() flag
to indicate a framebuffer like mapping that didn't need a guard-like
bit to be set.

Someone should look at the code to make sure :-)

