Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315178AbSHMLo4>; Tue, 13 Aug 2002 07:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315179AbSHMLo4>; Tue, 13 Aug 2002 07:44:56 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:62455 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315178AbSHMLoz>; Tue, 13 Aug 2002 07:44:55 -0400
Subject: Re: [patch] PCI Cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: colpatch@us.ibm.com
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Martin Bligh <mjbligh@us.ibm.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Greg KH <gregkh@us.ibm.com>
In-Reply-To: <3D584DF8.9020206@us.ibm.com>
References: <3D584DF8.9020206@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Aug 2002 12:45:33 +0100
Message-Id: <1029239133.20980.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-13 at 01:08, Matthew Dobson wrote:

> -	if (!value) 
> -		return -EINVAL;
> -
> -	result = pci_conf1_read(0, dev->bus->number, PCI_SLOT(dev->devfn), 
> -		PCI_FUNC(dev->devfn), where, 2, &data);
> -

This stil has the same problems as it did last time you posted it. The
pointless NULL check and the increased complexity over duplicating about
60 lines of code and having pci_conf1 ops cleanly as we do in 2.4.

The !value check is extremely bad because it turns a critical debuggable
software error into a silent unnoticed mistake.

Fixing the code instead of just resending it might improve the changes
of it being merged no end.

Alan

