Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTI0MS5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 08:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTI0MS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 08:18:56 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:31494 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262434AbTI0MSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 08:18:54 -0400
Date: Sat, 27 Sep 2003 13:18:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] helper for device list traversal
Message-ID: <20030927131853.A22669@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20030927123933.A21629@infradead.org> <Pine.GSO.4.21.0309271348560.6768-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0309271348560.6768-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Sat, Sep 27, 2003 at 02:15:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 27, 2003 at 02:15:56PM +0200, Geert Uytterhoeven wrote:
> The A2091 and GVP-II drivers want to traverse the list of SCSI host adapters in
> their interrupt handler, to find their Scsi_Host instances and check whether
> the (shared) interrupt was meant for one of them.
> 
> An alternative would be to register the interrupt handler multiple times and
> use the Scsi_Host instance pointer as the interrupt handler data pointer.

Yes, they should do that.

> For 53c7xx it's a bit more complex, I don't know anything about its internals.

The occurance in #if 0 code should probably use scsi_lookup_host.
process_issue_queue needs to be rewritten to be per-host.

