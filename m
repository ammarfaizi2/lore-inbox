Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVFULut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVFULut (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVFULtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:49:31 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:7043 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S261182AbVFUL1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 07:27:19 -0400
Message-ID: <42B7F98B.5050405@namesys.com>
Date: Tue, 21 Jun 2005 15:27:07 +0400
From: Edward Shishkin <edward@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; cs-CZ; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew James Wade 
	<ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
CC: Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [PATCH] Fix Reiser4 Dependencies
References: <20050619233029.45dd66b8.akpm@osdl.org> <200506200832.22260.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com> <42B70A6D.7030308@namesys.com> <200506201644.10429.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
In-Reply-To: <200506201644.10429.ajwade@cpe00095b3131a0-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew James Wade wrote:

>>Andrew James Wade wrote:
>>
>>    
>>
>>>*    ZLIB_INFLATE is not visible in menuconfig. Reiser4 should probably
>>>    just select it like the other filesystems do.
>>>      
>>>
>The issue I had here was that Reiser4 wasn't appearing in menuconfig for
>me as I did not have ZLIB_INFLATE set, and the ZLIB_INFLATE option wasn't
>appearing either (I think it's because it doesn't have a prompt). I just
>followed the pattern for all other filesystems referencing ZLIB_INFLATE,
>and the comment in lib/Kbuild suggests this is the proper approach:
>
>| #
>| # compression support is select'ed if needed
>| #
>
>  
>
>>>*    Reiser4 also depends on ZLIB_DEFLATE.
>>>      
>>>
>I was getting linker errors:
>
>| fs/built-in.o(.text+0x8f465): In function `gzip1_alloc':
>| fs/reiser4/plugin/compress/compress.c:59: undefined reference to `zlib_deflate_workspacesize'
>| fs/built-in.o(.text+0x8f475): In function `gzip1_alloc':
>| include/asm/string.h:361: undefined reference to `zlib_deflate_workspacesize'
>| fs/built-in.o(.text+0x8f64e): In function `gzip1_compress':
>| fs/reiser4/plugin/compress/compress.c:167: undefined reference to `zlib_deflateInit2_'
>| fs/built-in.o(.text+0x8f661):fs/reiser4/plugin/compress/compress.c:174: undefined reference to `zlib_deflateReset'
>| fs/built-in.o(.text+0x8f697):fs/reiser4/plugin/compress/compress.c:184: undefined reference to `zlib_deflate'
>
>select'ing ZLIB_DEFLATE fixed them.
>
>Reiser4 is working for me after the two changes.
>
>HTH,
>Andrew
>  
>

Hello,
ZLIB_INFLATE/DEFLATE  will be selected by special reiser4 related 
configuration
option "Enable reiser4 compression plugins of gzip family" 
(REISER4_ZLIB), but
since this kind of support was discussed, it is in our working 
repository for a while..

Anyway thanks,
Edward.

>
>  
>
>>>signed-off-by: Andrew Wade <ajwade@alumni.uwaterloo.ca>
>>>
>>>--- 2.6.12-mm1/fs/reiser4/Kconfig	2005-06-20 07:38:22.087653000 -0400
>>>+++ linux/fs/reiser4/Kconfig	2005-06-20 08:01:28.914324250 -0400
>>>@@ -1,6 +1,8 @@
>>>config REISER4_FS
>>>	tristate "Reiser4 (EXPERIMENTAL)"
>>>-	depends on EXPERIMENTAL && !4KSTACKS && ZLIB_INFLATE
>>>+	depends on EXPERIMENTAL && !4KSTACKS
>>>+	select ZLIB_INFLATE
>>>+	select ZLIB_DEFLATE
>>>	help
>>>	  Reiser4 is a filesystem that performs all filesystem operations
>>>	  as atomic transactions, which means that it either performs a
>>>      
>>>
>
>
>  
>

