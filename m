Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934418AbWKVEjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934418AbWKVEjA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 23:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934420AbWKVEjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 23:39:00 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:29295 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S934418AbWKVEi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 23:38:59 -0500
Date: Tue, 21 Nov 2006 20:35:43 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] CACHEFILES must depend on PROC_FS
Message-Id: <20061121203543.5d1c4f85.randy.dunlap@oracle.com>
In-Reply-To: <20061122041736.GB5200@stusta.de>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061122041736.GB5200@stusta.de>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2006 05:17:36 +0100 Adrian Bunk wrote:

> I got the following compile error with CONFIG_PROC_FS=n:
> 
> <--  snip  -->
> 
> ...
>   CC      fs/cachefiles/cf-main.o
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/fs/cachefiles/cf-main.c: In function 'cachefiles_init':
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/fs/cachefiles/cf-main.c:77: error: 'proc_root_fs' undeclared (first use in this function)
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/fs/cachefiles/cf-main.c:77: error: (Each undeclared identifier is reported only once
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/fs/cachefiles/cf-main.c:77: error: for each function it appears in.)
> make[3]: *** [fs/cachefiles/cf-main.o] Error 1
> 
> <--  snip  -->
> 
> This patch adds the missing dependency of CACHEFILES on PROC_FS.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.19-rc5-mm2/fs/Kconfig.old	2006-11-22 02:48:36.000000000 +0100
> +++ linux-2.6.19-rc5-mm2/fs/Kconfig	2006-11-22 02:49:01.000000000 +0100
> @@ -654,6 +654,7 @@ config FSCACHE
>  
>  config CACHEFILES
>  	tristate "Filesystem caching on files"
> +	depends on PROC_FS
>  	select FSCACHE
>  	help
>  	  This permits use of a mounted filesystem as a cache for other

I made that same patch (on linux-fsdevel).  David Howells replied:

Randy Dunlap <randy.dunlap@oracle.com> wrote:

> CACHEFILES uses PROC_FS, so make it a Kconfig depends.

Thanks, but the new and improved CacheFiles doesn't use procfs as Christoph
Hellwig objects to such a practice.  In any case, Andrew Morton has dropped it
from -mm as it's now obsolete.


---
~Randy
