Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267520AbUHDXla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267520AbUHDXla (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 19:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267512AbUHDXks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 19:40:48 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:13565 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267514AbUHDXje (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 19:39:34 -0400
Date: Wed, 04 Aug 2004 16:39:04 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Carl Spalletta <cspalletta@yahoo.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Interesting failures of 'cscope'
Message-ID: <237280000.1091662744@flay>
In-Reply-To: <20040804232252.30644.qmail@web53802.mail.yahoo.com>
References: <20040804232252.30644.qmail@web53802.mail.yahoo.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Various versions of cscope are buggy as hell, and I'm not at all sure the
recent ones are any better than older ones ... caveat user ;-)

Personally I use an old binary ripped off RH 6.2, which still seems to
work ... any current ones I've tried are broken.

M.

--On Wednesday, August 04, 2004 16:22:52 -0700 Carl Spalletta <cspalletta@yahoo.com> wrote:

> FYI
> 
>   The first failure seems to be a confusion between function declarations and definitions - 
> eg for linux-2.6.7, it says FsmNew() is called by drivers/isdn/hisax/fsm.h::CallcNew, thus:
> 
> $cscope -d -p9 -L -3 FsmNew
>   ...
>   drivers/isdn/hisax/fsm.h CallcNew 50 int FsmNew(struct Fsm *fsm, struct FsmNode,*fnlist, int
> fncount);
>   ...
> 
>   but there is no call there, only an external declaration of FsmNew, and no declaration of
> CallcNew of any kind whatsoever in that file!
> 
> 
>   The second failure appears to be related to an inability to cope with complicated declarations
> within a prototype, such of those of type pointer-to-function. For example, the definition:
> 
>   struct net_device *alloc_netdev(int sizeof_priv, const char *mask, 
>                                          void (*setup)(struct net_device *))
> 
> from line 73 of drivers/net/net_init.c, is not recognized by cscope as a valid function definition
> and so it does not find the call to kmalloc (or anything else) contained in that function.
> 
> $ cscope -d -p9 -L -1 alloc_netdev
> <nothing>
> $ cscope -d -p9 -L -3 kmalloc | grep alloc_netdev
> <nothing>
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


