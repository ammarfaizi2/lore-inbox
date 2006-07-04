Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWGDIWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWGDIWZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWGDIWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:22:25 -0400
Received: from tayrelbas04.tay.hp.com ([161.114.80.247]:982 "EHLO
	tayrelbas04.tay.hp.com") by vger.kernel.org with ESMTP
	id S1751217AbWGDIWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:22:24 -0400
Date: Tue, 4 Jul 2006 01:14:13 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH 1/2] x86-64 TIF flags for debug regs and io bitmap in ctxsw
Message-ID: <20060704081413.GE5902@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20060704072832.GB5902@frankl.hpl.hp.com> <1151999509.3109.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151999509.3109.6.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan,

On Tue, Jul 04, 2006 at 09:51:49AM +0200, Arjan van de Ven wrote:
> > -		}
> > -	}
> > +	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
> > +	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
> > +		__switch_to_xtra(prev_p, next_p, tss);
> 
> well isn't this replacing an if() (which isn't cheap but also not
> expensive, due to unlikely()) with an atomic operation (which *is*
> expensive) ?
> 
Andi is right. I double checked the test_tsk_thread_flag() and it does not
use atomic ops.

-- 
-Stephane
