Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTEJSap (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 14:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbTEJSap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 14:30:45 -0400
Received: from almesberger.net ([63.105.73.239]:54027 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262458AbTEJSao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 14:30:44 -0400
Date: Sat, 10 May 2003 15:43:11 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Ahmed Masud <masud@googgun.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jesse Pollard <jesse@cats-chateau.net>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Terje Eggestad <terje.eggestad@scali.com>
Subject: Re: The disappearing sys_call_table export.
Message-ID: <20030510154311.F13069@almesberger.net>
References: <1052585430.1367.6.camel@laptop.fenrus.com> <Pine.LNX.4.33.0305101321040.24661-100000@marauder.googgun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0305101321040.24661-100000@marauder.googgun.com>; from masud@googgun.com on Sat, May 10, 2003 at 01:51:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ahmed Masud wrote:
> 		yield(random(threshold)); /* yeild is a sleep */
[...]
> That becomes a bit more difficult to time, because the attacker doesn't
> know when the system call will actually perform its own copy_from_user vs.

So the probability of getting through in one try is about (tR+tH)/tH,
where tR is the average random delay, and tH is the time between the
check and the actual access.

If you keep on trying until you get through, you'll succeed on average
after tR^2/tH+tR.

If you make tR = 1 s (that's pretty long, e.g. if you do this to
unlink(2), a rm -rf of the kernel source tree would take about four
hours) and assume that tH is only one microsecond, the race condition
can still be exploited within typically less than one fortnight.

Since the system would be idle most of the time, such a brute-force
attack could easily go unnoticed, even if somebody cares to monitor
the system often enough.

Sounds like voodoo security to me.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
