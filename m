Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWHCMqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWHCMqb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 08:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbWHCMqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 08:46:31 -0400
Received: from web25805.mail.ukl.yahoo.com ([217.12.10.190]:10101 "HELO
	web25805.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932427AbWHCMqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 08:46:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type;
  b=NgqqNycvrfikJpiRpmuJzj/udJSCXJxSEbTRY3hPIGU1rZqk+WtsW1MubZKIn+iNxvZGNkfKIyyGv8rMOhty334xSep1txnc8OWwzTtOFy/6gqdCMRK6HSq/mFU0EadNxEzBI0w2vvzmMgTOntuKyTZLXUxWz+faIvMFszfrVyE=  ;
Message-ID: <20060803124628.21540.qmail@web25805.mail.ukl.yahoo.com>
Date: Thu, 3 Aug 2006 12:46:28 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re : Re : Re : sparsemem usage
To: Andy Whitcroft <apw@shadowen.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <44D1C616.1060305@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> That would be incorrect usage.  pfn_valid() simply doesn't tell you if 
> you have memory backing a pfn, it mearly means you can interrogate the 
> page* for it.  A good example of code which counts pages in a region is 
> in count_highmem_pages() which has a form as below:
> 
>             for (pfn = start; pfn < end; pfn++) {
>                   if (!pfn_valid(pfn))
>                                          continue;
>                                  page = pfn_to_page(pfn);
>                                  if (PageReserved(page))
>                                          continue;
>                 num_physpages++;
>             }
> 
num_physpages would still not give the right total number of pages in the
system. It will report a value smaller than the size of all memories which can
be suprising, depending on how it is used. In my mind I thought that it should
store the number of all pages in the system (reserved + free + ...).

Futhermore for flatmem model, my example that count the number of physical
pages is valid: reserved pages are really pages that are in used by the kernel.
But it's not valid anymore for sparsemem model. For consistency and code
sharing, I would make the same meaning of pfn_valid() and PageReserved() for
both models.

Francis


