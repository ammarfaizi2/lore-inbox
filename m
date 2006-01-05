Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751884AbWAESrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbWAESrv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWAESrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:47:51 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:16708 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751884AbWAESru convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:47:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZSSmbXqDErY+InP6DS5Nb672JU9rn6pZALLA1/Xrl+CG8/spHYxvVSKxDGy6S/g9owtg2BbfvCogmy0L9F0QXQx9heXq8U+deYcwoUuyhB3HGT5SHnf7TtI56/F0vARv8lUH0/qg0Sx2HqUcsqX3edKzX/3SgbrghfCRnTzrAqg=
Message-ID: <3b0ffc1f0601051047i24fd1b9mb772cb64dccf6fcb@mail.gmail.com>
Date: Thu, 5 Jan 2006 13:47:48 -0500
From: Kevin Radloff <radsaq@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [ck] Re: 2.6.15-ck1
Cc: Dave Jones <davej@redhat.com>, ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <200601051010.54156.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601041200.03593.kernel@kolivas.org>
	 <20060104190554.GG10592@redhat.com>
	 <20060104195726.GB14782@redhat.com>
	 <200601051010.54156.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/06, Con Kolivas <kernel@kolivas.org> wrote:
> Thanks for testing it. Indeed skipping the ticks alone does not really save
> any significant amount of power. The real chance for power savings comes from
> using this period for smarter C state programming. The other thing as you've
> noticed is that timers need to be curbed or minimised to get the maximum
> benefit and the ondemand governor alone, which unfortunately shows up as
> something not obvious in timertop, polls at 140HZ itself - fiddling with
> ondemand/ settings in sys can drop this but slows the rate at which it
> adapts.

For what it's worth (and I haven't done any actual power usage tests),
on my 1.1GHz Pentium M laptop the gkrellm CPU speed meter
(gkrellm-x86info) shows the CPU going down to around 30MHz thanks to
the recent C-state patches (speeds under the minimum of 600MHz reflect
C3 usage). On the other hand, without dynticks the speed hangs out
around 60MHz, which as far as I know reflects the maximum possible C3
usage with HZ = 1000. So really I'm guessing that the difference in
power consumption isn't really improved much, given that on my Pentium
M idle time is spent in C2, and if C3 is possible it's used quite
extensively regardless.

Of course, this may point to who the people who could really benefit
from dynticks are--those with long latencies for higher C states. But
in that sense, dynticks would seem to be of use more for legacy
systems, since everyone is moving towards CPUs with better
power-saving capabilities, no? I'm not knowledgeable about the
specifics.. just thinking out loud, really. ;)

Perhaps fixing the biggest offenders of timer (mis?)use would benefit
everyone all-around. I haven't really been able to identify who those
are though, given the lack of sorting in timertop and its
seemingly-haphazard ordering of data (or is it there and I've missed
it?).

--
Kevin 'radsaq' Radloff
radsaq@gmail.com
http://thesaq.com/
