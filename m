Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281556AbRKPV1l>; Fri, 16 Nov 2001 16:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281555AbRKPV1c>; Fri, 16 Nov 2001 16:27:32 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:12281
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281556AbRKPV1S>; Fri, 16 Nov 2001 16:27:18 -0500
Date: Fri, 16 Nov 2001 13:27:07 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: James Bourne <jbourne@MtRoyal.AB.CA>
Cc: Nagy Tibor <nagyt@otpbank.hu>, linux-kernel@vger.kernel.org,
        jesper@home.linuxpusher.dk, jalvo@mbay.net
Subject: Re: 2.2.14 hangs on Dell PowerEdge 6300
Message-ID: <20011116132707.B21354@mikef-linux.matchmail.com>
Mail-Followup-To: James Bourne <jbourne@MtRoyal.AB.CA>,
	Nagy Tibor <nagyt@otpbank.hu>, linux-kernel@vger.kernel.org,
	jesper@home.linuxpusher.dk, jalvo@mbay.net
In-Reply-To: <3BF4C19A.10E7844F@otpbank.hu> <Pine.LNX.4.33.0111160718370.12990-100000@jbourne2.mtroyal.ab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111160718370.12990-100000@jbourne2.mtroyal.ab.ca>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2001 at 07:25:44AM -0700, James Bourne wrote:
> On Fri, 16 Nov 2001, Nagy Tibor wrote:
> 
> > I am sorry, this the same message as yesterday, but I misstyped the
> > version. It is about 2.4..., of cource.
> >
> > Hi,
> >
> > we were satisfied with linux kernel version 2.4.9. Our linux server is
> > unusable with kernel version 2.4.10 and higher, also with 2.4.14
> > declared to be stable.
> >
> > We are working on Dell PowerEdge 6300 (4 Pentium Xeon/550Mhz, 4GB RAM).
> > Any kernel from 2.4.10 to 2.4.14 brings our machine to a hanging state.
> > Nothing can be determined, I guess, something is wrong with memory
> > management. Unfortunately there is no more information about the
> > problem.
> 
> I think you will need more information to get any type of sane reply.
> 
> We are running 2.4.14 on a PE6400, quad 700/4G in a production environment.
> It has been stable, VM works well, using ext2 due to problems with the ext3
> patch for that particular version of kernel.
> 

Do you mean the "cached" overflow (undeflow?) with ext3 applied?  If so,
this patch will fix it.

--- 2.4.14-ext3_0.9.15-2414/fs/jbd/transaction.c~	Wed Nov  7 22:41:13 2001
+++ 2.4.14-ext3_0.9.15-2414/fs/jbd/transaction.c	Wed Nov  7 22:43:14 2001
@@ -1930,7 +1930,6 @@
 
 	if (!offset) {
 		if (!may_free || !try_to_free_buffers(page, 0)) {
-			atomic_inc(&buffermem_pages);
 			return 0;
 		}
 		J_ASSERT(page->buffers == NULL);

Mike
