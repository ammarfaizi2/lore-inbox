Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262841AbSJDRxb>; Fri, 4 Oct 2002 13:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262858AbSJDRxa>; Fri, 4 Oct 2002 13:53:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52742 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262841AbSJDRxa>;
	Fri, 4 Oct 2002 13:53:30 -0400
Date: Fri, 4 Oct 2002 18:59:02 +0100
From: Matthew Wilcox <willy@debian.org>
To: Carlos E Gorges <carlos@techlinux.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.40 - DMA-mapping && misc
Message-ID: <20021004185902.G18545@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- virt_to_bus(((struct scatterlist *)cmd->buffer)[i].address) :
+ virt_to_bus(
+ page_address(((struct scatterlist *)cmd->buffer)[i].page) +
+ ((struct scatterlist *)cmd->buffer)[i].offset ) :
             virt_to_bus(cmd->request_buffer);

have you actually read Documentation/DMA-mapping.txt?  It says quite plainly:

Drivers converted fully to this interface should not use virt_to_bus any
longer, nor should they use bus_to_virt. 
[...]
It is planned to completely remove virt_to_bus() and bus_to_virt() as
they are entirely deprecated.

So, your patch is quite insufficient.

-- 
Revolutions do not require corporate support.
