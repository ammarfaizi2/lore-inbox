Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVBQASs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVBQASs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 19:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVBQASs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 19:18:48 -0500
Received: from FLA1Aah135.kng.mesh.ad.jp ([61.193.101.135]:42211 "EHLO
	yamt.dyndns.org") by vger.kernel.org with ESMTP id S262162AbVBQASq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 19:18:46 -0500
To: oda@valinux.co.jp
Cc: ebiederm@xmission.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /proc/cpumem
In-Reply-To: Your message of "Wed, 16 Feb 2005 17:49:51 +0900"
	<20050216170224.4C66.ODA@valinux.co.jp>
References: <20050216170224.4C66.ODA@valinux.co.jp>
X-Mailer: Cue version 0.8 (041105-2302/takashi)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Date: Thu, 17 Feb 2005 09:17:15 +0900
Message-Id: <1108599435.484439.5660.nullmailer@yamt.dyndns.org>
From: YAMAMOTO Takashi <yamamoto@valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

> +	while (addr < end) {
> +		if (valid_phys_addr_range(addr, &size)) {
> +			if (!found) {
> +				found = 1;
> +				p->addr = addr;
> +				p->size = size;
> +			} else {
> +				p->size += size;
> +			}
> +			addr += size;
> +			size = 0xf0000000;
> +		} else {
> +			if (found) {
> +				return p;
> +			}
> +			addr += PAGE_SIZE;
> +		}
> +	}

doesn't this loop take very long time if you have a large hole?

i'd suggest to change valid_phys_addr_range to fill &size even when
it returns false, so that caller can skip the hole efficiently.

YAMAMOTO Takashi
