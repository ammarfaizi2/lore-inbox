Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbSIWS46>; Mon, 23 Sep 2002 14:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261367AbSIWS4M>; Mon, 23 Sep 2002 14:56:12 -0400
Received: from pr-66-150-46-254.wgate.com ([66.150.46.254]:35898 "EHLO
	mail.tvol.net") by vger.kernel.org with ESMTP id <S261364AbSIWSzC>;
	Mon, 23 Sep 2002 14:55:02 -0400
Message-ID: <3D8F64BA.4010005@wgate.com>
Date: Mon, 23 Sep 2002 15:00:10 -0400
From: Michael Sinz <msinz@wgate.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.1b) Gecko/20020813
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>, marcelo@conectiva.com.br,
       Linux Kernel List <linux-kernel@vger.kernel.org>, akpm@digeo.com,
       riel@conectiva.com.br, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       rml@tech9.net
Subject: Re: [PATCH] kernel 2.4.19 & 2.5.38 - coredump sysctl
References: <Pine.LNX.3.96.1020922145444.7597A-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> On Fri, 20 Sep 2002, Andrew Morton wrote:
> 
>>That seems a reasonable thing to want to do.
>>
>>>...
>>>The following format options are available in that string:
>>>
>>>       %P   The Process ID (current->pid)
>>>       %U   The UID of the process (current->uid)
>>>       %N   The command name of the process (current->comm)
>>>       %H   The nodename of the system (system_utsname.nodename)
>>>       %%   A "%"
>>>
>>>For example, in my clusters, I have an NFS R/W mount at /coredumps
>>>that all nodes have access to. The format string I use is:
>>>
>>>        sysctl -w "kernel.core_name_format=/coredumps/%H-%N-%P.core"
>>>
>>
>>Does it need to be this fancy?  Why not just have:
>>
>>        if (core_name_format is unset)
>>                use "core"
>>        else
>>                use core_name_format/nodename-uid-pid-comm.core
> 
> 
> Because this way you can do more things with where you put your dumps,
> such as using one element of this flexible method to select a directory,
> where the dump directories for various applications would be on a single
> NFS server, and dumps for another might be on another server, or all dumps
> of a certain kind could share a filename, where only the latest dump would
> be of interest (or take space).

Ahh, I never thought of using the program name for a directory.  That
would be nice as only those programs you pre-made a directory for would
dump (as the code does not create directories).  Using the UID for a
directory name works out to separate the dumps of different users.
(And works really well too - albeit on a non-Linux platform that happens
to have a simular feature.)

> The code seems to have very little overhead involved in the parse, and it
> gives a good deal of flexibility to the admin. I like the idea of a sysctl
> for setting the value, you don't want to have to reboot the system when an
> app goes sour and you need to save more than one dump to run it down, or
> need to mvoe the dump target dir somewhere with more space.
> 
> If you're worried about size make it a compile option, but if I (as an
> admin) need any control I really want a bunch of control I can set right
> now. I don't think most people will want this option, but it would be
> really useful in some cases.

I would be willing to do the work to make it configurable but when I
look at the size of the code, it really is not that large.  I tried
to keep it simple (KISS is always good).  I still need to write up the
documentation side of this into the patch too.  (I keep forgetting
to do that :-()

-- 
Michael Sinz -- Director, Systems Engineering -- Worldgate Communications
A master's secrets are only as good as
	the master's ability to explain them to others.


