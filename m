Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbTIDWxu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265449AbTIDWxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:53:50 -0400
Received: from ozlabs.org ([203.10.76.45]:29592 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264894AbTIDWxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:53:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16215.49718.212936.125402@nanango.paulus.ozlabs.org>
Date: Fri, 5 Sep 2003 08:52:38 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Jake Moilanen <moilanen@austin.ibm.com>, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] linux-2.4.22 pci-scan-all-functions
In-Reply-To: <Pine.A41.4.51.0309041015390.27258@wolverines.austin.ibm.com>
References: <Pine.A41.4.51.0309041015390.27258@wolverines.austin.ibm.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jake Moilanen writes:

> This patch is a port of some work that Anton Blanchard did for 2.6.
> 
> While doing a pci scan there are some architechtures that can have
> multifunction devices that do not respond to function 0.  In that case we
> must scan all functions.

I should point out that this is not because we actually have PCI
devices that don't respond to function 0, which would be contrary to
the PCI spec.  What is happening here is that with logical
partitioning on ppc64 boxes, we can have function 0 of a PCI-PCI
bridge assigned to one partition and function 2 (for example) assigned
to a different partition.  On the second partition it looks like
function 2 exists but function 0 doesn't (since we can't access it).

Paul.
