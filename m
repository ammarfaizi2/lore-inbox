Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313443AbSDGTcz>; Sun, 7 Apr 2002 15:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313444AbSDGTcy>; Sun, 7 Apr 2002 15:32:54 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:39434 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S313443AbSDGTcv>; Sun, 7 Apr 2002 15:32:51 -0400
Date: Sun, 7 Apr 2002 20:32:46 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Steven N. Hirsch" <shirsch@adelphia.net>, linux-kernel@vger.kernel.org
Subject: Re: Two fixes for 2.4.19-pre5-ac3
Message-ID: <20020407193245.GA21570@compsoc.man.ac.uk>
In-Reply-To: <20020407192324.GA21491@compsoc.man.ac.uk> <E16uIYq-0006Xf-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 08:42:48PM +0100, Alan Cox wrote:

> > I'll genuinely take on board advice on how I can profile all the system
> > via x86 perf counters efficiently without having to patch the kernel.
> > The old way just uses sys_call_table. So what do I do now ?
> 
> The obvious thing is to represent it as a device. I'm not familiar enough
> with the existing perfctr work to know how well that works out.

The system call tracking is only used to associate a particular EIP with
a particular offset in some binary image. There's no other efficient
method to capture the mmap() calls for these images, for everything
running. ptrace() is only really useful for a small number of processes,
and is slow. Offline post-analysis isn't possible. There is no
API for getting access to this information.

Removing sys_call_table from exports won't have any positive effect.
Using it has always been "well, you're on your own" - if there is a
really good reason it needs to be changed, fine; but just changing it
because it's not supposed to be used isn't a good enough reason when
there is actually a couple of niche cases where it's the only option.

imho,
john

-- 
"I never understood what's so hard about picking a unique
 first and last name - and not going beyond the 6 character limit."
 	- Toon Moene
