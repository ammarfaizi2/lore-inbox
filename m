Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWD0JHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWD0JHo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 05:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWD0JHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 05:07:43 -0400
Received: from main.gmane.org ([80.91.229.2]:41945 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964992AbWD0JHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 05:07:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: C++ pushback
Date: Thu, 27 Apr 2006 15:09:28 +0600
Message-ID: <e2q1iu$357$1@sea.gmane.org>
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>	<mj+md-20060424.201044.18351.atrey@ucw.cz>	<444D44F2.8090300@wolfmountaingroup.com>	<1145915533.1635.60.camel@localhost.localdomain> <20060425001617.0a536488@werewolf.auna.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212.220.94.19
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
In-Reply-To: <20060425001617.0a536488@werewolf.auna.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> Tell me what is the difference between:
> 
> 
>     sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
>     if (!sbi)
>         return -ENOMEM;
>     sb->s_fs_info = sbi;
>     memset(sbi, 0, sizeof(*sbi));
>     sbi->s_mount_opt = 0;
>     sbi->s_resuid = EXT3_DEF_RESUID;
>     sbi->s_resgid = EXT3_DEF_RESGID;
> 
> and
> 
>     SuperBlock() : s_mount_opt(0), s_resuid(EXT3_DEF_RESUID), s_resgid(EXT3_DEF_RESGID)
>     {}
> 
>     ...
>     sbi = new SuperBlock;
>     if (!sbi)
>         return -ENOMEM;
> 
> apart that you don't get members initalized twice and get a shorter code :).

The second example is simply incorrect, because the operator new throws an 
exception when we run out of memory, instead of returning a null pointer.

So it has to be written as:

sbi = new SuperBlock;
/* The rest of code assumes that the sbi pointer is valid. If this was not the 
case, let's hope that the caller caught std::bad_alloc properly */

-- 
Alexander E. Patrakov

