Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264114AbUDGSZg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 14:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbUDGSZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 14:25:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:60610 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264114AbUDGSZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 14:25:24 -0400
Date: Wed, 7 Apr 2004 11:27:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mc2
Message-Id: <20040407112738.23d07088.akpm@osdl.org>
In-Reply-To: <20040407180919.GB30117@holomorphy.com>
References: <20040406221744.2bd7c7e4.akpm@osdl.org>
	<20040407180430.GA30117@holomorphy.com>
	<20040407180919.GB30117@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Wed, Apr 07, 2004 at 11:04:30AM -0700, William Lee Irwin III wrote:
> > +	if (sizeof(unsigned long) == 8)
> 
> Ugh.

I did it this way, relying on magical promotions:

--- 25/fs/open.c~nfs-32bit-statfs-fix-warning-fix	2004-04-06 23:16:25.221685072 -0700
+++ 25-akpm/fs/open.c	2004-04-06 23:16:25.225684464 -0700
@@ -64,10 +64,10 @@ static int vfs_statfs_native(struct supe
 			 * f_files and f_ffree may be -1; it's okay to stuff
 			 * that into 32 bits
 			 */
-			if (st.f_files != 0xffffffffffffffffULL &&
+			if (st.f_files != -1 &&
 			    (st.f_files & 0xffffffff00000000ULL))
 				return -EOVERFLOW;
-			if (st.f_ffree != 0xffffffffffffffffULL &&
+			if (st.f_ffree != -1 &&
 			    (st.f_ffree & 0xffffffff00000000ULL))
 				return -EOVERFLOW;
 		}

_

