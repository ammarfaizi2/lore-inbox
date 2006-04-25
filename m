Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWDYIPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWDYIPz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWDYIPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:15:55 -0400
Received: from smtp11.wanadoo.fr ([193.252.22.31]:14230 "EHLO
	smtp11.wanadoo.fr") by vger.kernel.org with ESMTP id S1750797AbWDYIPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:15:54 -0400
X-ME-UUID: 20060425081553549.8619A1C0008C@mwinf1112.wanadoo.fr
Subject: Re: C++ pushback
From: Xavier Bestel <xavier.bestel@free.fr>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <20060425001617.0a536488@werewolf.auna.net>
References: <4024F493-F668-4F03-9EB7-B334F312A558@iomega.com>
	 <mj+md-20060424.201044.18351.atrey@ucw.cz>
	 <444D44F2.8090300@wolfmountaingroup.com>
	 <1145915533.1635.60.camel@localhost.localdomain>
	 <20060425001617.0a536488@werewolf.auna.net>
Content-Type: text/plain
Message-Id: <1145952948.596.130.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Tue, 25 Apr 2006 10:15:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 00:16, J.A. Magallon wrote:

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

In the first case you know that exactely *one* kmalloc(GFP_KERNEL)
occurs. In the second case you have to browse SuperBlock's constructor
to check if it allocates things, needs to run with/without interrupts,
PREEMPT, whatever... (not even talking about exceptions).

	Xav


