Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265214AbSJWWGV>; Wed, 23 Oct 2002 18:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265216AbSJWWGV>; Wed, 23 Oct 2002 18:06:21 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:50569 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S265214AbSJWWGU>; Wed, 23 Oct 2002 18:06:20 -0400
Message-ID: <3DB721B1.7090907@kegel.com>
Date: Wed, 23 Oct 2002 15:24:49 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: John Gardiner Myers <jgmyers@netscape.com>
CC: linux-aio <linux-aio@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: async poll
References: <Pine.LNX.4.44.0210231102480.1581-100000@blue1.dev.mcafeelabs.com> <3DB7083E.5030206@netscape.com> <3DB70D4C.4070802@kegel.com> <3DB7136E.8090205@netscape.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Gardiner Myers wrote:
> 
> Dan Kegel wrote:
> 
>> In that situation, why not just add the fd to an epoll, and have the
>> epoll deliver events through Ben's interface?
> 
> 
> Because you might need to use the aio_data facility of the iocb 
> interface.

Presumably epoll_add could be enhanced to let user specify a user data
word.

 > Because you might want to keep the kernel from
> simultaneously delivering two events for the same fd to two different 
> threads.

You might want to use aio_write() for writes, and read() for reads,
in which case you could tell epoll you're not interested in
write readiness events.  Then there'd be no double notification
for reads or writes on same fd.
It's a bit contrived, but I can imagine it being useful.

- Dan



