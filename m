Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbUKDBPe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbUKDBPe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 20:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbUKDBPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 20:15:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8391 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262040AbUKDBNI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 20:13:08 -0500
Message-ID: <41898215.4040809@pobox.com>
Date: Wed, 03 Nov 2004 20:12:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Chris Wedgwood <cw@f00f.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] deprecate pci_module_init
References: <20041103091039.GA22469@taniwha.stupidest.org> <41891980.6040009@pobox.com> <20041103190757.GA25451@taniwha.stupidest.org> <41892DE3.5040402@pobox.com> <20041104002138.GA32691@kroah.com> <20041104003734.GA17467@taniwha.stupidest.org> <20041104005107.GA15301@kroah.com>
In-Reply-To: <20041104005107.GA15301@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> In short, pci_module_init() on 2.4 would return the number of pci
> devices bound to the device, on 2.6, it just always returns 0 if the
> driver was successfully registered, no knowledge of how many devices
> bound are ever returned.


Incorrect.  pci_register_driver() is the inconsistent one, as I've 
explained before (months ago).

pci_module_init() always returns 0 or an errno-based value, in 2.4 or 
2.6.  Thus is it the portable alternative.

Thus, changing drivers -away from- pci_module_init() makes them less 
portable, for zero apparent gain.  It's just a #define symbol at this 
point, leave it be.

The cost of "#define pci_module_init pci_register_driver" is zero, while 
the cost and impact of changing tons of drivers to the non-portable 
variant is non-zero.

	Jeff


