Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272019AbRIDROT>; Tue, 4 Sep 2001 13:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272021AbRIDROK>; Tue, 4 Sep 2001 13:14:10 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:56977 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S272019AbRIDRNx>; Tue, 4 Sep 2001 13:13:53 -0400
Date: Tue, 4 Sep 2001 13:14:02 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <20010904131401.A30296@cs.cmu.edu>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010904112629.A27988@cs.cmu.edu> <Pine.LNX.4.21.0109041220260.1578-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0109041220260.1578-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.20i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 12:24:36PM -0300, Marcelo Tosatti wrote:
> On Tue, 4 Sep 2001, Jan Harkes wrote:
> > On Mon, Sep 03, 2001 at 11:57:09AM -0300, Marcelo Tosatti wrote:
> > > I already have some code which adds a laundry list -- pages being written
> > > out (by page_launder()) go to the laundry list, and each page_launder()
> > > call will first check for unlocked pages on the laundry list, for then
> > > doing the usual page_launder() stuff.
> > 
> > NO, please don't add another list to fix the symptoms of bad page aging.
> 
> Please, read my message again.

Sorry, it was a reaction to all the VM nonsense that has been flying
around lately. The a lot of complaints and discussions wouldn't even
have started if we actually moved _inactive_ pages to the inactive list
instead of random pages.

To get back on the thread I jumped into, I totally agree with Linus that
writeout should be as soon as possible. Probably even as soon as an
inactive dirty page hits the inactive dirty list, which would
effectively turn the inactive dirty list into your laundry list.

Jan
