Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261429AbVCGB6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261429AbVCGB6o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 20:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVCGB6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 20:58:44 -0500
Received: from www.rapidforum.com ([80.237.244.2]:14572 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S261429AbVCGB6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 20:58:40 -0500
Message-ID: <422BB548.1020906@rapidforum.com>
Date: Mon, 07 Mar 2005 02:58:32 +0100
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com>
In-Reply-To: <422BAAC6.6040705@candelatech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> Christian Schmid wrote:
> 
>> Hello.
>>
>> After weeks of work, I can now give a detailed report about the bug 
>> and when it appears:
>>
>> Attached is another traffic-image. This one is with 2.6.10 and a 3/1 
>> split, preemtive kernel, so all defaults.
> 
> 
> What are the units on your graph.  You say "MB" several places, but
> do you mean Mb (ie, Mega-bit) instead?

The unit on this graph is kilobytes. So 80000 there means 80 megabytes per second.

> I have a tool that can also generate TCP traffic on a large number of
> sockets.  If I can understand what you are trying to do, I may be able
> to reproduce the problem.  My biggest machine at present has only
> 2GB of RAM, however...not sure if that matters or not.

It should not matter. Low-memory is both just 1 GB if you have default 32 bit with 3/1 split.

> Are you sending traffic in only one direction, or more of a full-duplex
> configuration?

Its a full-duplex. Its a download-service with 3000 downloaders all over the world.

>  Is each socket running the same bandwidth?

No. It ranges from 3 kb/sec to 100 kb/sec. 100 kb/sec is the limit because of the send-buffer limits.

> What is this bandwidth?

1000 MBit

> Are you setting the send & rcv buffers in the socket creation
> code?  (To what values if so?)

Yes. send-buffer to 64 kbytes and receive buffer to 16 kbytes.

> How many bytes are you sending with each call to write()/sendto() whatever?

I am using sendfile-call every 100 ms per socket with the poll-api. So basically around 40 kb per round.

> Is there any significant latency between your sender and receiver machine?
> If so, how much?

3000 different downloaders, 3000 different locations, 3000 different machines ;)

> What is the physical transport...GigE?  1500 MTU?

Yes.

Chris

