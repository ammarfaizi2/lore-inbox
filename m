Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVAHAW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVAHAW4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 19:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbVAHAUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 19:20:10 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:48611 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261713AbVAGXTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:19:55 -0500
Subject: Re: [PATCH 2.6] cciss typo fix
From: James Bottomley <James.Bottomley@SteelEye.com>
To: mike.miller@hp.com
Cc: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050107230103.GB26037@beardog.cca.cpqcorp.net>
References: <20050107230103.GB26037@beardog.cca.cpqcorp.net>
Content-Type: text/plain
Date: Fri, 07 Jan 2005 18:19:28 -0500
Message-Id: <1105139968.4151.26.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-07 at 17:01 -0600, mike.miller@hp.com wrote:
> -		*total_size = be32_to_cpu(*((__be32 *) &buf->total_size[0]))+1;
> -		*block_size = be32_to_cpu(*((__be32 *) &buf->block_size[0]));
> +		*total_size = be32_to_cpu(*((__u32 *) &buf->total_size[0]))+1;
> +		*block_size = be32_to_cpu(*((__u32 *) &buf->block_size[0]));

I don't think that's a typo.  It was introduced by this patch:

ChangeSet 1.1988.24.79 2004/10/06 07:55:02 viro@www.linux.org.uk
  [PATCH] cciss endianness and iomem annotations
 
The idea being that BE and LE numbers should be annotated differently,
so the __be32 annotations look correct to me.  I think sparse will warn
if you make this change.

James


