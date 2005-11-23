Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVKWU3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVKWU3J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932377AbVKWU2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:28:36 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:5101 "EHLO pilet.ens-lyon.fr")
	by vger.kernel.org with ESMTP id S932365AbVKWU23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:28:29 -0500
Date: Wed, 23 Nov 2005 21:25:27 +0100
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc2-mm1
Message-ID: <20051123202527.GA1162@ens-lyon.fr>
References: <20051123033550.00d6a6e8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051123033550.00d6a6e8.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2005 at 03:35:50AM -0800, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc2/2.6.15-rc2-mm1/
> 
> (temp copy at http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.15-rc2-mm1.gz)
> 
> - Added git-sym2.patch to the -mm lineup: updates to the sym2 scsi driver
>   (Matthew Wilcox).  
> 
> - The JSM tty driver still doesn't compile.
> 
> - The git-powerpc tree is included now.
> 
I have undefined symbols (since rc1-mm1 i think):
net/ipv4/netfilter/ip_conntrack_netlink.c: In function 'ctnetlink_dump_table':
net/ipv4/netfilter/ip_conntrack_netlink.c:409: warning: implicit declaration of function 'local_bh_disable'
net/ipv4/netfilter/ip_conntrack_netlink.c:427: warning: implicit declaration of function 'local_bh_enable'

I don't know if this is the best fix: since there are circular
dependencies, linux/interrupt.h cannot be included in
linux/spinlock_api_up.h so i thought the best i could do was to directly
include it in the C file.

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

--- net/ipv4/netfilter/ip_conntrack_netlink.c.orig	2005-11-23 21:05:37.000000000 +0100
+++ net/ipv4/netfilter/ip_conntrack_netlink.c	2005-11-23 21:02:23.000000000 +0100
@@ -27,6 +27,7 @@
 #include <linux/errno.h>
 #include <linux/netlink.h>
 #include <linux/spinlock.h>
+#include <linux/interrupt.h>
 #include <linux/notifier.h>
 
 #include <linux/netfilter.h>
