Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUEJXET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUEJXET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUEJXDN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:03:13 -0400
Received: from finch.doc.ic.ac.uk ([146.169.1.194]:27048 "EHLO
	finch.doc.ic.ac.uk") by vger.kernel.org with ESMTP id S263003AbUEJXBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:01:46 -0400
Message-ID: <40A009D9.9090404@bluetheta.com>
Date: Tue, 11 May 2004 00:01:45 +0100
From: Andre Ben Hamou <andre@bluetheta.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Multithread select() bug
References: <409FF38C.7080902@bluetheta.com> <409FFADD.7050204@cosmosbay.com> <409FFE22.4050508@bluetheta.com> <40A002CE.4020906@cosmosbay.com>
In-Reply-To: <40A002CE.4020906@cosmosbay.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> So please how do you guarantee that thread 1 runs *before* thread 2)
> 
> Thread 1)
>        select( fd)
> 
> Thread 2)
>        close(fd)
> 
> Thats not possible.
> 

I see where you're coming from, in that there is a potential race 
condition as to the socket being connected as I reach the select call.

This is an important concern but it is, I think, orthogonal to the 
original problem as there are two possible socket states at the point at 
which select gets called (as far as I can see)...

1. The socket is in its connected state
2. The socket has already been closed by the parent thread

As I understand it, if 1 is true (which corresponds to my original 
post), then select should return the moment the socket gets closed and, 
if 2 is true (which I believe corresponds to your concern), then select 
should return immediately anyway as the socket would not block if read from.

Sorry to be a pest, but I'm trying to get this clear in my head. Is it 
possible I've over-estimated the thread-safety of the select and close 
calls?

Cheers,

Andre Ben Hamou
Imperial College London

-- 

...and, on the seventh day, God switched off his Mac.
