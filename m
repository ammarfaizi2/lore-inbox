Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264498AbTFHECV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 00:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbTFHECV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 00:02:21 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:13817 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264498AbTFHECU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 00:02:20 -0400
Message-ID: <3EE2B878.6050809@nortelnetworks.com>
Date: Sun, 08 Jun 2003 00:15:52 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Schwartz <davids@webmaster.com>
Cc: MarKol <markol4@wp.pl>, linux-kernel@vger.kernel.org
Subject: Re: select for UNIX sockets?
References: <MDEHLPKNGKAHNMBLJOLKMEOBDHAA.davids@webmaster.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:

> 	You are doing something wrong. You are using 'select' along with blocking
> I/O operations. You can't make bricks without clay. If you don't want to
> block, you must use non-blocking socket operations. End of story.

That's funny, I was under the impression that the whole point of using select() 
was to enable the use of blocking I/O.  If you are on a uniprocessor system, in 
a single thread, and select() says that a socket is writeable, then I had darn 
well better be able to write to that socket!

Sure, this gets more complicated when multiprocessing or multithreading, but the 
test program does neither of these.

> 	Just because 'select' indicates a write hit, you are not assured that some
> particular write at a later time will not block. Past performance does not
> guarantee future results.


Think about the whole reason for select()'s existance. If a single-threaded app 
calls select() and is told a socket is writeable, then a write to that socket 
should either immediately succeed or immediately fail (if the other socket 
disappeared in between the calls, for instance).

Now granted I use non-blocking I/O out of paranoia, but even there if select() 
says it is writeable and the send call returns EAGAIN then we get into a nice 
little infinite loop.

select() should be reliable.


Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

