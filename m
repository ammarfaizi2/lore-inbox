Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVAGQx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVAGQx0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 11:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVAGQxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 11:53:25 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28097 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261513AbVAGQuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 11:50:21 -0500
Subject: Re: [PATCH] 2.6.9 Use skb_padto() in drivers/net/8390.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: jgarzik@pobox.com
In-Reply-To: <200501070309.j0739IG6007753@hera.kernel.org>
References: <200501070309.j0739IG6007753@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105111759.17166.350.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 07 Jan 2005 15:46:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-27 at 20:18, Linux Kernel Mailing List wrote:
> ChangeSet 1.1938.455.1, 2004/12/27 15:18:56-05:00, penguin@muskoka.com
> 
> 	[PATCH] 2.6.9 Use skb_padto() in drivers/net/8390.c
> 	
> 	The 8390 driver had been fixed for leaking information in short packets
> 	prior to skb_padto() existing.  This change gets rid of the scratch area on
> 	the stack and makes it use skb_padto().  Thanks to Mark Smith for bringing
> 	this to my attention.
> 	
> 	Signed-off-by: Paul Gortmaker <p_gortmaker@yahoo.com>
> 	Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

This was done because it benchmarked materially faster than the
skb_padto version you just reverted. Its only 64 bytes on the stack and
its cached.

ie the old 8390 code was quite intentional and done because it commonly
occurs on very old machines where clock count matters. Because of its
commonness I actually hand optimised this one when I did the original
fixes to avoid doing extra memory allocations.

Summary: Please revert.

Alan

