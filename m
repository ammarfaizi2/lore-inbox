Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275126AbRIYRit>; Tue, 25 Sep 2001 13:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275128AbRIYRij>; Tue, 25 Sep 2001 13:38:39 -0400
Received: from cb58709-a.mdsn1.wi.home.com ([24.17.241.9]:16389 "EHLO
	prism.flugsvamp.com") by vger.kernel.org with ESMTP
	id <S275126AbRIYRia>; Tue, 25 Sep 2001 13:38:30 -0400
Date: Tue, 25 Sep 2001 12:36:48 -0500 (CDT)
From: Jonathan Lemon <jlemon@flugsvamp.com>
Message-Id: <200109251736.f8PHamf40636@prism.flugsvamp.com>
To: dank@kegel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /dev/epoll update ...
X-Newsgroups: local.mail.linux-kernel
In-Reply-To: <local.mail.linux-kernel/3BB03C6A.7D1DD7B3@kegel.com>
In-Reply-To: <local.mail.linux-kernel/3BAEB39B.DE7932CF@kegel.com>
	<local.mail.linux-kernel/3BAF83EF.C8018E45@distributopia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <local.mail.linux-kernel/3BB03C6A.7D1DD7B3@kegel.com> you write:
>"Christopher K. St. John" wrote:
>>  Ok, just to confirm. Using the language of BSD's
>> kqueue[1]. you've got:
>> 
>>   a) report the event only once when it occurs aka
>> "edge triggered" (EV_CLEAR, not EV_ONESHOT)
>> 
>>  b) continuously report the event as long as the
>> state is valid, aka "level triggered"
>
>Right, and kqueue() can't even represent the 'level triggered' style --
>or at least it isn't clear from the paper that it can!  True "level triggered"
>would require that the kernel track readiness of the affected file descriptors.

Yes it does - kqueue() is 'level-triggered' by default.  You may want
to check my latest USENIX paper, which explains this, as well as some
performance measurements, at:

    http://www.flugsvamp.com/~jlemon/fbsd/kqueue_usenix2001.pdf

The kernel validates the state (or "level") before returning the event
to the user, so the event is guaranteed to be valid at the time the 
syscall returns.

As Christopher pointed out, any event can be converted into an
edge-triggered style notification simply by setting EV_CLEAR.  However,
this is not usually a popular model from a programmer's point of view,
as it increases the complexity of their app.  (This is what I've seen, YMMV)
-- 
Jonathan
