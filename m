Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262312AbSLMLpq>; Fri, 13 Dec 2002 06:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262067AbSLMLpq>; Fri, 13 Dec 2002 06:45:46 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:48597 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S262266AbSLMLpo>; Fri, 13 Dec 2002 06:45:44 -0500
Date: Sat, 14 Dec 2002 00:40:43 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: Nivedita Singhvi <niv@us.ibm.com>, Matti Aarnio <matti.aarnio@zmailer.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andreani Stefano <stefano.andreani.ap@h3g.it>,
       "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: R: Kernel bug handling TCP_RTO_MAX?
Message-ID: <13810000.1039779643@localhost.localdomain>
In-Reply-To: <3DF965E4.95DEA1F9@us.ibm.com>
References: <047ACC5B9A00D741927A4A32E7D01B73D66178@RMEXC01.h3g.it>
 <1039727809.22174.38.camel@irongate.swansea.linux.org.uk>
 <3DF94565.2C582DE2@us.ibm.com> <20021213033928.GK32122@mea-ext.zmailer.org>
 <3DF965E4.95DEA1F9@us.ibm.com>
X-Mailer: Mulberry/3.0.0b9 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Er, wasn't that SCTP?  If so, that's RFC 3309 and many, many drafts.  You 
might also want to look at DCCP (draft-ietf-dccp-*) and the various 
documents from the IETF's PILC group.  There is also a proposal for a new 
TCP-style protocol with a real differential controller, the name of which I 
can't recall right now.

See also draft-allman-tcp-sack for another proposal for a fix that won't 
break old stacks.  Also draft-ietf-tsvwg-tcp-eifel-alg, 
draft-ietf-tsvwg-tcp-eifel-response and many more.

I can't claim to be a TCP expert, but TCP_RTO_MIN can certainly have a 
different value for IPv6, where I believe millisecond reolution timers are 
required, so 2ms would be correct.

Unfortuntately, TCP is incredibly subtle.  So, the IETF are really 
conservative about even suggesting modifications to it, because a common 
and badly behaved stack can cause major disasters in the 'net.

Andrew

--On Thursday, December 12, 2002 20:45:24 -0800 Nivedita Singhvi 
<niv@us.ibm.com> wrote:

>>   You are looking for "STP" perhaps ?
>>   It has a feature of waking all streams retransmits, in between
>>   particular machines, when at least one STP frame travels in between
>>   the hosts.
>>
>>   I can't find it now from my RFC collection.  Odd at that..
>>   Neither as a draft.  has it been abandoned ?
>
> Learn something new every day :). Thanks for the ptr. I'll
> look it up..
>
>> > It would be wonderful if we could tune TCP on a per-interface or a
>> > per-route basis (everything public, for a start, considered the
>> > internet, and non-routable networks (10, etc), could be configured
>> > suitably for its environment. (TCP over private LAN - rfc?). Trusting
>> > users would be a big issue..
>> >
>> > Any thoughts? How stupid is this? Old hat??
>>
>>   More and more of STP ..
>
> thanks,
> Nivedita


