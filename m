Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268083AbUIPOSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268083AbUIPOSb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUIPOSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:18:31 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:59859 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268083AbUIPOSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:18:23 -0400
Subject: Re: get_current is __pure__, maybe __const__ even
From: Albert Cahalan <albert@users.sf.net>
To: Andi Kleen <ak@muc.de>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <m3llfaya29.fsf@averell.firstfloor.org>
References: <2ER4z-46B-17@gated-at.bofh.it>
	 <m3llfaya29.fsf@averell.firstfloor.org>
Content-Type: text/plain
Organization: 
Message-Id: <1095344098.3866.1396.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Sep 2004 10:14:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-16 at 02:58, Andi Kleen wrote:
> Albert Cahalan <albert@users.sf.net> writes:
> 
> > Andi Kleen writes:
> >
> >> Please CSE "current" manually. It generates
> >> much better code on some architectures
> >> because the compiler cannot do it for you.
> >
> > This looks fixable.
> 
> I tried it some years ago, but I ran into problems with the scheduler
> and some other code and dropped it.

Right now, I'm thinking the switch_to assembly
has bad asm constraints.

I count 8 items passed in or out of the asm.
I count 11 clobbers. You don't have 19 registers.

If you pass something in and then destroy it,
you're supposed to use a dummy output. Look at
the i386 version, where esi and edi are dummy
outputs for this reason.

I recall seeing i386 compilers complain about
clobbered inputs. I guess the x86-64 gcc needs
to have this warning added?


