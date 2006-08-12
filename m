Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWHLOmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWHLOmJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 10:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbWHLOmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 10:42:08 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:961 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932537AbWHLOmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 10:42:06 -0400
Message-ID: <44DDE8B6.8000900@garzik.org>
Date: Sat, 12 Aug 2006 10:41:58 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Indan Zupancic <indan@nul.nu>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Daniel Phillips <phillips@google.com>, Rik van Riel <riel@redhat.com>,
       David Miller <davem@davemloft.net>
Subject: Re: [RFC][PATCH 3/4] deadlock prevention core
References: <20060812141415.30842.78695.sendpatchset@lappy> <20060812141445.30842.47336.sendpatchset@lappy>
In-Reply-To: <20060812141445.30842.47336.sendpatchset@lappy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> Index: linux-2.6/include/linux/gfp.h
> ===================================================================
> --- linux-2.6.orig/include/linux/gfp.h	2006-08-12 12:56:06.000000000 +0200
> +++ linux-2.6/include/linux/gfp.h	2006-08-12 12:56:09.000000000 +0200
> @@ -46,6 +46,7 @@ struct vm_area_struct;
>  #define __GFP_ZERO	((__force gfp_t)0x8000u)/* Return zeroed page on success */
>  #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
>  #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
> +#define __GFP_MEMALLOC  ((__force gfp_t)0x40000u) /* Use emergency reserves */

This symbol name has nothing to do with its purpose.  The entire area of 
code you are modifying could be described as having something to do with 
'memalloc'.

GFP_EMERGENCY or GFP_USE_RESERVES or somesuch would be a far better 
symbol name.

I recognize that is matches with GFP_NOMEMALLOC, but that doesn't change 
the situation anyway.  In fact, a cleanup patch to rename GFP_NOMEMALLOC 
would be nice.

	Jeff


