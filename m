Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269168AbUJTTZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269168AbUJTTZT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270240AbUJTTTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:19:51 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:40843 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S269013AbUJTTSk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:18:40 -0400
Date: Wed, 20 Oct 2004 21:18:39 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/3] lsm: add bsdjail module
Message-ID: <20041020191839.GB30342@mail.13thfloor.at>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	"Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	chrisw@osdl.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1097094103.6939.5.camel@serge.austin.ibm.com> <1097094270.6939.9.camel@serge.austin.ibm.com> <20041006162620.4c378320.akpm@osdl.org> <20041007190157.GA3892@IBM-BWN8ZTBWA01.austin.ibm.com> <20041010104113.GC28456@infradead.org> <1097502444.31259.19.camel@localhost.localdomain> <20041012070055.GB7003@DUMA.13thfloor.at> <20041012090057.GA15706@infradead.org> <20041012122733.GD8012@DUMA.13thfloor.at> <20041020153621.GA21916@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041020153621.GA21916@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2004 at 04:36:21PM +0100, Christoph Hellwig wrote:
> On Tue, Oct 12, 2004 at 02:27:33PM +0200, Herbert Poetzl wrote:
> > On Tue, Oct 12, 2004 at 10:00:57AM +0100, Christoph Hellwig wrote:
> > > On Tue, Oct 12, 2004 at 09:00:55AM +0200, Herbert Poetzl wrote:
> > > > and it works well, because we use it for almost
> > > > a year now on linux-vserver ;)
> > > 
> > > Btw, could anyone explain the exact differences between linux-vserver
> > > and this jail module?
> > 
> > hmm, okay I'll try ...
> > 
> > linux-vserver is a combination of kernel patch and
> > userspace tools to create 'virtual servers' similar
> > to UML, but sharing the resources (and kernel).
> > 
> > to do this, it uses process isolation, network
> > isolation and disk space separation (tagging). 
> > in addition it does resource management (accounting
> > and limits) for various aspects (CPU, memory, 
> > processes, sockets, filehandles, ...)
> > 
> > the jail module is recreating a limited subset of
> > the isolation aspect via LSM (similar to the BSD
> > jail) which allows to confine a process (and it's
> > children) to a chroot() environment under certain
> > limitations (resources)
> 
> So why
> 
>  a) can't linux-vserver use LSM hooks where applicable

well, it could, and probably in future it will do so,
but currently there are three reasons which keep me
from doing that:

 1) some folks want to use LSM for other things, and
    proper stackering of LSM was broken/missing last
    time I looked at the code 

 2) performance: I'm not convinced that the LSM
    hooks are a good choice, where a single check
    of a flag (in current) is more than sufficient
 
 3) why move 20% of linux vserver to LSM, where
    those 20% can not do anything useful without the
    remaining 80% (or at least some part of it)
    which can not be done with LSM for various
    reasons.

>  b) can't the two projects share code so we don't only have a crippled
>     version in mainline

I'm sure the projects can share code, and IMHO the
best solution would be to create a 'cripled' version
of linux-vserver and to include it in mainline (if
that is what kernel folks want) and to slowly extend
this version where possible, moving existing code
from linux-vserver into mainline ...

once CKRM is working and included, and LSM provides
the 'security' features, linux-vserver might become
a simple compile time option ...

best,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
