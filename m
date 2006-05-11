Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbWEKBpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbWEKBpR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 21:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965114AbWEKBpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 21:45:17 -0400
Received: from inglit.ubishops.ca ([206.167.194.132]:31951 "EHLO
	cs.ubishops.ca") by vger.kernel.org with ESMTP id S965111AbWEKBpQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 21:45:16 -0400
Message-ID: <4462978C.6080809@cs.mcgill.ca>
Date: Wed, 10 May 2006 21:46:52 -0400
From: Patrick McLean <chutz@cs.mcgill.ca>
User-Agent: Thunderbird 1.5.0.2 (X11/20060430)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Bogecho <andrewb@cs.mcgill.ca>
Subject: Re: NFS locking
References: <446246D6.5010509@cs.mcgill.ca> <17506.33247.884320.387785@cse.unsw.edu.au>
In-Reply-To: <17506.33247.884320.387785@cse.unsw.edu.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> On Wednesday May 10, chutz@cs.mcgill.ca wrote:
>> We have a NFS server here with a fairly high load. The clients are
>> Linux, FreeBSD and Solaris. The exported filesystem is XFS, which is onb
>> a LVM drive. After between 3 and 30 days it seems that locking
>> completely stops working, clients generally either error or simply lock
>> up when they try to lock a file. The only way to fix it seems to be a
>> reboot.
> 
> Reboot the client or the server?
> 

The server, rebooting the clients had no effect.

>> Last time it happened was on 2.6.17-rc2, it started around 2.6.15.
>>
>> There is nothing in the dmesg on the server, the (Linux) clients are
>> printing this in the dmesg when something tries to create a lock:
>>
>> lockd: server xxx.xxx.xxx.xxx not responding, still trying
>> lockd: server xxx.xxx.xxx.xxx not responding, still trying
> 
> Sounds like the server has locked up.
> What does 'ps' on the server show for 'lockd'?  Is it in 'D'?  What is
> the 'wchan'?  Are any 'nfsd's permanently in 'D'?
> 
> Try
>  echo t > /proc/sysrq-trigger
> 
> and see what the stack trace for lockd is - probably only useful if it
> is in 'D'.
> 
> Maybe a 'tcpdump -s 1500' of traffic between client and server would
> help.

We have already rebooted the server this time around, we will do the stack trace
and tcpdump from a client next time it happens.

Though, I do seem to remember that lockd was in the "D" state on the server when
it happened this afternoon. Restarting the nfs service on the server did spawn a
new lockd process, but did not fix the problem.
