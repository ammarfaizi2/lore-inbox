Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752809AbWKVLjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbWKVLjA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 06:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752894AbWKVLjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 06:39:00 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:23120 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S1752790AbWKVLi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 06:38:59 -0500
Message-ID: <456436CA.7050809@tls.msk.ru>
Date: Wed, 22 Nov 2006 14:38:50 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Thunderbird 1.5.0.5 (X11/20060813)
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: Jeff Garzik <jeff@garzik.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       David Miller <davem@davemloft.net>, Andrew Morton <akpm@osdl.org>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Alexander Viro <aviro@redhat.com>
Subject: Re: [take24 0/6] kevent: Generic event handling mechanism.
References: <11630606361046@2ka.mipt.ru> <45564EA5.6020607@redhat.com> <20061113105458.GA8182@2ka.mipt.ru> <4560F07B.10608@redhat.com> <20061120082500.GA25467@2ka.mipt.ru> <4562102B.5010503@redhat.com> <45622228.80803@garzik.org> <456223AC.5080400@redhat.com>
In-Reply-To: <456223AC.5080400@redhat.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Jeff Garzik wrote:
>> I think we have lived with relative timeouts for so long, it would be
>> unusual to change now.  select(2), poll(2), epoll_wait(2) all take
>> relative timeouts.
> 
> I'm not talking about always using absolute timeouts.
> 
> I'm saying the timeout parameter should be a struct timespec* and then
> the flags word could have a flag meaning "this is an absolute timeout".
>  I.e., enable both uses,, even make relative timeouts the default. This
> is what the modern POSIX interfaces do, too, see clock_nanosleep.


Can't the argument be something like u64 instead of struct timespec,
regardless of this discussion (relative vs absolute)?

Compare:

 void mysleep(int msec) {
   struct timeval tv;
   tv.tv_sec = msec/1000;
   tv.tv_usec = msec%1000;
   select(0,0,0,0,&tv);
 }

with

  void mysleep(int msec) {
    poll(0, 0, msec*SOME_TIME_SCALE_VALUE);
  }

That to say: struct time{spec,val,whatever} is more difficult to use than
plain numbers.

But yes... existing struct timespec has an advantage of being already existed.
Oh well.

/mjt
