Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVFBUkq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVFBUkq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 16:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVFBUjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 16:39:55 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30728 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261251AbVFBUi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:38:26 -0400
Date: Thu, 2 Jun 2005 22:38:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Baruch Even <baruch@ev-en.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.12-rc5-mm2: "bic unavailable using TCP reno" messages
Message-ID: <20050602203823.GI4992@stusta.de>
References: <20050601022824.33c8206e.akpm@osdl.org> <20050602121511.GE4992@stusta.de> <429F1079.5070701@ev-en.org> <20050602103805.6beb4f4e@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050602103805.6beb4f4e@dxpl.pdx.osdl.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 10:38:05AM -0700, Stephen Hemminger wrote:
> On Thu, 02 Jun 2005 14:58:17 +0100
> Baruch Even <baruch@ev-en.org> wrote:
> 
> >...
> 
> Your right, the sysctl handler should be smarter, but that is not the problem here.
> The problem is that the default value is set to be BIC to be compatible with earlier kernels.
> Since 75% of the world isn't smart enough to figure out how to use sysctl, there is a
> question of what the default should be, and what to do if that is missing.
> 
> One version had a messy ifdef chain to try and avoid the warning:
> 
> char sysctl_tcp_congestion_control[] = 
> #if defined(CONFIG_TCP_BIC)
> 	"bic"
> #elif defined(CONFIG_TCP_HTCP)
> 	"htcp"
> #else
> 	"reno"
> #endif
> 	;
> 
> but that was ugly.
> 
> Another possibility is putting it in as yet another config value at kernel build time.
>...


One thing that currently makes all solutions harder (and the #ifdef 
example above not ugly but simply wrong) is that you allow modular 
congestion control options for the always static net support.

Is this really required?


The IO schedulers have a similar problem, and they are using the #ifdef 
approach for selecting the default.


One approach is to actually choose the default using #ifdef's.

You could also do any kind of runtime selection, but please don't print 
the warning more than once.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

