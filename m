Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWBBWjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWBBWjH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWBBWjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:39:07 -0500
Received: from smtp-relay.tamu.edu ([165.91.22.120]:35521 "EHLO
	smtp-relay.tamu.edu") by vger.kernel.org with ESMTP id S932377AbWBBWjF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:39:05 -0500
Message-ID: <43E28A07.1040604@tamu.edu>
Date: Thu, 02 Feb 2006 16:39:03 -0600
From: Benjamin Chu <benchu@tamu.edu>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Measure the Accept Queueing Time
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! I am doing my research for the web server performance modeling.
After the connection request from a client complete the TCP 3-way 
handshake. It would become an open request and this open request will be 
placed in the accept queue. At this point the new child socket is 
created and pointed to by the open request. The connection is considered 
to be established at this point.
Each time the Web server process executes the "accept()" system call, 
the first open request in the accept queue is removed and the socket 
which is pointed to by this open request is returned.
All I want is to measure the amount of time when a open request is in 
the accept queue. I've tracked the source code of the Linux kernel. I 
may know the flow but still not sure my direction is correct or not. I 
write down what I found as follows. If there is anything wrong, please 
tell me! Thank you very mush

1. The struct "sock" in "sock.h" has a parameter call "ack_backlog". 
This parameter counts how many open request in the accept queue.

2. The struct "tcp_opt" in "sock.h" has two parameters call 
"accept_queque" and "accept_queue_tail".These two parameter actually 
point to the exact accept queue.

3. The struct "open_request" in "tcp.h" exactly represents the open 
request which I've mention above.

4. After a connection request from a client complete the TCP 3-way 
handshake, the listen socket would call the function "tcp_acceptq_queue" 
in "tcp.h". This function puts new open request (i.e. the struct 
"open_request") into accept queue (i.e. struct "accept_queue" in 
"tcp_opt").

5. Each time the Web server process executes the accept() system call,
the function "tcp_accept" in "tcp.c" would be called. This function 
removes the first open request in the accept queue and return the socket 
which is pointed to by the open request.


Is there anything wrong with what I describe above? Or there is any 
reference regarding this matter? Please tell me! Thank you very much!

p.s. My Linux Kernel Version is 2.4.25
