Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262405AbSI2GzA>; Sun, 29 Sep 2002 02:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262406AbSI2Gy7>; Sun, 29 Sep 2002 02:54:59 -0400
Received: from web14602.mail.yahoo.com ([216.136.224.82]:57352 "HELO
	web14602.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262405AbSI2Gy6>; Sun, 29 Sep 2002 02:54:58 -0400
Message-ID: <20020929070021.7735.qmail@web14602.mail.yahoo.com>
Date: Sun, 29 Sep 2002 00:00:21 -0700 (PDT)
From: Arvind Gopalan <arvind_gopalan@yahoo.com>
Subject: Re: 4 byte mem alignment
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020928.232326.43409659.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Dave, for confirming my doubt. I have some user
level code that uses raw sockets on
linux. The code ran on several dual PIII x86 machines
without any issues. But since the time we started
running (the same code with no changes) on the dual
x86 xeons, i have seen some wierd corruption issues
with the packets. This kernel already has the patch
for the xeon TLB flush bug. On some of the eth packets
that I dumped, i found that 8 bytes of data being
"copied and inserted"!. As in after a certain offset
into the packet, there would be a sequence of 8 bytes
that would be an exact copy of the 8 bytes that
appeared just before. All other following bytes were
literally shifted down by 8. How can i proceed to
debug this sort of a problem. if its a xeon specific
issue, how can i isolate it?. 

Thanks
-Arvind 

--- "David S. Miller" <davem@redhat.com> wrote:
>    From: Arvind Gopalan <arvind_gopalan@yahoo.com>
>    Date: Sat, 28 Sep 2002 23:26:46 -0700 (PDT)
> 
>    how strong the requirements are for
> copy_to_user().
>    does it fault to byte-by-byte mode gracefully
> when
>    given a non-4byte aligned buffer?.
> 
> The x86 processor handles unaligned memory accesses
> in hw.
> 
> On any platform, copy_to_user() must handle any user
> and kernel buffer
> alignment.


__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
