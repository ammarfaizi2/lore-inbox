Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbTHZQww (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 12:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbTHZQww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 12:52:52 -0400
Received: from smtp2.brturbo.com ([200.199.201.158]:61068 "EHLO
	smtp2.brturbo.com") by vger.kernel.org with ESMTP id S262665AbTHZQwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 12:52:50 -0400
Message-ID: <3F4B9055.5070708@PolesApart.wox.org>
Date: Tue, 26 Aug 2003 13:52:37 -0300
From: Alexandre Pereira Nunes <alex@PolesApart.wox.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Doubt: core not dumped when binary give up root privileges.
References: <3F466E2A.8040905@PolesApart.wox.org> <1061913848.20910.55.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1061913848.20910.55.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Gwe, 2003-08-22 at 20:25, Alexandre Pereira Nunes wrote:
>  
>
>>The program explicitly sets RLIMIT_CORE to RLIM_INFINITY when still 
>>running with uid 0.
>>    
>>
>
>The kernel assumes a core image from something that was priviledged may
>be unsafe.
>  
>
That makes sense... By that time, I took a look at the sources and found 
the prctl syscall, and with a little tweaking it was possible to do what 
I wish (keep reading)...

>  
>
>>If instead of calling the program as root, I call it from the non-priv 
>>uid in question, if it crashes, it dumps core on the mentioned dir. 
>>That's the desired behaviour, since I can then take the core and debug. 
>>But if I run it as root (in fact, I would have to), and it crashes (or 
>>is forced to ,by means of kill -SEGV), after it gives up root 
>>credentials, it won't leave a core dump file, which in turn means I 
>>cannot debug it later.
>>
>>Any ideas?
>>    
>>
>
>2.4-ac has support for enabling setuid core dumps and setting the dump
>path, so you can write such dumps to /root/dumps and the kernel will
>make them root accessible only.
>
>The 2.6 test tree and Marcelo 2.4 don't currently support this
>
>  
>

That's an interesting feature and is almost exactly what I needed: I 
wrote a daemon, which is started by root at boot time. In some point at 
startup, it chroot to an application-specific directory and gives up 
privileges. If it would dump core, it had to be on that directory, which 
has somewhat restrict permissions, so that I (and only I) can get it 
later for further analysis. By means of chroot + prctl it was possible 
to achieve this, but it would be simpler with this approach of yours, 
which could also help in debugging in case something else crashes. I'm 
inclined to adopting it, even though the daemon will ship to run on 
third-parties machines, and I'll have no much control of what kernel is 
running there (probably distribution default ones). I'll see what is 
possible here... Thank you!

Alexandre

