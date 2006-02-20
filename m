Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbWBTRtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbWBTRtQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 12:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161082AbWBTRtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 12:49:16 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:50112 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161078AbWBTRtP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 12:49:15 -0500
Date: Mon, 20 Feb 2006 09:49:11 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] fix kill_proc_info() vs fork() theoretical race
Message-ID: <20060220174911.GE1480@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43E77D3C.C967A275@tv-sign.ru> <20060214223214.GG1400@us.ibm.com> <43F3352C.E2D8F998@tv-sign.ru> <43F37D56.2D7AB32F@tv-sign.ru> <20060216192617.GF1296@us.ibm.com> <43F4E6EC.3B9F91C4@tv-sign.ru> <20060216195341.GG1296@us.ibm.com> <43F4EC88.D8B2DEE5@tv-sign.ru> <20060218020659.GH1291@us.ibm.com> <43F76538.16BBA317@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F76538.16BBA317@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 09:19:36PM +0300, Oleg Nesterov wrote:
> "Paul E. McKenney" wrote:
> > 
> > On Fri, Feb 17, 2006 at 12:20:08AM +0300, Oleg Nesterov wrote:
> > > "Paul E. McKenney" wrote:
> > > >
> > > > The other thing to think through is tkill on a thread/process while it
> > > > is being created.  I believe that this is OK, since thread-specific
> > > > kill must target a specific thread, so does not do the traversal.
> > >
> > > Also, tkill was not converted to use rcu_read_lock yet, it still
> > > takes tasklist_lock, so I think it is safe.
> > 
> > I suspect that tkill will eventually need to avoid tasklist_lock...  ;-)
> 
> Ok, I am sending a couple of preparation patches for this.
> 
> Paul, I didn't beleive you when you started this work. Now I think
> we can avoid tasklist AND cleanup the code in many places. I am glad
> I was wrong.

And I am very glad that you are working this -- you have found some
approaches that are much better than those I would have come up with!

> Btw,
> >
> > firing off some steamroller tests on it.
> 
> Could you point me to these tests?

http://www.rdrop.com/users/paulmck/projects/steamroller/

Contributions of additional tests very welcome!

							Thanx, Paul
