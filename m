Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWGDIWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWGDIWU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWGDIWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:22:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:3992 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751212AbWGDIWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:22:19 -0400
Subject: Re: [PATCH 1/2] x86-64 TIF flags for debug regs and io bitmap in
	ctxsw
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: eranian@hpl.hp.com, linux-kernel@vger.kernel.org
In-Reply-To: <200607041009.31588.ak@suse.de>
References: <20060704072832.GB5902@frankl.hpl.hp.com>
	 <1151999509.3109.6.camel@laptopd505.fenrus.org>
	 <200607041009.31588.ak@suse.de>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 10:22:16 +0200
Message-Id: <1152001336.3109.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-04 at 10:09 +0200, Andi Kleen wrote:
> On Tuesday 04 July 2006 09:51, Arjan van de Ven wrote:
> > > -		}
> > > -	}
> > > +	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
> > > +	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
> > > +		__switch_to_xtra(prev_p, next_p, tss);
> > 
> > well isn't this replacing an if() (which isn't cheap but also not
> > expensive, due to unlikely()) with an atomic operation (which *is*
> > expensive) ?
> 
> Where do you see an atomic operation?

test_tsk_thread_flag() ends up doing an atomic op afaics


