Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268120AbUIPOkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268120AbUIPOkK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 10:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268113AbUIPOip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:38:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52748 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268111AbUIPOgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:36:23 -0400
Date: Thu, 16 Sep 2004 15:36:16 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sf.net>, Jakub Jelinek <jakub@redhat.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: get_current is __pure__, maybe __const__ even
Message-ID: <20040916153616.D31029@flint.arm.linux.org.uk>
Mail-Followup-To: Andi Kleen <ak@muc.de>,
	William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>,
	Jakub Jelinek <jakub@redhat.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1095288600.1174.5968.camel@cube> <20040915231518.GB31909@devserv.devel.redhat.com> <20040915232956.GE9106@holomorphy.com> <1095300619.2191.6392.camel@cube> <20040916023604.GH9106@holomorphy.com> <20040916100419.A31029@flint.arm.linux.org.uk> <20040916091128.GA55409@muc.de> <20040916103045.B31029@flint.arm.linux.org.uk> <20040916110355.GA20448@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040916110355.GA20448@muc.de>; from ak@muc.de on Thu, Sep 16, 2004 at 01:03:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 01:03:55PM +0200, Andi Kleen wrote:
> > The scheduler quite rightly expects, for any thread, that any variable
> > which may be stored in a CPU register before the context switch has the
> > same value as after the context switch.
> 
> Just current isn't a varible, it's some inline assembly in a inline
> function.  The question was if that function could be marked const/pure. 

Sigh.  What does that matter?

current_thread, which is what we should be talking about here, is
indeed a function, but its returned value depends wholely on the
stack pointer value.

Since the stack pointer and thread info are invariably coupled
together, it is right to mark it const/pure.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
