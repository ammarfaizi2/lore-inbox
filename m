Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314913AbSD2Iov>; Mon, 29 Apr 2002 04:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314911AbSD2Iou>; Mon, 29 Apr 2002 04:44:50 -0400
Received: from mail.webmaster.com ([216.152.64.131]:55689 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S314908AbSD2Iot> convert rfc822-to-8bit; Mon, 29 Apr 2002 04:44:49 -0400
From: David Schwartz <davids@webmaster.com>
To: <terje.eggestad@scali.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Mon, 29 Apr 2002 01:44:47 -0700
In-Reply-To: <1020067604.22026.3.camel@pc-16.office.scali.no>
Subject: Re: Possible bug with UDP and SO_REUSEADDR.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020429084448.AAA25009@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>    1) The two instances are cooperating closely together and should be
>>sharing
>>a socket (not each opening one), or
>>
>>    2) The two instances are not cooperating closely together and each own
>>their
>>own socket. For all the kernel knows, they don't even know about each
>>other.
>>
>>    In the first case, it's logical for whichever one happens to try to 
read
>>first to get the/a datagram. In the second case, it's logical for the
>>kernel
>>to pick one and give it all the data.
>>
>>    DS

>IMHO, in the second case it's logical for the kernel NOT to allow the
>second to bind to the port at all. Which it actually does, it's the
>normal case. When you set the SO_REUSEADDR flag on the socket you're
>telling the kernel that we're in case 1).
>
>TJ  

	NO. When you set the SO_REUSEADDR, you are telling the kernel that you 
intend to share your port with *someone*, but not who. The kernel has no way 
to know that two processes that bind to the same UDP port with SO_REUSEADDR 
are the two that were intended to cooperate with each other. For all it 
knows, one is a foo intended to cooperate with other foo's and the other is a 
bar intended to cooperate with other bar's.

	That's why if you mean to share, you should share the actual socket 
descriptor rather than trying to reference the same transport endpoint with 
two different sockets.

	Of course, in this case you don't even need SO_REUSEADDR/SO_REUSEPORT since 
you only actually open the endpoint once.

	DS


