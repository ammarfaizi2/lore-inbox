Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263554AbSITVYp>; Fri, 20 Sep 2002 17:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263579AbSITVYp>; Fri, 20 Sep 2002 17:24:45 -0400
Received: from pr-66-150-46-254.wgate.com ([66.150.46.254]:16610 "EHLO
	mail.tvol.net") by vger.kernel.org with ESMTP id <S263554AbSITVYn>;
	Fri, 20 Sep 2002 17:24:43 -0400
Message-ID: <3D8B934A.1060900@wgate.com>
Date: Fri, 20 Sep 2002 17:29:46 -0400
From: Michael Sinz <msinz@wgate.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.1b) Gecko/20020813
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: mks@sinz.org, marcelo@conectiva.com.br, Robert Love <rml@tech9.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>, riel@conectiva.com.br,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] kernel 2.4.19 & 2.5.38 - coredump sysctl
References: <3D8B87C7.7040106@wgate.com> <3D8B8CAB.103C6CB8@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Michael Sinz wrote:
> 
>>coredump name format control via sysctl
>>
>>Provides for a way to securely move where core files show up and to
>>set the name pattern for core files to include the UID, Program,
>>Hostname, and/or PID of the process that caused the core dump.
> 
> 
> That seems a reasonable thing to want to do.
> 
> 
>>...
>>The following format options are available in that string:
>>
>>       %P   The Process ID (current->pid)
>>       %U   The UID of the process (current->uid)
>>       %N   The command name of the process (current->comm)
>>       %H   The nodename of the system (system_utsname.nodename)
>>       %%   A "%"
>>
>>For example, in my clusters, I have an NFS R/W mount at /coredumps
>>that all nodes have access to. The format string I use is:
>>
>>        sysctl -w "kernel.core_name_format=/coredumps/%H-%N-%P.core"
>>
> 
> 
> Does it need to be this fancy?  Why not just have:
> 
>         if (core_name_format is unset)
>                 use "core"
>         else
>                 use core_name_format/nodename-uid-pid-comm.core
> 
> which saves all that string format processing, while giving
> people everything they could want?

Well, it depends on if you really need the complex form or not.

There are some people who use a format of:

	%N.%P.core

which places the core file in the current directory but adds in the
name of the program.  (Something that is very nice when you have
a lot of programs that may core "together" when something bad happens)

The string processing is not that much work anyway (very small)
and, given the fact that I am about to write to disk a core dump,
it can not be a critical path/fast path issue either :-)

What can be done at the default pattern level in later kernels
would be to make it a bit more than just "core" (such as maybe
the "%N.%P.core" or something like that) but that is not that
complex.

Also, FreeBSD (yes, I know, it is not Linux) has a very simular
feature that we used for the FreeBSD clusters we built.

-- 
Michael Sinz -- Director, Systems Engineering -- Worldgate Communications
A master's secrets are only as good as
	the master's ability to explain them to others.


