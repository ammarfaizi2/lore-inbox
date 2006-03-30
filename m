Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWC3MQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWC3MQc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 07:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWC3MQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 07:16:32 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54598 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932191AbWC3MQb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 07:16:31 -0500
Date: Thu, 30 Mar 2006 14:16:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] splice support #2
Message-ID: <20060330121638.GA13476@suse.de>
References: <20060330100630.GT13476@suse.de> <20060330120055.GA10402@elte.hu> <20060330120512.GX13476@suse.de> <20060330121030.GA14621@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330121030.GA14621@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30 2006, Ingo Molnar wrote:
> 
> * Jens Axboe <axboe@suse.de> wrote:
> 
> > On Thu, Mar 30 2006, Ingo Molnar wrote:
> > > 
> > > * Jens Axboe <axboe@suse.de> wrote:
> > > 
> > > > Hi,
> > > > 
> > > > This patch should resolve all issues mentioned so far. I'd still like 
> > > > to implement the page moving, but that should just be a separate 
> > > > patch.
> > > 
> > > neat stuff. One question: why do we require fdin or fdout to be a pipe?  
> > > Is there any fundamental problem with implementing what Larry's original 
> > > paper described too: straight pagecache -> socket transfers? Without a
> > > pipe intermediary forced inbetween. It only adds unnecessary overhead.
> > 
> > No, not a fundamental problem. I think I even hid that in some comment 
> > in there, at least if it's decipharable by someone else than myself... 
> > Basically I think it would be nice in the future to tidy this a little 
> > bit and separate the actual container from the pipe itself - and have 
> > the pipe just fill/use the same container.
> 
> why is there a container needed at all? If i splice pagecache->socket, 
> we can use sendpage to send it off immediately. There is no need for any 
> container - both the pagecache and sendpage use struct page, and when we 
> iterate to create a container we might as well ->sendpage() those pages 
> off immediately instead.
> 
> I agree with the purpose of making sys_splice() generic and in 
> particular usable in scripts/shells where pipes are commonly used, but 
> we should also fulfill the original promise (outlined 15 years ago or 
> so) and not limit this to pipes. That way i could improve TUX to make 
> use of it for example ;)

There's absolutely no reason why we can't add fd -> fd splicing as well,
so no worries. Right now we just require a pipe transport. It's
extendable :-)

-- 
Jens Axboe

