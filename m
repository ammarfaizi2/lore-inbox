Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbTH3GZn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 02:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbTH3GZn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 02:25:43 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:61175 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S261473AbTH3GZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 02:25:42 -0400
Subject: Re: 2.6.0-test4-mm3
From: Martin Schlemmer <azarah@gentoo.org>
To: Cliff White <cliffw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200308291627.h7TGRoX02912@mail.osdl.org>
References: <200308291627.h7TGRoX02912@mail.osdl.org>
Content-Type: text/plain
Message-Id: <1062224182.30172.4.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 30 Aug 2003 08:16:23 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-29 at 18:27, Cliff White wrote:

Hi

> This also breaks STP. We installed module-init-tools using the 'moveold' 
> method,
> so we can still run 2.4.
> Our depmod is in /usr/local/sbin. 
> Using /sbin/depmod hoses us. Using PATH works for us.
> 
> [root@stp1-002 linux]# depmod -V
> module-init-tools 0.9.12
> 
> [root@stp1-002 linux]# /sbin/depmod -V
> depmod version 2.4.22
> 
> [root@stp1-002 linux]# /usr/local/sbin/depmod -V
> module-init-tools 0.9.12
> 

You guys are sorda missing the point of 'moveold' ....
You want to build it with '--prefix=/' so that
both depmod and depmod.old are in /sbin ....

----------------------
workshop root # ls /sbin/depmod* -l
-rwxr-xr-x    1 root     root        58744 Aug  4 17:19 /sbin/depmod
-rwxr-xr-x    1 root     root        58712 Aug  4 13:57 /sbin/depmod.old
workshop root # ls /sbin/modprobe* -l
lrwxrwxrwx    1 root     root            6 Aug  4 17:19 /sbin/modprobe
-> insmod
lrwxrwxrwx    1 root     root           10 Aug  4 13:57
/sbin/modprobe.old -> insmod.old
lrwxrwxrwx    1 root     root           13 Aug  4 17:19
/sbin/modprobe.static -> insmod.static
workshop root # 
------------------

Any call will then thus run depmod/whatever from module-init-tools
first, and if the kernel is 2.4, etc, it will call
depmod.old/whatever ...


Regards,

-- 
Martin Schlemmer


