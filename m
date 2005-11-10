Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVKJMgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVKJMgY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbVKJMgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:36:24 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:12423 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP
	id S1750810AbVKJMgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:36:23 -0500
Date: Thu, 10 Nov 2005 14:35:38 +0200
From: Gleb Natapov <gleb@minantech.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Hugh Dickins <hugh@veritas.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nick's core remove PageReserved broke vmware...
Message-ID: <20051110123538.GL8942@minantech.com>
References: <Pine.LNX.4.61.0511031333220.22885@goblin.wat.veritas.com> <20051108213407.GB31746@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108213407.GB31746@mellanox.co.il>
X-OriginalArrivalTime: 10 Nov 2005 12:36:20.0032 (UTC) FILETIME=[5A099C00:01C5E5F3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 11:34:07PM +0200, Michael S. Tsirkin wrote:
> Index: linux-2.6.14-dontcopy/mm/madvise.c
> ===================================================================
> --- linux-2.6.14-dontcopy.orig/mm/madvise.c	2005-10-28 02:02:08.000000000 +0200
> +++ linux-2.6.14-dontcopy/mm/madvise.c	2005-11-08 23:28:56.000000000 +0200
> @@ -31,6 +31,12 @@ static long madvise_behavior(struct vm_a
>  	case MADV_RANDOM:
>  		new_flags |= VM_RAND_READ;
>  		break;
> +	case MADV_DONTCOPY:
> +		new_flags |= VM_UDONTCOPY;
> +		break;
> +	case MADV_DOCOPY:
> +		new_flags &= ~VM_UDONTCOPY;
> +		break;
>  	default:
>  		break;
>  	}
I think you are removing VM_RAND_READ/VM_SEQ_READ here.
Also perhapse we should skip VM_SHARED VMAs?

--
			Gleb.
