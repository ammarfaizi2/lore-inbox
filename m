Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265939AbTAPJrC>; Thu, 16 Jan 2003 04:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265987AbTAPJrC>; Thu, 16 Jan 2003 04:47:02 -0500
Received: from c3p0.cc.swin.edu.au ([136.186.1.10]:7690 "EHLO
	net.cc.swin.edu.au") by vger.kernel.org with ESMTP
	id <S265939AbTAPJrB>; Thu, 16 Jan 2003 04:47:01 -0500
From: Tim Connors <tconnors@astro.swin.edu.au>
Message-Id: <200301160955.h0G9ttZ27704@hexane.ssi.swin.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [NFS] Re: broken umount -f
In-Reply-To: <20030114160031$24bb@gated-at.bofh.it>
References: <20030114160031$24bb@gated-at.bofh.it>
Date: Thu, 16 Jan 2003 20:55:55 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux.kernel, you wrote:
>> >>For as long as I remember, umount -f has been broken. I got 
>> a reminder 
>> >>of this fact today when we took an older NFS server out of 
>> use. I had 
>> >>to reboot almost all machines that had mounts from this server. Not 
>> >>nice.
>> >>
>> >>Anyone knows why -f does not work? When I try, I get:
>> >>
> "umount -f" doesn't end pending RPCs.  if there are processes
> with pending RPCs, then they are stuck and you will have to
> reboot.  "intr" may allow some of these processes to be killed
> before trying the "umount."
> 
> however, if there are no outstanding RPCs on the client, but
> the server is not available, umount -f works as advertised.

What I have never understood, is that if you are reading a file, or
even just in a directory, and the server goes down, and won't come
back up (say, you have taken your laptop into work, and forgot to turn
off autofs first, after killing all shells that had cd'd to the nfs
directory), then you still are destined to have to reboot. You could
sever all connections to the nfs server safely, because nothing is
being written there (except maybe atime information - but not in the
case of a shell being cd'd to an nfs path). But linux won't give up on
the connection. Come on, what harm could possibly come to an
application that has only readonly files open, or cwd in an NFS path?
No data loss would occur in this situation, so just drop the
connection, and return -EIO to anything that then later wants to read
a file.

If the admin is wanting to use umount -f, then surely he will be
edumucated enough to make sure data loss will not occur first, or that
the consequences are less than if he just left the mount hang.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/

You see, wire telegraph is a kind of a very, very long cat. You pull
his tail in New York and his head is meowing in Los Angeles.  Do you
understand this?  And radio operates exactly the same way:  you send
signals here,  they receive them there.  The only difference is that
there is no cat.   -- Albie E. on radios. 
