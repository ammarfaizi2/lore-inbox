Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266085AbUGMViw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266085AbUGMViw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266097AbUGMViw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:38:52 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:63663 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S266085AbUGMVig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:38:36 -0400
Message-ID: <006401c46929$f3edf390$161b14ac@boromir>
From: "Martijn Sipkema" <msipkema@sipkema-digital.com>
To: "Paul Davis" <paul@linuxaudiosystems.com>
Cc: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>,
       <florin@sgi.com>, <linux-kernel@vger.kernel.org>,
       <albert@users.sourceforge.net>
References: <200407131455.i6DEtmAo006203@localhost.localdomain>
Subject: Re: [linux-audio-dev] Re: desktop and multimedia as an afterthought? 
Date: Tue, 13 Jul 2004 23:37:12 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1409
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul Davis" <paul@linuxaudiosystems.com>
> >Thus, the fact that Linux does not support protocols to prevent priority
> >inversion (please correct me if I am wrong) kind of suggests that supporting
> >realtime applications is not considered very important.
> 
> we went through this (you and i in particular) right here on LAD a
> year or so ago. while i might agree with you about the priority given
> to RT-ish apps, my recollection of the end of that discussion is that
> priority inheritance is neither necessary nor sufficient to allow
> adequate RT performance.

I don't recall that that is what was concluded.

Priority inheritance or some other protocol for priority inversion _is_
needed for realtime applications that have threads with different priorities
accessing common data. One could increase the priority of the low priority
thread before taking the mutex and release it afterwards (as in priority
ceiling), but I doubt that's optimal.

> priority inversion generally can be factored
> out through application redesign, and the protocols i've seen to
> address it are not useful for RT purposes - they just help deadlock.

For cases where some form of message passing does not work you
will need shared data with a mutex to serialize access and you _will_
need to prevent priority inversion. Mutexes are part of the POSIX
realtime threading extensions; you can use a semaphore when
priority inversion is not an issue.

IMHO it is the lack of a mutex implementation with priority ceiling
or inheritance and the stories about relying on either being a design
problem that have caused the Linux audio community to not use
mutexes and declare them non-RT safe while in fact they are
required according to POSIX to synchronize memory between
cooperating threads.

--ms



