Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315617AbSENLii>; Tue, 14 May 2002 07:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315619AbSENLii>; Tue, 14 May 2002 07:38:38 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:6910 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S315617AbSENLig>;
	Tue, 14 May 2002 07:38:36 -0400
Date: Tue, 14 May 2002 07:38:33 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [PATCH] 2.5.1[345]-dj Add cpqarray_init() back into genhd.c
Message-ID: <20020514113833.GA16460@www.kroptech.com>
In-Reply-To: <20020514024908.GA7695@www.kroptech.com> <6976.1021347098@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 01:31:38PM +1000, Keith Owens wrote:
> On Mon, 13 May 2002 22:49:08 -0400, 
> Adam Kropelin <akropel1@rochester.rr.com> wrote:
> >On Tue, May 14, 2002 at 12:24:23PM +1000, Keith Owens wrote:
> >> The real problem appears to be cpqarray.c, it wraps the init/exit code
> >> in #ifdef MODULE, so the init code is only available to modules.  I
> >> think that cpqarray.c should remove the #ifdef MODULE and use the same
> >> init mechanism as other drivers, including module_init/exit.  I don't
> >> have a card and the code is a mess so I am not going to attempt a patch.
> >
> >I'm not seeing it. I see init_module() and cleanup_module() wrapped as you say
> >but cpqarray_init() is outside the #ifdef. Also, two versions of cpqarray_setup
> >are provided based on #ifdef MODULE but this doesn't look problematic to me.
> >I'm a newbie, for sure. Am I overlooking something obvious?
> 
> The call to cpqarray_init() is from init_module() which does not exist
> when the code is built in.  See drivers/block/loop.c for an example of
> the correct use of init and exit routines, using module_init and
> module_exit.

Ah, I think I see your point now. The call to cpqarray_init() from genhd.c was
a hack, needed only because cpqarray doesn't use the module_init/module_exit
mechanism. Sorry I took so long to catch on and thanks for your patience.

Since I do have a card and the motivation to see this driver work when 
compiled-in, I'll attempt a more correct fix tonight.

--Adam

