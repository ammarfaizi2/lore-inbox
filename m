Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRECS2e>; Thu, 3 May 2001 14:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130820AbRECS2Y>; Thu, 3 May 2001 14:28:24 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25608 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129346AbRECS2Q>; Thu, 3 May 2001 14:28:16 -0400
Subject: Re: Possible PCI subsystem bug in 2.4
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 3 May 2001 19:31:04 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), beamz_owl@yahoo.com (Edward Spidre),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <Pine.LNX.4.21.0105031106030.30573-100000@penguin.transmeta.com> from "Linus Torvalds" at May 03, 2001 11:12:04 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vNsb-0005yf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect it would be safe to round up to the next megabyte, possibly up
> to 64MB or so. But much more would make me nervous.
> Any suggestions? 

I'd go for 1MByte simply because I've not seen an EBDA/NVRAM area that large
stuck at the top of RAM. 1Mb would fix the Dell. (It was only when I saw
your email it suddenely clicked and I grabbed the bootup log)

> > Semi related question: To do I2O properly I need to grab PCI bus space and
> > 'loan' it to the controller when I configure it. Im wondering what the
> > preferred approach there is.
> 
> Do the same thing that the yenta driver does, just do a 
> 
> 	root = pci_find_parent_resource(dev, res);
> 	allocate_resource(root, res, size, min, max, align, NULL, NULL);
> 
> and keep it allocated (and then the i2o driver can do sub-allocations
> within that resource by doing "allocate_resource(res, ...)").

Thanks.

Alan

