Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271169AbUJVDO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271169AbUJVDO1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 23:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271058AbUJVDLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 23:11:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24201 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S271169AbUJVDGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 23:06:07 -0400
From: Jesse Barnes <jbarnes@sgi.com>
To: Grant Grundler <iod00d@hp.com>
Subject: Re: [PATCH] I/O space write barrier
Date: Thu, 21 Oct 2004 22:05:50 -0500
User-Agent: KMail/1.7
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, tony.luck@intel.com,
       linux-ia64@vger.kernel.org
References: <200410211613.19601.jbarnes@engr.sgi.com> <20041022010150.GH3878@cup.hp.com>
In-Reply-To: <20041022010150.GH3878@cup.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410212205.51672.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 21, 2004 8:01 pm, Grant Grundler wrote:
> > +<programlisting>
> > +       sp->flags |= SRB_SENT;
> > +       ha->actthreads++;
> > +       WRT_REG_WORD(&amp;reg->mailbox4, ha->req_ring_index);
> > +
> > +       /*
> > +        * A Memory Mapped I/O Write Barrier is needed to ensure that
> > this write +        * of the request queue in register is ordered ahead
> > of writes issued +        * after this one by other CPUs.  Access to the
> > register is protected +        * by the host_lock.  Without the mmiowb,
> > however, it is possible for +        * this CPU to release the host lock,
> > another CPU acquire the host lock, +        * and write to the request
> > queue in, and have the second write make it +        * to the chip first.
> > +        */
> > +       mmiowb(); /* posted write ordering */
> > +</programlisting>
>
> This is the example code I'd like to see replaced with your
> synthetic example above.

Ok, that makes sense.  I'd like to update the documentation with a separate 
patch though, if that's ok with you.  I think Greg had some ideas about other 
things to cover as well.  Greg?

Thanks,
Jesse
