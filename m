Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266243AbTA2PeC>; Wed, 29 Jan 2003 10:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266233AbTA2PeC>; Wed, 29 Jan 2003 10:34:02 -0500
Received: from [217.167.51.129] ([217.167.51.129]:36312 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S266243AbTA2Pd7>;
	Wed, 29 Jan 2003 10:33:59 -0500
Subject: Re: [PATCH] IDE: Do not call bh_phys() on buffers with invalid
	b_page.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030129153820.GF31566@suse.de>
References: <1043852266.1690.63.camel@zion.wanadoo.fr>
	 <20030129150000.GD31566@suse.de> <1043853614.1668.70.camel@zion.wanadoo.fr>
	 <20030129152214.GE31566@suse.de> <1043853975.1668.74.camel@zion.wanadoo.fr>
	 <20030129153820.GF31566@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043855055.536.81.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 29 Jan 2003 16:44:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-29 at 16:38, Jens Axboe wrote:
> No, any b_data < PAGE_OFFSET is not wrong, that's the point. For highmem
> b_page, b_data will be the offset into the page. So it could be 2048,
> for instance.

In the other if() case, yes ;)

> The test is meant to catch an invalid buffer_head, where b_page is not
> set but b_data isn't valid either. So to make it complete, you could do:

Yup, I undestood that.

> 		if (bh->b_data < PAGE_SIZE)
> 			BUG();
> 		if (bh->b_data < PAGE_OFFSET)
> 			BUG();
> 	}

All I wanted to spot is that < PAGE_OFFSET would catch the PAGE_SIZE bug
as well ;) But that's not a problem in real life anyway it seems.

-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
