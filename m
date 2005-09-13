Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbVIMTJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbVIMTJb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbVIMTJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:09:30 -0400
Received: from quark.didntduck.org ([69.55.226.66]:27603 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S965095AbVIMTJ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:09:28 -0400
Message-ID: <4327242B.5050806@didntduck.org>
Date: Tue, 13 Sep 2005 15:10:35 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Joern Engel <joern@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permanently fix kernel configuration include mess
References: <20050913135622.GA30675@phoenix.infradead.org> <20050913150825.A23643@flint.arm.linux.org.uk> <20050913155012.C23643@flint.arm.linux.org.uk> <20050913165954.GA31461@phoenix.infradead.org> <20050913190409.B26494@flint.arm.linux.org.uk>
In-Reply-To: <20050913190409.B26494@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Tue, Sep 13, 2005 at 05:59:54PM +0100, Joern Engel wrote:
> 
>>On Tue, 13 September 2005 15:50:12 +0100, Russell King wrote:
>>
>>>Subject: [KBUILD] Permanently fix kernel configuration include mess.
>>>
>>>Include autoconf.h into every kernel compilation via the gcc
>>>command line using -imacros.  This ensures that we have the
>>>kernel configuration included from the start, rather than
>>>relying on each file having #include <linux/config.h> as
>>>appropriate.  History has shown that this is something which
>>>is difficult to get right.
>>>
>>>Since we now include the kernel configuration automatically,
>>>make configcheck becomes meaningless, so remove it.
>>>
>>>Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>
>>If it helps:
>>Signed-off-by: Joern Engel <joern@wh.fh-wedel.de>
> 
> 
> Might help more if I copied (or sent this to) akpm. 8)
> 
> diff --git a/Makefile b/Makefile
> --- a/Makefile
> +++ b/Makefile
> @@ -346,7 +346,8 @@ AFLAGS_KERNEL	=
>  # Use LINUXINCLUDE when you must reference the include/ directory.
>  # Needed to be compatible with the O= option
>  LINUXINCLUDE    := -Iinclude \
> -                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
> +                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
> +		   -imacros include/linux/autoconf.h
>  
>  CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
>  
> @@ -1247,11 +1248,6 @@ tags: FORCE
>  # Scripts to check various things for consistency
>  # ---------------------------------------------------------------------------
>  
> -configcheck:
> -	find * $(RCS_FIND_IGNORE) \
> -		-name '*.[hcS]' -type f -print | sort \
> -		| xargs $(PERL) -w scripts/checkconfig.pl
> -
>  includecheck:
>  	find * $(RCS_FIND_IGNORE) \
>  		-name '*.[hcS]' -type f -print | sort \
> 
> 

The patch should also remove the checkconfig.pl script.
