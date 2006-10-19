Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946159AbWJSQJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946159AbWJSQJv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 12:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946155AbWJSQJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 12:09:51 -0400
Received: from ns1.suse.de ([195.135.220.2]:57250 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946161AbWJSQJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 12:09:50 -0400
To: Vasily Tarasov <vtaras@openvz.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] diskquota: 32bit quota tools on 64bit architectures
References: <200610191232.k9JCW7CF015486@vass.7ka.mipt.ru>
From: Andi Kleen <ak@suse.de>
Date: 19 Oct 2006 18:09:35 +0200
In-Reply-To: <200610191232.k9JCW7CF015486@vass.7ka.mipt.ru>
Message-ID: <p73hcy0b83k.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Tarasov <vtaras@openvz.org> writes:

> OpenVZ Linux kernel team has discovered the problem 
> with 32bit quota tools working on 64bit architectures.
> In 2.6.10 kernel sys32_quotactl() function was replaced by sys_quotactl() with
> the comment "sys_quotactl seems to be 32/64bit clean, enable it for 32bit"
> However this isn't right. Look at if_dqblk structure:
> 
> struct if_dqblk {
>         __u64 dqb_bhardlimit;
>         __u64 dqb_bsoftlimit;
>         __u64 dqb_curspace;
>         __u64 dqb_ihardlimit;
>         __u64 dqb_isoftlimit;
>         __u64 dqb_curinodes;
>         __u64 dqb_btime;
>         __u64 dqb_itime;
>         __u32 dqb_valid;
> };
> 
> For 32 bit quota tools sizeof(if_dqblk) == 0x44.
> But for 64 bit kernel its size is 0x48, 'cause of alignment!
> Thus we got a problem.
> Attached patch reintroduce sys32_quotactl() function,
> that handles the situation.

Thanks. But the code should be probably common somewhere in fs/*, not 
duplicated.

-Andi
