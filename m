Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279893AbRKINSY>; Fri, 9 Nov 2001 08:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279902AbRKINSO>; Fri, 9 Nov 2001 08:18:14 -0500
Received: from ns.suse.de ([213.95.15.193]:1804 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279901AbRKINSB>;
	Fri, 9 Nov 2001 08:18:01 -0500
Date: Fri, 9 Nov 2001 14:17:55 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, ak@suse.de, anton@samba.org, mingo@elte.hu,
        linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
Message-ID: <20011109141755.A30575@wotan.suse.de>
In-Reply-To: <20011108.231632.18311891.davem@redhat.com> <E162BFV-0002y1-00@the-village.bc.nu> <20011109.045455.74749430.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20011109.045455.74749430.davem@redhat.com>; from davem@redhat.com on Fri, Nov 09, 2001 at 04:54:55AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 04:54:55AM -0800, David S. Miller wrote:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: Fri, 9 Nov 2001 12:59:09 +0000 (GMT)
> 
>    we need a CONFIG option for it
> 
> I think a boot time commandline option is more appropriate
> for something like this.

Fine if you don't mind an indirect function call pointer somewhere in the TCP
hash path.

I'm thinking about adding one that removes the separate time wait 
table. It is not needed for desktops because they should have little
or no time-wait sockets. also it should throttle the hash table
sizing aggressively; e.g. 256-512 buckets should be more than enough
for a client. 

BTW I noticed that 1/4 of the big hash table is not used on SMP. The
time wait buckets share the locks of the lower half, so the spinlocks
in the upper half are never used. What would you think about splitting
the table and not putting spinlocks in the time-wait range?


-Andi
