Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265226AbSJWUjW>; Wed, 23 Oct 2002 16:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265227AbSJWUjW>; Wed, 23 Oct 2002 16:39:22 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:61932 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S265226AbSJWUjV>; Wed, 23 Oct 2002 16:39:21 -0400
Message-ID: <3DB70D4C.4070802@kegel.com>
Date: Wed, 23 Oct 2002 13:57:48 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: John Myers <jgmyers@netscape.com>
CC: linux-aio <linux-aio@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: async poll
References: <Pine.LNX.4.44.0210231102480.1581-100000@blue1.dev.mcafeelabs.com> <3DB7083E.5030206@netscape.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Myers wrote:
> Davide Libenzi wrote:
> 
>> Maybe my understanding of AIO on Linux is limited but how would you do
>> async accept/connect ? Will you be using std poll/select for that, and
>> then you'll switch to AIO for read/write requests ?
>>
> If a connection is likely to be idle, one would want to use an async 
> read poll instead of an async read in order to avoid having to allocate 
> input buffers to idle connections.  (What one really wants is a variant 
> of async read that allocates an input buffer to an fd at completion 
> time, not submission time).

In that situation, why not just add the fd to an epoll, and have the
epoll deliver events through Ben's interface?  That way you'd get
notified of changes in readability, and wouldn't have to issue
the read poll call over and over.

- Dan

