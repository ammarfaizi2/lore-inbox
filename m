Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263221AbVGOGnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbVGOGnh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 02:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbVGOGnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 02:43:37 -0400
Received: from BTNL-TN-DSL-static-006.0.144.59.touchtelindia.net ([59.144.0.6]:40065
	"EHLO mail.prodmail.net") by vger.kernel.org with ESMTP
	id S263221AbVGOGng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 02:43:36 -0400
Message-ID: <42D75A93.5010904@prodmail.net>
Date: Fri, 15 Jul 2005 12:11:23 +0530
From: RVK <rvk@prodmail.net>
Reply-To: rvk@prodmail.net
Organization: GSEC1
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: omb@bluewin.ch
CC: linux-kernel@vger.kernel.org
Subject: Re: Buffer Over-runs, was Open source firewalls
References: <20050713163424.35416.qmail@web32110.mail.mud.yahoo.com>    <42D63AD0.6060609@aitel.hist.no> <42D63D4A.2050607@prodmail.net>    <42D658A8.4040009@aitel.hist.no> <42D658A9.7050706@prodmail.net> <42D6ECED.7070504@khandalf.com>
In-Reply-To: <42D6ECED.7070504@khandalf.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian O'Mahoney wrote:

>First there are endless ways of stopping DAMAGE from buffer
>over-runs, from code that accepts user data, eg extend buffer, dont
>use dangerous strxxx functions .... so while you can move
>stuff to proxies, and that has been done extensively e.g.
>for sendmail it is a cop-out, far better fix the application;
>
>Next, while all buffer over runs are very bad it is only those
>that stamp on the stack, overwriting the return address stored
>there and implanting viral code to be executed, that are truely
>__EVIL__.
>
>To do that you need to know a lot of things, the architecture
>ie executing x86 code on a ppc will get you no-where, you must
>know, and be able to debug your mal-ware against a stable
>target, and this is why the _VERY_ slowly patched Windoze is
>so vulnerable, and finally you really need to know the stack
>base, top of stack, normally growing downward, and ... be able
>to actually run code out of the stack space;
>
>and if any one of these conditions are not true, eg I compiled
>sendmail with a newer GCC, stack is not executable, ...
>
>the exploit just fails or crashes an app and then you go after
>why?
>
>  
>
Even in the presence of non-executable stack, Linux Torvalds explains 
that "It's really easy. You do something like this: 1) overflow the 
buffer on the stack, so that the return value is overwritten by a 
pointer to the system() library function. 2) the next four bytes are 
crap (a "return pointer" for the system call, which you don't care 
about) 3) the next four bytes are a pointer to some random place in the 
shared library again that contains the string "/bin/sh" (and yes, just 
do a strings on the thing and you'll find it). Voila. You didn't have to 
write any code, the only thing you needed to know was where the library 
is loaded by default. And yes, it's library-specific, but hey, you just 
select one specific commonly used version to crash. Suddenly you have a 
root shell on the system. So it's not only doable, it's fairly trivial 
to do. In short, anybody who thinks that the non-executable stack gives 
them any real security is very very much living in a dream world. It may 
catch a few attacks for old binaries that have security problems, but 
the basic problem is that the binaries allow you to overwrite their 
stacks. And if they allow that, then they allow the above exploit. It 
probably takes all of five lines of changes to some existing exploit, 
and some random program to find out where in the address space the 
shared libraries tend to be loaded."


rvk

>but your system is not compromised.
>
>One final point, in practice, you get lots of unwanted packets
>off the internet, and in general you do not want them on your
>internal net, both for performance and security reasons, if you
>drop them on your router or firewall then you dont need to
>worry if the remote app is mal-ware.
>
>--
>mit freundlichen Grüßen, Brian.
>
>.
>
>  
>

