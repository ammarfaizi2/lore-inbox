Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbTI0Ljg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 07:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbTI0Ljg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 07:39:36 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:57093 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261736AbTI0Ljf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 07:39:35 -0400
Date: Sat, 27 Sep 2003 12:39:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] helper for device list traversal
Message-ID: <20030927123933.A21629@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <200309270508.h8R58tHE015032@hera.kernel.org> <Pine.GSO.4.21.0309271330460.6768-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0309271330460.6768-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Sat, Sep 27, 2003 at 01:34:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 27, 2003 at 01:34:15PM +0200, Geert Uytterhoeven wrote:
> Is this what we should use to fix the currently broken list traversal[*] in
> drivers/scsi/{a2091,gvp11,53c7xx}.c?

where does that [*] refere to?

> Currently ut uses
> 
>     struct Scsi_Host *instance;
>     for (instance = first_instance; instance &&
> 	 instance->hostt == xxx_template; instance = instance->next)
> 
> bust Scsi_Host.next was removed a while ago...

Most users of that construct want to use scsi_lookup_host (if they
looked for a specific host struct).

Above patch is for scsi_device list traversal, not Scsi_Host.

