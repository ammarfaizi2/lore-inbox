Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbUBZCi6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 21:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbUBZCi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 21:38:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43985 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261508AbUBZCiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 21:38:51 -0500
Message-ID: <403D5C2C.7000205@pobox.com>
Date: Wed, 25 Feb 2004 21:38:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Mukker, Atul" <Atulm@lsil.com>
CC: "'Matt Domsch'" <Matt_Domsch@dell.com>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>,
       "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Paul Wagland'" <paul@wagland.net>, Matthew Wilcox <willy@debian.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [SUBJECT CHANGE]: megaraid unified driver version 2.20.0.0-al
 pha1
References: <0E3FA95632D6D047BA649F95DAB60E57033BC3EA@exa-atlanta.se.lsil.com>
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E57033BC3EA@exa-atlanta.se.lsil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mukker, Atul wrote:
> With multiple adapters, applications would need to open multiple handles.
> This would somewhat complicate things for them. But keeping in line with
> general expectations, we would fork the drivers for different class of
> controllers now.

"opening multiple handles" is preferred.  You want one discrete object 
per controller or per device, depending on the object in question.


> I have not yet gotten strong feelings against a single driver for lk 2.4 and
> lk 2.6. If this is true, we would like to keep single driver for both
> kernels - since lk 2.4 still has a big lifecycle.

If you are doing multiple drivers in 2.6, it would seem better to match 
that as closely as possible in 2.4.


> For lk 2.6, the controllers would be detected PCI ordered and because of
> existing lk 2.4 setups, driver would re-order the registration based on boot
> controller.

Look at my libata code -- in both 2.4 and 2.6, it uses the proper PCI 
API calls.

Controller order is irrelevant -- device order is what you really care 
about, right?  This can be managed by creating a list during probe, and 
then executing the list after all controllers have been probed. 
Obviously, this excludes hotplug controllers added after the initial 
module_init() function exits.

	Jeff



