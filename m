Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130435AbRCGIzS>; Wed, 7 Mar 2001 03:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130444AbRCGIzI>; Wed, 7 Mar 2001 03:55:08 -0500
Received: from servo.isi.edu ([128.9.160.111]:1032 "EHLO servo.isi.edu")
	by vger.kernel.org with ESMTP id <S130435AbRCGIy5>;
	Wed, 7 Mar 2001 03:54:57 -0500
Message-Id: <200103070854.f278sBw06566@servo.isi.edu>
To: Alexander Viro <viro@math.psu.edu>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Mapping a piece of one process' addrspace to another? 
In-Reply-To: Message from Alexander Viro <viro@math.psu.edu> 
   of "Wed, 07 Mar 2001 03:40:58 EST." <Pine.GSO.4.21.0103070337560.2127-100000@weyl.math.psu.edu> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6563.983955251.1@servo.isi.edu>
Date: Wed, 07 Mar 2001 00:54:11 -0800
From: Jeremy Elson <jelson@circlemud.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
>On Wed, 7 Mar 2001, Jeremy Elson wrote:
>
>> Right now, my code looks something like this: (it might make more
>> sense if you know that I've written a framework for writing user-space
>> device drivers... I'm going to be releasing it soon, hopefully after I
>> resolve this performance problem.  Or maybe before, if it's hard.)
>
>Ugh. Why not make that a named pipe and use zerocopy stuff for pipes?
>I.e. why bother with making it look like a character device rather than
>a FIFO?

Well, because it's a character device :-).  i.e,. the framework allows
you to write a userspace program that services callbacks for character
devices.  Inside the kernel, all open()/release()/ioctl()/etc calls
for the device are proxied out to userspace where a library calls a
userspace callback, and the result goes back to the kernel where it is
then returned to the calling process.

The problem is just that to return data (instead of just a retval), as
is needed for read and some ioctls, it leads to 3 copies as I
described earlier. 

BTW, where are the zerocopy patches for pipes?  Maybe I'm missing
something but it seems that pipes inside the kernel are still
implememented by copying into the kernel and then copying out.
Whatever method the zerocopy pipes use is probably what I'm looking
for though.

-Jer
