Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbSJYKKZ>; Fri, 25 Oct 2002 06:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261363AbSJYKKZ>; Fri, 25 Oct 2002 06:10:25 -0400
Received: from cygnus-ext.enyo.de ([212.9.189.162]:36869 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id <S261354AbSJYKKY>;
	Fri, 25 Oct 2002 06:10:24 -0400
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com
Subject: Re: [SECURITY] CERT/CC VU#464113, SYN plus RST/FIN
References: <87vg3qq4ec.fsf@deneb.enyo.de>
	<20021025101311.GD3512@riesen-pc.gr05.synopsys.com>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, davem@redhat.com
Date: Fri, 25 Oct 2002 12:16:37 +0200
In-Reply-To: <20021025101311.GD3512@riesen-pc.gr05.synopsys.com> (Alex
 Riesen's message of "Fri, 25 Oct 2002 12:13:11 +0200")
Message-ID: <87smyuq0vu.fsf@deneb.enyo.de>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen <Alexander.Riesen@synopsys.com> writes:

>> --- tcp_input.c	2002/10/25 08:45:20	1.1
>> +++ tcp_input.c	2002/10/25 08:49:21
>> @@ -3668,6 +3668,8 @@
>>  	case TCP_LISTEN:
>>  		if(th->ack)
>>  			return 1;
>> +		if(th->rst || th->fin)
>> +			goto discard;
>>  
>>  		if(th->syn) {
>>  			if(tp->af_specific->conn_request(sk, skb) < 0)
>> 
>
> You mean to place the check below "if(th->syn)", don't you?

No, of course not. :-) That's the whole point of the patch.
A SYN is not a SYN if it comes together with a RST.
