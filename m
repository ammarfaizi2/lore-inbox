Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271968AbTHIBrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 21:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271972AbTHIBrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 21:47:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:45793 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271968AbTHIBrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 21:47:39 -0400
Date: Fri, 8 Aug 2003 18:49:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6test /proc/net/pnp oops.
Message-Id: <20030808184950.3b2bd6e2.akpm@osdl.org>
In-Reply-To: <20030809011901.GA16007@suse.de>
References: <20030809011901.GA16007@suse.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@codemonkey.org.uk> wrote:
>
> Whilst trying to figure out what kept changing the bootserver
>  entry every few minutes, I got the following oops when I did
>  cat /proc/net/pnp
>  This is from bitkeeper tree as of 24hrs ago.
> 
>  		Dave
> 
>  Unable to handle kernel paging request at virtual address c06f977c

Could you please check your System.map and verify that ic_servaddr was at
0xc06f977c?

diff -puN net/ipv4/ipconfig.c~pnp_get_info-oops-fix net/ipv4/ipconfig.c
--- 25/net/ipv4/ipconfig.c~pnp_get_info-oops-fix	2003-08-08 18:48:33.000000000 -0700
+++ 25-akpm/net/ipv4/ipconfig.c	2003-08-08 18:48:40.000000000 -0700
@@ -129,7 +129,7 @@ u32 ic_myaddr __initdata = INADDR_NONE;	
 u32 ic_netmask __initdata = INADDR_NONE;	/* Netmask for local subnet */
 u32 ic_gateway __initdata = INADDR_NONE;	/* Gateway IP address */
 
-u32 ic_servaddr __initdata = INADDR_NONE;	/* Boot server IP address */
+u32 ic_servaddr = INADDR_NONE;			/* Boot server IP address */
 
 u32 root_server_addr __initdata = INADDR_NONE;	/* Address of NFS server */
 u8 root_server_path[256] __initdata = { 0, };	/* Path to mount as root */

_

