Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751204AbWGDIOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWGDIOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 04:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWGDIOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 04:14:45 -0400
Received: from mx1.suse.de ([195.135.220.2]:8898 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751204AbWGDIOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 04:14:44 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 1/2] x86-64 TIF flags for debug regs and io bitmap in ctxsw
Date: Tue, 4 Jul 2006 10:09:31 +0200
User-Agent: KMail/1.9.3
Cc: eranian@hpl.hp.com, linux-kernel@vger.kernel.org
References: <20060704072832.GB5902@frankl.hpl.hp.com> <1151999509.3109.6.camel@laptopd505.fenrus.org>
In-Reply-To: <1151999509.3109.6.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607041009.31588.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 July 2006 09:51, Arjan van de Ven wrote:
> > -		}
> > -	}
> > +	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
> > +	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
> > +		__switch_to_xtra(prev_p, next_p, tss);
> 
> well isn't this replacing an if() (which isn't cheap but also not
> expensive, due to unlikely()) with an atomic operation (which *is*
> expensive) ?

Where do you see an atomic operation?

Also on x86-64 unlikely is an no-op.

-Andi
