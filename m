Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267686AbTCFB60>; Wed, 5 Mar 2003 20:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267688AbTCFB60>; Wed, 5 Mar 2003 20:58:26 -0500
Received: from to-wiznet.redhat.com ([216.129.200.2]:61692 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S267686AbTCFB6Z>; Wed, 5 Mar 2003 20:58:25 -0500
Date: Wed, 5 Mar 2003 21:08:56 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Better CLONE_SETTLS support for Hammer
Message-ID: <20030305210856.B16093@redhat.com>
References: <3E664836.7040405@redhat.com> <20030305190622.GA5400@wotan.suse.de> <3E6650D4.8060809@redhat.com> <20030305212107.GB7961@wotan.suse.de> <3E668267.5040203@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E668267.5040203@redhat.com>; from drepper@redhat.com on Wed, Mar 05, 2003 at 03:04:07PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 03:04:07PM -0800, Ulrich Drepper wrote:
> I wouldn't want to either in your position.  You caused this whole mess
> and now you're not willing to fix it.

I disagree.  We don't need to use a segment register to get the thread 
library equivalent of "current".  Changing the segment registers on a 
per process basis is a waste of time in the context switch.  Instead, 
making x86-64 TLS support based off of the stack pointer, or even using 
a fixed per-cpu segment register such that gs:0 holds the pointer to the 
thread "current" would be better.  Make the users of threads suffer, not 
every single application and syscall in the system.

		-ben
-- 
Junk email?  <a href="mailto:aart@kvack.org">aart@kvack.org</a>
