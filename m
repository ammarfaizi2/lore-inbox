Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbSJXO7m>; Thu, 24 Oct 2002 10:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265486AbSJXO7i>; Thu, 24 Oct 2002 10:59:38 -0400
Received: from cse.ogi.edu ([129.95.20.2]:50595 "EHLO church.cse.ogi.edu")
	by vger.kernel.org with ESMTP id <S265477AbSJXO7a>;
	Thu, 24 Oct 2002 10:59:30 -0400
To: Eduardo =?iso-8859-1?q?P=E9rez?= <100018135@alumnos.uc3m.es>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: async poll
References: <3DB722DC.3090306@netscape.com>
	<Pine.LNX.4.44.0210231543290.1581-100000@blue1.dev.mcafeelabs.com>
	<ef8452d35d47a17fae0094208bc02613@alumnos.uc3m.es>
From: "Charles 'Buck' Krasic" <krasic@acm.org>
Date: 24 Oct 2002 08:05:25 -0700
In-Reply-To: <ef8452d35d47a17fae0094208bc02613@alumnos.uc3m.es>
Message-ID: <xu4of9jand6.fsf@rabbit.cse.ogi.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduardo Pérez <100018135@alumnos.uc3m.es> writes:

> The only uses of threads in a full aio application is task
> independence (or interactivity) and process context separation

> Example from GUI side: Suppose your web (http) client is fully
> ported to aio (thus only one thread), if you have two windows and
> one window receives a big complicated html page that needs much CPU
> time to render, this window can block the other one. If you have a
> thread for each window, once the html parser has elapsed its
> timeslice, the other window can continue parsing or displaying its
> (tiny html) page.  (In fact you should use two (or more) threads per
> window, as html parsing shouldn't block widget redrawing (like menus
> and toolbars))

It's not strictly necessary to use threads here.  At least not with
gtk+.  I don't know whether other toolkits are the same.

Anyway with gtk+, you can install "idle callbacks".  These are
functions to be called whenever the GUI code has nothing to do.  If
you can transform your html parser(s) into idle function(s), then it
won't necessarily disrupt the GUI.  You just have to make sure that
the parser yields periodically (returns to gtk+).  Since parsers are
loop oriented, this shouldn't be too hard, you just make each call to
the function do 1 iteration of the top level loop.

My traffic generator, mxtraf, works this way.  It has a software
oscilliscope (gscope) that graphically displays signals in real time.
At the same time it does lots of IO work to generate synthetic network
traffic.  mxtraf is single threaded.

-- Buck

--
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
