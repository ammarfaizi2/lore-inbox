Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269575AbTHJOyQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 10:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269639AbTHJOyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 10:54:16 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:16132 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269575AbTHJOyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 10:54:15 -0400
Date: Sun, 10 Aug 2003 15:54:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] convert drivers/scsi to virt_to_pageoff()
Message-ID: <20030810155413.B18400@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B" <yoshfuji@linux-ipv6.org>,
	davem@redhat.com, linux-kernel@vger.kernel.org
References: <20030810.201009.77128484.yoshfuji@linux-ipv6.org> <20030810123148.A10435@infradead.org> <20030810045121.31ef7ccc.davem@redhat.com> <20030810.210322.104562682.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030810.210322.104562682.yoshfuji@linux-ipv6.org>; from yoshfuji@linux-ipv6.org on Sun, Aug 10, 2003 at 09:03:22PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 10, 2003 at 09:03:22PM +0900, YOSHIFUJI Hideaki / ?$B5HF#1QL@?(B wrote:
> BTW, drivers/scsi/3w-xxxx.c says:
> 
>    1.02.00.029 - Add missing pci_free_consistent() in tw_allocate_memory().
>                  Replace pci_map_single() with pci_map_page() for highmem.
>                  Check for tw_setfeature() failure.
> 
> Have problems in pci_map_single() with highmem already gone away?

pci_map_single can't support highmem, but the case you converted can't
be highmem either.  There's other places in the driver where we get handed
scatterlists that can contain highmem pages and thus need to be handled
with pci_map_page or better with pci_map_sg.

