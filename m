Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030427AbWGNJWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030427AbWGNJWV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 05:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030432AbWGNJWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 05:22:21 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:37251 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030427AbWGNJWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 05:22:20 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Rt-tester makes freezing processes fail.
Date: Fri, 14 Jul 2006 10:17:27 +0200
User-Agent: KMail/1.9.3
Cc: nigel@suspend2.net, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       tglx@timesys.com, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
References: <200607140918.49040.nigel@suspend2.net> <20060713163743.e71975b0.akpm@osdl.org>
In-Reply-To: <20060713163743.e71975b0.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607141017.27832.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 July 2006 01:37, Andrew Morton wrote:
> On Fri, 14 Jul 2006 09:18:43 +1000
> Nigel Cunningham <nigel@suspend2.net> wrote:
> 
> > Compiling in the rt-tester currently makes freezing processes fail.
> > I don't think there's anything wrong with it running during
> > suspending, so adding PF_NOFREEZE to the flags set seems to be the
> > right solution.
> > 
> > Signed-off-by: Nigel Cunningham <nigel@suspend2.net>
> > 
> >  rtmutex-tester.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > diff -ruNp 9971-rt-tester.patch-old/kernel/rtmutex-tester.c 9971-rt-tester.patch-new/kernel/rtmutex-tester.c
> > --- 9971-rt-tester.patch-old/kernel/rtmutex-tester.c	2006-07-07 10:27:46.000000000 +1000
> > +++ 9971-rt-tester.patch-new/kernel/rtmutex-tester.c	2006-07-14 07:48:01.000000000 +1000
> > @@ -259,7 +259,7 @@ static int test_func(void *data)
> >  	struct test_thread_data *td = data;
> >  	int ret;
> >  
> > -	current->flags |= PF_MUTEX_TESTER;
> > +	current->flags |= PF_MUTEX_TESTER | PF_NOFREEZE;
> >  	allow_signal(SIGHUP);
> >  
> >  	for(;;) {
> 
> 
> I yesterday queued up the below patch.  Which approach is most appropriate?

I prefer the one that makes these threads freeze (ie. the Luca's patch).

Greetings,
Rafael
