Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270978AbTGVSE0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 14:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270979AbTGVSE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 14:04:26 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:7176 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S270978AbTGVSEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 14:04:23 -0400
Message-ID: <3F1D81A2.1060402@kolumbus.fi>
Date: Tue, 22 Jul 2003 21:25:38 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jason Baron <jbaron@redhat.com>,
       Rene Mayrhofer <rene.mayrhofer@gibraltar.at>,
       vda@port.imtp.ilyichevsk.odessa.ua,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pivot_root seems to be broken in 2.4.21-ac4
References: <Pine.LNX.4.44.0307221331090.2754-100000@dhcp64-178.boston.redhat.com> <1058895650.4161.23.camel@dhcp22.swansea.linux.org.uk>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 22.07.2003 21:20:49,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 22.07.2003 21:20:16,
	Serialize complete at 22.07.2003 21:20:16
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:

>On Maw, 2003-07-22 at 18:37, Jason Baron wrote:
>  
>
>>>I tell init to re-execute itself (after pivot_root and thus from the new 
>>>root fs), which causes init to close its old fds and open new ones from 
>>>the new root fs with. This is necessary because init already runs as pid 
>>>1 when I start the root fs switching. Maybe something changed with the 
>>>kernel process fds from 2.4.21-rc2 to 2.4.21-ac4 ?
>>>
>>>      
>>>
>>yes, see the addition of the unshare_files function in kernel/fork.c
>>    
>>
>
>Shouldnt really have changed anything except for security exploits and
>threaded apps doing weird stuff. In normal situations the files count is
>one so we should actually be executing nothing more exciting that an
>atomic_inc/atomic_dec.
>
>I wonder what is going on here.
>
>-
>  
>
But kernel threads may be incrementing init's files->count before user 
space init execs, so unshare_files() after execve("/sbin/init") ends up 
copying files.

--Mika


