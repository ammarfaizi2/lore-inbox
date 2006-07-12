Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWGLVMW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWGLVMW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWGLVMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:12:21 -0400
Received: from terminus.zytor.com ([192.83.249.54]:30405 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932292AbWGLVMV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:12:21 -0400
Message-ID: <44B5659E.5070000@zytor.com>
Date: Wed, 12 Jul 2006 14:11:58 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Blaisorblade <blaisorblade@yahoo.it>
CC: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 4/5] UML - Reenable SysRq support
References: <200607121640.k6CGe6nP021236@ccure.user-mode-linux.org> <200607122056.01202.blaisorblade@yahoo.it>
In-Reply-To: <200607122056.01202.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade wrote:
> On Wednesday 12 July 2006 18:40, Jeff Dike wrote:
>> Sysrq works fine on UML.
>>
>> Signed-off-by: Jeff Dike <jdike@addtoit.com>
>>
>> Index: linux-2.6.17/lib/Kconfig.debug
>> ===================================================================
>> --- linux-2.6.17.orig/lib/Kconfig.debug	2006-07-12 11:26:41.000000000 -0400
>> +++ linux-2.6.17/lib/Kconfig.debug	2006-07-12 11:33:02.000000000 -0400
>> @@ -18,7 +18,6 @@ config ENABLE_MUST_CHECK
>>
>>  config MAGIC_SYSRQ
>>  	bool "Magic SysRq key"
>> -	depends on !UML
>>  	help
>>  	  If you say Y here, you will have some control over the system even
>>  	  if the system crashes for example during kernel debugging (e.g., you
> Please reject this patch, the setting for UML is just elsewhere, in 
> arch/um/Kconfig (and depends on MCONSOLE).
> 
> If kbuild doesn't handle well having an option declared twice now (it isn't 
> very happy but it worked when I added the above dependency) we can rename the 
> one in arch/um/Kconfig to MAGIC_SYSRQ_UML and make the one above like this 
> (untested):
> 
> config MAGIC_SYSRQ
> 	bool
> 	prompt "Magic SysRq key" if !UML
> 	depends on MAGIC_SYSRQ_UML || !UML
> 	default y if UML
> 

Why not:

config MAGIC_SYSRQ
	bool
	prompt "Magic SysRq key"
	depends on !UML || MCONSOLE
	default y if UML

	-hpa
