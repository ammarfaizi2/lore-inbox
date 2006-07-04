Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWGDKXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWGDKXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 06:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWGDKXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 06:23:06 -0400
Received: from ns.suse.de ([195.135.220.2]:61395 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751259AbWGDKXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 06:23:05 -0400
From: Andi Kleen <ak@suse.de>
To: Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: [PATCH 1/2] x86-64 TIF flags for debug regs and io bitmap in ctxsw
Date: Tue, 4 Jul 2006 12:22:42 +0200
User-Agent: KMail/1.9.3
Cc: arjan@infradead.org, eranian@hpl.hp.com, linux-kernel@vger.kernel.org
References: <200607040905.k6495M2l028360@harpo.it.uu.se>
In-Reply-To: <200607040905.k6495M2l028360@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607041222.42288.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 July 2006 11:05, Mikael Pettersson wrote:
> On Tue, 4 Jul 2006 01:14:13 -0700, Stephane Eranian wrote:
> >On Tue, Jul 04, 2006 at 09:51:49AM +0200, Arjan van de Ven wrote:
> >> > -		}
> >> > -	}
> >> > +	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
> >> > +	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
> >> > +		__switch_to_xtra(prev_p, next_p, tss);
> >> 
> >> well isn't this replacing an if() (which isn't cheap but also not
> >> expensive, due to unlikely()) with an atomic operation (which *is*
> >> expensive) ?
> >> 
> >Andi is right. I double checked the test_tsk_thread_flag() and it does not
> >use atomic ops.
> 
> The test_tsk_thread_flag() does not, but what about all the
> other places in the patch where currently unsychronised loads
> or stores of ->io_bitmap_ptr or ->debugreg7 get replaced or
> extended with locked-on-SMP {set,clear}_{tsk_,}thread_flag()
> operations?

They are all slow paths where it doesn't matter.

-Andi

