Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263284AbUJ2LvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263284AbUJ2LvX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 07:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263250AbUJ2LsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 07:48:23 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:5385 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263260AbUJ2Lpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 07:45:43 -0400
Date: Fri, 29 Oct 2004 13:45:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.10-rc1-mm2: `key_init' multiple definition
Message-ID: <20041029114511.GJ6677@stusta.de>
References: <20041029014930.21ed5b9a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041029014930.21ed5b9a.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 01:49:30AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.10-rc1-mm1:
>...
> +key_init-ordering-fix.patch
> 
>  Fix early oops with the key management code
>...
> All 381 patches:
>...
> reiser4-only.patch
>   reiser4: main fs
>...

Both patches add a global function key_init, resulting in the following 
compile error:

<--  snip  -->

...
  LD      .tmp_vmlinux1
security/built-in.o(.init.text+0x80): In function `key_init':
: multiple definition of `key_init'
fs/built-in.o(.text+0x8e200): first defined here
ld: Warning: size of symbol `key_init' changed from 90 in fs/built-in.o to 247 in security/built-in.o
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


I'm unsure about the key management code case, but for reiser4 this name 
is definitely too generic for a global symbol (-> reiser4_key_init ?).


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

