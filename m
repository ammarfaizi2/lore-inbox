Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbTKFI3P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 03:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263456AbTKFI3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 03:29:14 -0500
Received: from jaguar.mkp.net ([192.139.46.146]:54941 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S263453AbTKFI3E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 03:29:04 -0500
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Jamie Wellnitz <Jamie.Wellnitz@emulex.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: virt_to_page/pci_map_page vs. pci_map_single
References: <1067885332.2076.13.camel@mulgrave>
	<yq0znfcjwh1.fsf@trained-monkey.org>
	<1067964220.1792.106.camel@mulgrave>
From: Jes Sorensen <jes@trained-monkey.org>
Date: 06 Nov 2003 03:28:54 -0500
In-Reply-To: <1067964220.1792.106.camel@mulgrave>
Message-ID: <yq0islxx5mh.fsf@trained-monkey.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "James" == James Bottomley <James.Bottomley@steeleye.com> writes:

James> On Tue, 2003-11-04 at 03:48, Jes Sorensen wrote:
>> The question is whether that should be allowed in the first
>> place. Some IOMMU's will have to map it page-by-page
>> anyway. However if it is to remain a valid use then I don't see why
>> pci_map_page() shouldn't be able to handle it under the same
>> conditions by passing it a size > PAGE_SIZE.

James> I really don't see what's to be gained by doing this.  map_page
James> is for mapping one page or a fragment of it.  It's designed for
James> small zero copy stuff, like networking.  To get it to map more
James> than one page, really we should pass in an array of struct
James> pages.

I am totally in favor of that. I think it's a really bad idea on
relying on the pci_map infrstructure to do the page chopping for
multi-page mappings since the IOMMUs will normally have to chop it up
anyway. The driver authors needs to be aware of this.

The above was more meant as an example of how pci_map_page() can be
hacked to do the same thing as pci_map_single if we really wanted to
rely on that behavior.

Cheers,
Jes
