Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964953AbVI0POf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964953AbVI0POf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 11:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbVI0POf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 11:14:35 -0400
Received: from smtpout.mac.com ([17.250.248.73]:27384 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S964953AbVI0POe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 11:14:34 -0400
In-Reply-To: <20050927071025.GS7992@ftp.linux.org.uk>
References: <E1EJlNM-00059K-R8@ZenIV.linux.org.uk> <20050927.151301.189720995.takata.hirokazu@renesas.com> <20050927071025.GS7992@ftp.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CFD86C0A-0BE4-4D39-BAAE-F985D997AFD2@mac.com>
Cc: Hirokazu Takata <takata@linux-m32r.org>, torvalds@odsl.org,
       linux-kernel@vger.kernel.org, sam@ravnborg.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] m32r: set CHECKFLAGS properly
Date: Tue, 27 Sep 2005 11:13:44 -0400
To: Al Viro <viro@ftp.linux.org.uk>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 27, 2005, at 03:10:25, Al Viro wrote:
> You do realize that this way sparse will get neither?  It does not  
> pick predefined symbols from gcc; thus the -D<your_arch>, etc.

How about sticking this in some global Makefile somewhere?  This will  
give sparse the same list of defines that GCC uses:

CHECKFLAGS += $(shell echo | gcc -E - -dM | sed -re 's/^#define +([^ ] 
+) +(.*)$/-D\1=\2/g')

Or you could do this:

include/linux/checkerdefines.h:
         echo | gcc -E - -dM >$@

And in linux/stddef.h or linux/compiler.h or something do:
#if defined(__CHECKER__) and not defined(_LINUX_CHECKERDEFINES_H)
# define _LINUX_CHECKERDEFINES_H 1
# include <linux/checkerdefines.h>
#endif

Cheers,
Kyle Moffett

--
Q: Why do programmers confuse Halloween and Christmas?
A: Because OCT 31 == DEC 25.



