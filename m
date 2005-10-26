Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbVJZMVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbVJZMVy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 08:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbVJZMVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 08:21:54 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:46722 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1751479AbVJZMVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 08:21:53 -0400
Date: Wed, 26 Oct 2005 16:21:51 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix alpha breakage
Message-ID: <20051026162151.A785@jurassic.park.msu.ru>
References: <20051026100623.GP7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20051026100623.GP7992@ftp.linux.org.uk>; from viro@ftp.linux.org.uk on Wed, Oct 26, 2005 at 11:06:23AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2005 at 11:06:23AM +0100, Al Viro wrote:
> 	barrier.h uses barrier() in non-SMP case.  And doesn't include
> compiler.h.

Thanks, but better use <asm-alpha/compiler.h> because of potential
problems with the "inline" redefinition.

Ivan.

--- 2.6.14-rc5-git6/include/asm-alpha/barrier.h	Wed Oct 26 14:43:16 2005
+++ linux/include/asm-alpha/barrier.h	Wed Oct 26 15:03:47 2005
@@ -1,6 +1,8 @@
 #ifndef __BARRIER_H
 #define __BARRIER_H
 
+#include <asm/compiler.h>
+
 #define mb() \
 __asm__ __volatile__("mb": : :"memory")
 
