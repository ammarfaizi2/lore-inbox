Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268365AbUIWKQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268365AbUIWKQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 06:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268367AbUIWKQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 06:16:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:23716 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268365AbUIWKQ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 06:16:58 -0400
Date: Thu, 23 Sep 2004 03:14:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2 fn_hash_insert oops
Message-Id: <20040923031451.56147952.akpm@osdl.org>
In-Reply-To: <20040923100906.GB11230@mail.muni.cz>
References: <20040923100906.GB11230@mail.muni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:
>
> Sep 23 11:26:24 debian kernel: EIP:    0060:[fn_hash_insert+1039/1159]    Tainted:  P   VLI
> 

This might fix it

--- a/net/ipv4/fib_hash.c	2004-09-23 03:13:49 -07:00
+++ b/net/ipv4/fib_hash.c	2004-09-23 03:13:49 -07:00
@@ -536,7 +536,7 @@
 		 * information.
 		 */
 		fa_orig = fa;
-		list_for_each_entry(fa, fa->fa_list.prev, fa_list) {
+		list_for_each_entry(fa, fa_orig->fa_list.prev, fa_list) {
 			if (fa->fa_info->fib_priority != fi->fib_priority)
 				break;
 			if (fa->fa_type == type &&
 
