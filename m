Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbVKPX6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbVKPX6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030582AbVKPX6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:58:14 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8196 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030581AbVKPX6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:58:13 -0500
Date: Thu, 17 Nov 2005 00:58:13 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christian <evil@g-house.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.15-rc1: NET_CLS_U32 not working?
Message-ID: <20051116235813.GS5735@stusta.de>
References: <437BBC59.70301@g-house.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437BBC59.70301@g-house.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 12:10:17AM +0100, Christian wrote:
> hi,
> 
> i noticed that some of my QoS rules are not working any more. oh, i 
> forgot to enable CONFIG_NET_CLS_U32. but when enabled, i got the 
> following errors when compiling / installing the module:
> 
> * Warning: "unregister_tcf_proto_ops" [net/sched/cls_u32.ko] undefined!
> * Warning: "register_tcf_proto_ops" [net/sched/cls_u32.ko] undefined!
> * Warning: "tcf_exts_dump" [net/sched/cls_u32.ko] undefined!
> * Warning: "tcf_exts_dump_stats" [net/sched/cls_u32.ko] undefined!
> * Warning: "tcf_exts_change" [net/sched/cls_u32.ko] undefined!
> * Warning: "tcf_exts_validate" [net/sched/cls_u32.ko] undefined!
> * Warning: "tcf_exts_destroy" [net/sched/cls_u32.ko] undefined!
>...
> when i disabled CONFIG_NET_CLS_U32, everything compiles fine, but 
> cls_u32 is missing of course :-(
> 
> all the missing symbols seem to be defined in include/net/pkt_cls.h. but 
>  this file is #included by net/sched/cls_u32.c and other too, so i 
> don't really know, why it doesn't work.
> 
> FWIW, i see EXPORT_SYMBOLs at the very end of net/sched/cls_api.c, but i 
> can't see if/when cls_api.c is used (included?) at all.
>...


I'm assuming you are trying to insert the new module in your old kernel?

This is one of the unfortunate but hardly avoidable cases where adding a 
module requires installing a new kernel.


But there's a change in 2.6.15-rc1 that makes this issue much worse:
It is no longer user-visible.

tristate's select'ing bool's that do not change parts of the (modular) 
driver but compile additional code into the kernel are simply wrong.


> thanks for looking into that,
> Christian.
>...


cu
Adrian

BTW: Please Cc netdev@vger.kernel.org on networking issues.

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

