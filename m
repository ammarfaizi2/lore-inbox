Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLEQa3>; Tue, 5 Dec 2000 11:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129324AbQLEQaK>; Tue, 5 Dec 2000 11:30:10 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:19977 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129183AbQLEQaB>; Tue, 5 Dec 2000 11:30:01 -0500
Date: Tue, 5 Dec 2000 11:00:02 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: Rusty Russell <rusty@linuxcare.com.au>
cc: "Christian W. Zuckschwerdt" <zany@triq.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipchains log will show all flags 
In-Reply-To: <20001205135519.9747C813F@halfway.linuxcare.com.au>
Message-ID: <Pine.LNX.4.30.0012051058090.620-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2000, Rusty Russell wrote:

>Date: Wed, 06 Dec 2000 00:55:09 +1100
>From: Rusty Russell <rusty@linuxcare.com.au>
>To: Christian W. Zuckschwerdt <zany@triq.net>
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] ipchains log will show all flags
>
>In message <0012051408110.1526-100000@localhost> you write:
>> Hi Linus,
>>
>> This tiny patch extends ipchains logging. This way one can distinguish
>> (plain) connection attempts and (Xmas, Fin,...) scans. E.g.
>>  kernel: Packet log: input - lo PROTO=6 127.0.0.1:40326 127.0.0.1:80
>>   L=40 S=0x00 I=5808 F=0x0000 T=51 (#1)
>>  vs.
>>   L=40 S=0x00 I=5808 F=0x0000 T=51 (#1) B=-s--a-
>>  and
>>   L=40 S=0x00 I=5808 F=0x0000 T=51 (#1) B=fs-p-u
>>
>> Please comment on the format (B=...) and implementation details (speed).
>> The patch is against 2.2.17's /net/ipv4/ip_fw.c
>
>Looks OK, but CC'ing the maintainer is simple politeness.
>
>> +	if (ip->protocol == IPPROTO_TCP)
>
>You probably want to insert `&& !(ip->frag_off & htons(IP_OFFSET))'
>
>> +		       tcp-syn ? 's' : '-', tcp->rst ? 'r' : '-',
>
>You mean `tcp->syn' not `tcp-syn'.
>
>I like the fact that it doesn't disturb the format, simply appends,
>and it has been a not-uncommon request.
>
>But application is up to Alan Cox, who ruleth the 2.2 series.

Personally, I'd like to see the rule number stay on the end,and
have the new display just before it.  The rule number in the
middle looks messy.


----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

Microsoft Windows(tm). A thirty-two bit extension and graphical shell
to a sixteen bit patch to an eight bit operating system originally
coded for a four bit microprocessor which was written by a two-bit
company that can't stand one bit of competition.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
