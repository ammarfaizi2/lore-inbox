Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267815AbUHJXTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267815AbUHJXTL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267814AbUHJXTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:19:11 -0400
Received: from holomorphy.com ([207.189.100.168]:14829 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267815AbUHJXPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:15:14 -0400
Date: Tue, 10 Aug 2004 16:15:07 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Picco <Robert.Picco@hp.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1
Message-ID: <20040810231507.GF11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Picco <Robert.Picco@hp.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040810002110.4fd8de07.akpm@osdl.org> <200408100937.47451.jbarnes@engr.sgi.com> <20040810212033.GY11200@holomorphy.com> <41194EA5.80706@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41194EA5.80706@hp.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 06:39:33PM -0400, Robert Picco wrote:
> copy_thread expects a switch_stack below pt_regs  on the stack.  the 
> switch_stack would have the parent's bspstore value for computing how 
> much register backing store to copy into child.  there isn't a 
> switch_stack and the resultant bspstore size computed is enormous 
> (depends on what there is on stack).  i suspect printk has changed stack 
> and the code layout changed too.
[...]
> 	 * For SMP idle threads, fork_by_hand() calls do_fork with
> 	 * NULL regs.
> 	 */
> -	if (!regs)
> +	if (clone_flags & CLONE_IDLETASK)
> 		return 0;
> #endif

It may not be immediately obvious, but since all the checks for
CLONE_IDLETASK were ripped out in patches prior to this, respecting
CLONE_IDLETASK anywhere means that userspace can create idle threads(!).
So the alternative fixes I've been posting are very necessary.


-- wli
