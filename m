Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262780AbVAQMUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbVAQMUa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 07:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbVAQMU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 07:20:29 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:65429
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262780AbVAQMUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 07:20:20 -0500
Subject: Re: 2.6.11-rc1-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Karim Yaghmour <karim@opersys.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andi Kleen <ak@muc.de>,
       Nikita Danilov <nikita@clusterfs.com>,
       LKML <linux-kernel@vger.kernel.org>, Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>
In-Reply-To: <41EB21C2.3020608@opersys.com>
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
	 <m17jmg2tm8.fsf@clusterfs.com> <20050114103836.GA71397@muc.de>
	 <41E7A7A6.3060502@opersys.com>
	 <Pine.LNX.4.61.0501141626310.6118@scrub.home>
	 <41E8358A.4030908@opersys.com>
	 <Pine.LNX.4.61.0501150101010.30794@scrub.home>
	 <41E899AC.3070705@opersys.com>
	 <Pine.LNX.4.61.0501160245180.30794@scrub.home>
	 <41EA0307.6020807@opersys.com>
	 <Pine.LNX.4.61.0501161648310.30794@scrub.home> <41EADA11.70403@opersys.com>
	 <1105925842.13265.364.camel@tglx.tec.linutronix.de>
	 <41EB21C2.3020608@opersys.com>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 13:20:17 +0100
Message-Id: <1105964417.13265.406.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-16 at 21:24 -0500, Karim Yaghmour wrote:

> > Sorting out disabled events in the hot path and moving the if
> > (pid/gid/grp) whatever stuff into userspace postprocessing is not an
> > alien request.
> 
> It is. Have you even read what I suggested to change in my other mail:
> if ((any_filtering) && !(ltt_filter(event_id, event_struct, data)))
> 	return -EINVAL;

Sorting out disabled events is the filtering you have to do in kernel
and you should do it in the hot path or remove the unneccecary
tracepoints at compiletime. 

> > 4096kB/sec for  64 events/ms (event frequency  64kHz) (15 us)
> > 8192kB/sec for 128 events/ms (event frequency 128kHz) ( 8 us) 

> Actually, on a PII-350MHz, I was already generating 0.5MB/s of data
> just by running an X session. If we assume that a machine 10 times
> faster generates 10 times as many events, we've already got 5MB/s,
> and I'm sure that there are heavier cases than X.

You are not answering my argument. 8MB/sec is an event frequency of
128hz when we assume 64byte/event. It's one event every 8us. So every
unneccecary computation, every leaving the hotpath for nothing is just
giving you performance loss.

> Not even Ingo hinted at getting rid of filtering. Remember the earlier
> e-mail I refered to? Here's what he was suggesting:

I said:
> > Sorting out disabled events in the hot path 

s/Sorting/Filtering/

I never said this should not be done.

> Like I said, we are willing to accomodate those who want to be able
> to use relayfs for kernel debugging purposes, but we can hardly
> be blamed for not making LTT a generic kernel debugging tool as this
> is exactly the excuse many kernel developers had for not including
> LTT to start with. It's just totally dissengenious for giving us
> grief for claiming that we are doing something and then later turn
> around and blame us for not doing it ... cheesh ...

Seperating layers as I suggested before is not making it a generic
debugging tool. It makes parts of those layers available for other usage
and gives us the chance to reuse the parts for cleaning up already
available code which has the same hardwired structure.

tglx



