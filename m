Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319376AbSHVPxV>; Thu, 22 Aug 2002 11:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319377AbSHVPxV>; Thu, 22 Aug 2002 11:53:21 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:57078 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S319376AbSHVPxU>; Thu, 22 Aug 2002 11:53:20 -0400
Date: Thu, 22 Aug 2002 11:57:29 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk simultaneous oops disentangling
Message-ID: <20020822115729.C16763@redhat.com>
References: <12669.1030018158@warthog.cambridge.redhat.com> <20020822115114.B16763@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020822115114.B16763@redhat.com>; from bcrl@redhat.com on Thu, Aug 22, 2002 at 11:51:14AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2002 at 11:51:14AM -0400, Benjamin LaHaise wrote:
> On Thu, Aug 22, 2002 at 01:09:18PM +0100, David Howells wrote:
> > Hi Linus,
> > 
> > Here's a patch to stop multiple simultaneous oopses on an SMP system from
> > interleaving with and overwriting bits of each other. It only permits lock
> > breaking if the printk lock is held by the same CPU.
> 
> This is still wrong.  It should attempt to acquire the locks with a timeout 
> before trampling on them, as there may be a printk or other console output 
> in progress on the other cpu.

/me must be having a bad week

The patch is actually right, but bust_spinlocks still blindly stops on locks 
that may not need to be stomped on.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
