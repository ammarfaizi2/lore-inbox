Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316545AbSEUIBJ>; Tue, 21 May 2002 04:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316548AbSEUIBJ>; Tue, 21 May 2002 04:01:09 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:61961 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S316545AbSEUIBH>; Tue, 21 May 2002 04:01:07 -0400
Message-ID: <3CE9FE86.3060808@loewe-komp.de>
Date: Tue, 21 May 2002 10:00:06 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Question : Broadcast Inter Process Communication ?
In-Reply-To: <20020517195438.A30640@bougret.hpl.hp.com> <5.1.0.14.2.20020520094738.068778a0@mail1.qualcomm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maksim (Max) Krasnyanskiy wrote:
> 
>> >       That's exactly why I don't want to deal with it myself.
>> >       However, the kernel deal with it all the time, and do it
>> > well. For example RtNetlink event have this property (except that they
>> > are kernel => process instead of beeing process => process).
>>
>> By sending one copy of the message to each target. Its how everyone does
>> it except for special cases. Reliable multi-delivery is -hard-
> 
> 
> I was gonna suggest the same thing. Why not just have a simple event 
> server based on unix sockets.
> This server would listen on unix stream socket. Clients interested in 
> events would connect to it.
> All the server has to do is copy event to all connected clients.
> Server code is very simple. About 20 lines, everything in a single 
> thread, if you use GLib's event loop.
> 

If using a central "server" process, all clients have to copy
the message to the server - then the server copies the messages
to multiple clients.

I can imagine a library, that holds a registry in shared mem, and
the clients look for themselves to whom to copy the message.
For this I want to use posix message queues to avoid lots of
context switches and copies.



