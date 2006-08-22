Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWHVXMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWHVXMc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 19:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWHVXMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 19:12:32 -0400
Received: from minus.inr.ac.ru ([194.67.69.97]:8860 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id S932079AbWHVXMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 19:12:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ms2.inr.ac.ru;
  b=UpyAzuMMXozH7BVOf+xKJ1STqJZ39K6CevFZhEWzAIhs5rpANmn9/RNX0MlZdaOTltUQFd19dK1PtC9TYNwDLecRzTT3TjhNhXEulw9NF7kj17QYhMcQqCu21fjT1xgTUrwQ7dA4OrhjB687qKNstdkyZZ7lKIB2AwxYSeAdYRg=;
Date: Wed, 23 Aug 2006 03:11:29 +0400
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
To: Jari Sundell <sundell.software@gmail.com>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Nicholas Miell <nmiell@comcast.net>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [take12 0/3] kevent: Generic event handling mechanism.
Message-ID: <20060822231129.GA18296@ms2.inr.ac.ru>
References: <11561555871530@2ka.mipt.ru> <1156230051.8055.27.camel@entropy> <20060822072448.GA5126@2ka.mipt.ru> <1156234672.8055.51.camel@entropy> <b3f268590608220957g43a16d6bmde8a542f8ad8710b@mail.gmail.com> <20060822180135.GA30142@2ka.mipt.ru> <b3f268590608221214l45bb6ad6meccfba99b89710a0@mail.gmail.com> <20060822194706.GA3476@2ka.mipt.ru> <b3f268590608221551q5e6a1057hd1474ee8b9811f10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3f268590608221551q5e6a1057hd1474ee8b9811f10@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> >No way - timespec uses long.
> 
> I must have missed that discussion. Please enlighten me in what regard
> using an opaque type with lower resolution is preferable to a type
> defined in POSIX for this sort of purpose.

Let me explain, as a person who did this mistake and deeply
regrets about this.

F.e. in this case you just cannot use kevents in 32bit application
on x86_64, unless you add the whole translation layer inside kevent core.
Even when you deal with plain syscall, translation is a big pain,
but when you use mmapped buffer, it can be simply impossible.

F.e. my mistake was "unsigned long" in struct tpacket_hdr in linux/if_packet.h.
It makes use of mmapped packet socket essentially impossible by 32bit
applications on 64bit archs.

Alexey
