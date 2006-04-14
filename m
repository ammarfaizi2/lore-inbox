Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWDNCmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWDNCmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 22:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWDNCmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 22:42:49 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:19125 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751170AbWDNCms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 22:42:48 -0400
Date: Fri, 14 Apr 2006 11:44:37 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: clameter@sgi.com, akpm@osdl.org, hugh@veritas.com,
       linux-kernel@vger.kernel.org, lee.schermerhorn@hp.com,
       linux-mm@kvack.org, taka@valinux.co.jp, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 5/5] Swapless V2: Revise main migration logic
Message-Id: <20060414114437.1a5a9c7c.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060414113455.15fd5162.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060413235406.15398.42233.sendpatchset@schroedinger.engr.sgi.com>
	<20060413235432.15398.23912.sendpatchset@schroedinger.engr.sgi.com>
	<20060414101959.d59ac82d.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0604131832020.16220@schroedinger.engr.sgi.com>
	<20060414113455.15fd5162.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


soryy...This is wrong.
On Fri, 14 Apr 2006 11:34:55 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

>  /* Use last entry for page migration swap entries */
> -#define MAX_SWAPFILES		((1 << MAX_SWAPFILES_SHIFT)-1)
> -#define SWP_TYPE_MIGRATION	MAX_SWAPFILES
> +#define MAX_SWAPFILES		((1 << MAX_SWAPFILES_SHIFT)-2)
> +/* write protected page under migration*/
> +#define SWP_TYPE_MIGRATION_WP	(MAX_SWAPFILES - 1)
> +/* write enabled migration type */
> +#define SWP_TYPE_MIGRATION_WE	(MAX_SWAPFILES)
>  #endif

maybe I need one more eye..

This is fix.
-Kame

Index: Christoph-New-Migration/include/linux/swap.h
===================================================================
--- Christoph-New-Migration.orig/include/linux/swap.h	2006-04-14 11:13:55.000000000 +0900
+++ Christoph-New-Migration/include/linux/swap.h	2006-04-14 11:40:28.000000000 +0900
@@ -35,9 +35,9 @@
 /* Use last entry for page migration swap entries */
 #define MAX_SWAPFILES		((1 << MAX_SWAPFILES_SHIFT)-2)
 /* write protected page under migration*/
-#define SWP_TYPE_MIGRATION_WP	(MAX_SWAPFILES - 1)
+#define SWP_TYPE_MIGRATION_WP	(MAX_SWAPFILES)
 /* write enabled migration type */
-#define SWP_TYPE_MIGRATION_WE	(MAX_SWAPFILES)
+#define SWP_TYPE_MIGRATION_WE	(MAX_SWAPFILES + 1)
 #endif
 
 /*

