Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265897AbUFISjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbUFISjd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265905AbUFISjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:39:33 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:36825 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S265889AbUFISj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 14:39:29 -0400
Subject: Re: Unaligned accesses in net/ipv4/netfilter/arp_tables.c:184
From: Alex Williamson <alex.williamson@hp.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0406091106210.21291@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0406091106210.21291@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: LOSL
Message-Id: <1086805676.4288.16.camel@tdi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 09 Jun 2004 12:27:56 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   A patch for this was sent to the netfilter-devel list a while back,
see this link:

http://marc.theaimsgroup.com/?l=netfilter-devel&m=107814727803971&w=2

I don't think the patch ever made it anywhere so far.

	Alex

On Wed, 2004-06-09 at 12:09, Christoph Lameter wrote:
> The following code casts pointers to char to long in order to do a fast
> comparison. This causes alignment errors on IA64 and likely also on
> other platforms:
> 
>         /* Look for ifname matches; this should unroll nicely. */
>         for (i = 0, ret = 0; i < IFNAMSIZ/sizeof(unsigned long); i++) {
>                 ret |= (((const unsigned long *)indev)[i]
>                         ^ ((const unsigned long *)arpinfo->iniface)[i])
>                         & ((const unsigned long *)arpinfo->iniface_mask)[i];
>         }
> 
> iniface is a pointer to char.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ia64" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

