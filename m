Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267021AbTAWVGt>; Thu, 23 Jan 2003 16:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267121AbTAWVGt>; Thu, 23 Jan 2003 16:06:49 -0500
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:4744 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S267021AbTAWVGs>; Thu, 23 Jan 2003 16:06:48 -0500
Date: Thu, 23 Jan 2003 19:28:29 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Kevin Lawton <kevinlawton2001@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please consider)
Message-ID: <20030123192829.A628@nightmaster.csn.tu-chemnitz.de>
References: <20030122182341.66324.qmail@web80309.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030122182341.66324.qmail@web80309.mail.yahoo.com>; from kevinlawton2001@yahoo.com on Wed, Jan 22, 2003 at 10:23:41AM -0800
X-Spam-Score: -2.5 (--)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18boha-0001aH-00*EHvUlgpbPHU*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2003 at 10:23:41AM -0800, Kevin Lawton wrote:
> For this, there's a few critical but simple diffs to
> macro'ize the use of the PUSHF and POPF instructions,
> due to broken semantics of running stuff using
> PVI (protected mode virtual interrupts).  The rest of
> the stuff I believe can be monitored effectively by
> the VM monitor.

Yes, what you do is nice, but generates much code. What about
this for pushfl:

pushfl
push %eax
pushfl
pop %eax
orb $(1<<1),%ah  /* same as orl $(1<<9),%eax */
testl $(1<<19),%eax
jnz 69001f
andb $~(1<<1),%ah /* same as andl $~(1<<9),%eax */
69001:
mov %eax,4(%esp)
pop %eax


? This saves 6 bytes, which is a 20% code reduction ;-)

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
