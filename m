Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267890AbUIPJdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267890AbUIPJdb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 05:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267974AbUIPJc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 05:32:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57351 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S267893AbUIPJax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 05:30:53 -0400
Date: Thu, 16 Sep 2004 10:30:45 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sf.net>, Jakub Jelinek <jakub@redhat.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: get_current is __pure__, maybe __const__ even
Message-ID: <20040916103045.B31029@flint.arm.linux.org.uk>
Mail-Followup-To: Andi Kleen <ak@muc.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	Jakub Jelinek <jakub@redhat.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1095288600.1174.5968.camel@cube> <20040915231518.GB31909@devserv.devel.redhat.com> <20040915232956.GE9106@holomorphy.com> <1095300619.2191.6392.camel@cube> <20040916023604.GH9106@holomorphy.com> <20040916100419.A31029@flint.arm.linux.org.uk> <20040916091128.GA55409@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040916091128.GA55409@muc.de>; from ak@muc.de on Thu, Sep 16, 2004 at 11:11:28AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 11:11:28AM +0200, Andi Kleen wrote:
> > IOW, think from a tasks point of view.  It gets into the scheduler,
> > and switch_to() is just a normal function which just happens to sleep
> > for some time.
> 
> On x86/x86-64 the stack switch is inlined into schedule() 

Yes, and does it not save the whole CPU context and restore it, or tell
the compiler that certain registers which you don't preserve are
clobbered?  If it didn't, I think you'd find that you have a bug
there.

The scheduler quite rightly expects, for any thread, that any variable
which may be stored in a CPU register before the context switch has the
same value as after the context switch.

(note - "preserve" above - I don't mean from one thread to another,
I mean preserved within the context of one thread.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
