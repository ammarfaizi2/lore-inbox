Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263000AbUDEB0y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 21:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbUDEB0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 21:26:54 -0400
Received: from ozlabs.org ([203.10.76.45]:6892 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263000AbUDEB0v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 21:26:51 -0400
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mbligh@aracnet.com, Andrew Morton <akpm@osdl.org>, wli@holomorphy.com,
       haveblue@us.ibm.com, colpatch@us.ibm.com
In-Reply-To: <20040329041253.5cd281a5.pj@sgi.com>
References: <20040329041253.5cd281a5.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1081128401.18831.6.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 05 Apr 2004 11:26:41 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 22:12, Paul Jackson wrote:
> Patch_2_of_22 - New mask ADT
> 	Adds new include/linux/mask.h header file
> 
> 	==> See this mask.h header for more extensive mask documentation <==

Y'know, I dislike this.  I really do.  I know you've done a lot of work,
but too much abstraction scares me.

Especially when what you're abstracting is so trivial.

We have include/linux/bitmap.h which has a collection of unsigned long[]
operations.  I suggest that people who want to use a bitmap should wrap
this in a struct and use the bitops directly, eg:

struct cpumap {
	DECLARE_BITMAP(bits,NR_CPUS);
};

This has several advantages:
1) It doesn't add new code to the kernel,
2) Operations on "cpumap.bits" are easy to read, write and understand,
3) Different mask types are not type compatible,
4) Any new operations you need to write can be used by anyone who needs
   a bitmap, whether in a struct or not.

Please consider...
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

