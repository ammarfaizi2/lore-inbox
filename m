Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbUKDPbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbUKDPbb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 10:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbUKDPba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 10:31:30 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:43695 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262264AbUKDPaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 10:30:14 -0500
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
To: Keith Owens <kaos@sgi.com>
Subject: Re: [patch 2.4.28-rc1] Avoid oops in proc_delete_inode
Date: Thu, 4 Nov 2004 16:29:17 +0100
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu,
       marcelo.tosatti@cyclades.com
References: <9663.1099535733@kao2.melbourne.sgi.com>
In-Reply-To: <9663.1099535733@kao2.melbourne.sgi.com>
X-Operating-System: Linux 2.4.20-wolk4.16 i686 GNU/Linux
Organization: Linux-Systeme GmbH
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411041629.17443@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 November 2004 03:35, Keith Owens wrote:

Marcelo,

I just saw you applied this to bk. Cool, but please apply a right version ;)

> Under heavy load, vmstat, top and other programs that access /proc can
> oops.  PROC_INODE_PROPER(inode) is sometimes false for pid entries
> (usually zombies), but inode->u.generic_ip is not NULL.
>
> Backport a fix by AL Viro from 2.5.7-pre2 to 2.4.28-rc1.
>
> Signed-off-by: Keith Owens <kaos@sgi.com>
>
> Index: 2.4.28-rc1/fs/proc/base.c
> ===================================================================
> --- 2.4.28-rc1.orig/fs/proc/base.c 2004-08-08 10:10:49.000000000 +1000
> +++ 2.4.28-rc1/fs/proc/base.c 2004-11-04 13:25:16.402602459 +1100
> @@ -780,6 +780,7 @@ out:
>   return inode;
>
>  out_unlock:
> + node->u.generic_ip = NULL;

has to be:

  + inode->u.generic_ip = NULL;

>   iput(inode);
>   return NULL;
>  }

ciao, Marc
