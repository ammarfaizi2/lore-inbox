Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283325AbRK2QoU>; Thu, 29 Nov 2001 11:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283329AbRK2QoK>; Thu, 29 Nov 2001 11:44:10 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:32248 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S283325AbRK2Qn5>;
	Thu, 29 Nov 2001 11:43:57 -0500
Date: Thu, 29 Nov 2001 09:43:48 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Christopher Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: logging to NFS-mounted files seems to cause hangs when NFS dies
Message-ID: <20011129094348.E29249@lynx.no>
Mail-Followup-To: Christopher Friesen <cfriesen@nortelnetworks.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C065D2F.B45332C6@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3C065D2F.B45332C6@nortelnetworks.com>; from cfriesen@nortelnetworks.com on Thu, Nov 29, 2001 at 11:07:11AM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2001  11:07 -0500, Christopher Friesen wrote:
> I'm working on an embedded platform and we seem to be having a problem with
> syslog and logging to NFS-mounted files.
> 
> We have syslog logging to NFS and also logging to a server on another machine.

Why not just log to the syslog daemon on another machine.  Logging to NFS
does not help you in this case.

> The desired behaviour is that if the NFS server or the net connection conks
> out, the logs are silently dropped.  (Critical logs are also logged in memory
> that isn't wiped out on reboot.)

> The problem we are seeing is that if we lose the network connection or the
> NFS mount (which immediately causes an attempt to log the problem), it seems
> that syslog gets stuck in NFS code in the kernel and other stuff can be
> delayed for a substantial amount of time (many tens of seconds).  Just for
> kicks we tried logging to ramdisk, and everything works beautifully.

Well, it seems obvious, doesn't it?  If the network connection is lost, then
you can't very well write to the Network File System, can you?  One of the
features of NFS is that if the network dies, or the server is lost, then
the client does not lose any data that was being written to the NFS mount.

> Now I'm a bit unclear as to why other processes are being delayed--does anyone
> have any ideas?  My current theories are that either the nfs client code has a
> bug, or syslog() calls are somehow blocking if syslogd can't write the file
> out.  I've just started looking at the syslog code, but its pretty rough going
> as there are very few comments.

This is entirely a syslog problem, if you want to do it that way.  The NFS
code is working as expected, and will not be changed.  You might have to
multi-thread syslog to get it to do what you want, but in the end you are
better off just using the network logging feature and write the logs at
the server directly.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

