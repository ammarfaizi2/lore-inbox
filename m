Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262829AbSIPStx>; Mon, 16 Sep 2002 14:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSIPStx>; Mon, 16 Sep 2002 14:49:53 -0400
Received: from air-2.osdl.org ([65.172.181.6]:56198 "EHLO
	wookie-t23.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S262829AbSIPStw>; Mon, 16 Sep 2002 14:49:52 -0400
Subject: Re: Killing/balancing processes when overcommited
From: "Timothy D. Witham" <wookie@osdl.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L.0209161102120.1857-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0209161102120.1857-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 16 Sep 2002 11:49:23 -0700
Message-Id: <1032202163.1458.351.camel@wookie-t23.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  
On Mon, 2002-09-16 at 07:03, Rik van Riel wrote:
> On Mon, 16 Sep 2002, Helge Hafting wrote:
> > Rik van Riel wrote:
> >
> > > 1) memory is exhausted
> > > 2) the network driver can't allocate memory and
> > >    spits out a message
> > > 3) syslogd and/or klogd get killed
> > >
> > > Clearly you want to be a bit smarter about which process to kill.
> >
> > Ill-implemented klogd/syslogd.  Pre-allocating a little memory
> > is one way to go, or drop messages until allocation
> > becomes possible again.  Then log a complaint about
> > messages missing due to a temporary OOM.
> 
> No.  This has absolutely nothing to do with it.
> 
> In this case, "allocating memory" simply means that klogd/syslogd
> page faults on something it already allocated, say a piece of the
> executable or a swapped-out buffer.
> 
> Simple page faults like this can also trigger an OOM-killing.
> 

  Not in what I had described.  Unless the page fault was for a
new page (just malloc'ed) it wouldn't result in the killing of
the process.

Tim

> Rik
> -- 
> Bravely reimplemented by the knights who say "NIH".
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> Spamtraps of the month:  september@surriel.com trac@trac.org
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

