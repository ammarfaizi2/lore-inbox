Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWBRRBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWBRRBs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 12:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWBRRBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 12:01:47 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:20658 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932078AbWBRRBq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 12:01:46 -0500
Message-ID: <43F76538.16BBA317@tv-sign.ru>
Date: Sat, 18 Feb 2006 21:19:36 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] fix kill_proc_info() vs fork() theoretical race
References: <43E77D3C.C967A275@tv-sign.ru> <20060214223214.GG1400@us.ibm.com> <43F3352C.E2D8F998@tv-sign.ru> <43F37D56.2D7AB32F@tv-sign.ru> <20060216192617.GF1296@us.ibm.com> <43F4E6EC.3B9F91C4@tv-sign.ru> <20060216195341.GG1296@us.ibm.com> <43F4EC88.D8B2DEE5@tv-sign.ru> <20060218020659.GH1291@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" wrote:
> 
> On Fri, Feb 17, 2006 at 12:20:08AM +0300, Oleg Nesterov wrote:
> > "Paul E. McKenney" wrote:
> > >
> > > The other thing to think through is tkill on a thread/process while it
> > > is being created.  I believe that this is OK, since thread-specific
> > > kill must target a specific thread, so does not do the traversal.
> >
> > Also, tkill was not converted to use rcu_read_lock yet, it still
> > takes tasklist_lock, so I think it is safe.
> 
> I suspect that tkill will eventually need to avoid tasklist_lock...  ;-)

Ok, I am sending a couple of preparation patches for this.

Paul, I didn't beleive you when you started this work. Now I think
we can avoid tasklist AND cleanup the code in many places. I am glad
I was wrong.

Btw,
>
> firing off some steamroller tests on it.

Could you point me to these tests?

Oleg.
