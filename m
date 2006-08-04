Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161290AbWHDQhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161290AbWHDQhN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 12:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161291AbWHDQhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 12:37:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20613 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161290AbWHDQhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 12:37:11 -0400
Subject: Re: [PATCH] fix sun partition overflow over 1T
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Sandeen <esandeen@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44D37440.9080100@redhat.com>
References: <44D37440.9080100@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 04 Aug 2006 17:56:30 +0100
Message-Id: <1154710590.23655.248.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-04 am 11:22 -0500, ysgrifennodd Eric Sandeen:
> Although sun partition labels aren't supposed to support > 1T, apparently
> linux partition editors will allow up to 2T.  This can cause problems
> in the kernel when these larger partitions are read, due to a signed
> int container.
> 
> num_sectors in the sun_disklabel struct is marked as __u32 in 2.4, and 
> as __be32 in 2.6.  However, this is assigned to a signed int in
> sun_partition():
> 
>                 int num_sectors;
> 
>                 st_sector = be32_to_cpu(p->start_cylinder) * spc;
>                 num_sectors = be32_to_cpu(p->num_sectors);
> 
> Changing num_sectors to an unsigned int avoids this problem.
> 

> Signed-off-by: Eric Sandeen <esandeen@redhat.com>

Acked-by: Alan Cox <alan@redhat.com>

