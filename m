Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTJANZO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 09:25:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbTJANZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 09:25:14 -0400
Received: from imr2.ericy.com ([198.24.6.3]:44686 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id S262038AbTJANZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 09:25:05 -0400
Message-ID: <3F7AD795.1040001@ericsson.ca>
Date: Wed, 01 Oct 2003 09:33:09 -0400
From: Makan Pourzandi <Makan.Pourzandi@ericsson.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel@vger.kernel.org,
       Axelle Apvrille <Axelle.Apvrille@ericsson.ca>,
       Vincent Roy <vincent.roy@ericsson.ca>,
       David Gordon <davidgordonca@yahoo.ca>, socrate@infoiasi.ro
Subject: Re: [ANNOUNCE] DigSig 0.2: kernel module for digital signature verification
 for binaries
References: <3F733FD3.60502@ericsson.ca> <20031001102631.GC398@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>Hi!
>
>  
>
>>overview
>>=======
>>
>>Instead of writing a long detailed explication, I rather give you an 
>>example of how you can use it.
>>    
>>
>
>Can you also add example *why* one would want to use it?
>  
>
>AFAICS if I want to exec something, I can avoid exec() syscall and do
>mmaps by hand...
>

Hi,

Thank you for your feedback. This is my understanding of the situation, 
if I'm wrong in my analysis, let me know.

There are different answers to this question because there are many 
possible attack scenarios. I try to take the most realistic one and give 
a short answer.  

For the attacke described by you to be successful, one assumes that the 
intruder  gained access to the system,  he wrote his own code on the 
system (or brought it in),  and compile  it on the system (cannot 
execute its own code as it is not signed), produced the binary to mmap 
the malicious code to the memory, and run the code that call syscall 
mmap.   

First digsig can help to avoid the access to the system by the intruder. 
as it aborts the execution of malicious code which often leads to a root 
access for the intruder.

Second, digsig can avoid the execution of the binary that allows to 
bring in the code or other malicious binaries. AFAIK, the intruders 
generally use their own binary to download malicious code. This is 
because in hardened systems, the use of ftp ot other alike binaries, 
(when these binaries are not completely removed from the system for 
security reasons) is closely monitored and controled through firewalling 
rules. Even in simple desktops, it is rather easy to control the use of 
ftp and alike to track down the intrusion source.  therefore, the 
intruder needs to run  his own binary to download the root kit which is 
avoided by the use of digsig.

Third, the intruder now has access to the system, he cannot execute the 
code he brought in with himself (not signed) or he cannot bring it in 
(c.f. above). So he needs to compile the code on the system. AFAIK, for 
the absolute majority of servers the admins remove all compilers 
(specially gcc) on all servers. this is for several different security 
reasons  (I don't want to get there). therefore, the above hypothesis 
gets even more difficult to realize. 

Last, but I believe the most important, the level of difficulty of 
execution of such an attack is much higher than the average knowledge 
level of many script kiddies. The absolute majority of attackers have 
little or absolutely not any knowledge of the operating systems in 
general and linux in particular, let aside the knowledge of writing a C 
program, calling mmaps in that progam and run the malicious code to gain 
access as root, then remove the module to execute a classical attack.

There is no such thing as 100% secure system, digsig increases the level 
of security of the system as it just makes it much more difficult for 
the intruder to succeed in his/her attack.

regards,
makan

-------------------------------------------------------
Makan Pourzandi,
Ericsson Research Canada
*This email does not represent or express the opinions of
Ericsson Inc.
-------------------------------------------------------


