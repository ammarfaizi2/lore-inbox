Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268607AbUHLQeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268607AbUHLQeK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 12:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268605AbUHLQeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 12:34:10 -0400
Received: from 8.75.30.213.rev.vodafone.pt ([213.30.75.8]:26375 "EHLO
	odie.graycell.biz") by vger.kernel.org with ESMTP id S268608AbUHLQbu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 12:31:50 -0400
Subject: Re: Process hangs copying large file to cifs
From: Nuno Ferreira <nuno.ferreira@graycell.biz>
To: Steve French <smfltc@us.ibm.com>
Cc: linux-cifs-client@lists.samba.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1088507544.2418.1.camel@taz.graycell.biz>
References: <1088459930.5666.8.camel@stevef95.austin.ibm.com>
	 <1088507544.2418.1.camel@taz.graycell.biz>
Content-Type: text/plain
Organization: Graycell
Date: Thu, 12 Aug 2004 17:31:42 +0100
Message-Id: <1092328302.4172.42.camel@taz.graycell.biz>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.92.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Aug 2004 16:31:43.0173 (UTC) FILETIME=[DA21A750:01C48089]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Ter, 2004-06-29 at 12:12 +0100, Nuno Ferreira wrote:
> On Seg, 2004-06-28 at 16:58 -0500, Steve French wrote:
> > >  > This is copying a 197Mb from an my laptop's IDE hardisk to a cifs 
> > > mounted share that's on a Win2000 Server
> > 
> > Linus had suggested hashing cifs inodes, which makes sense as related to
> > the problem that you reported.  I have coded that and it tested out ok
> > today. If you have a chance could you try the patch at:
> > 
> > http://cifs.bkbits.net:8080/linux-2.5cifs/gnupatch@40e0925dAlasT6JDoPqQE2q3e-zYiw
> 
> I applied it by hand to plain 2.6.7 (had some rejects) and it appears to
> work. Thank you.
> I just copied a 600Mb from my laptop to the server with no problems,
> continued to work on my desktop with no visible effects.

Unfortunately it appears the problem still exists, or maybe it's another
one with the same visible effects.
I don't use the windows share very often, and with large files it's even
less often, so I just found out today.
Trying to copy a ~180Mb file from the same machine (still using the same
kernel) to the same share, I had the same problem. Eventually, after
30min and lot's of freezes the file was copied but corrupted.
Here 
One thing is different, this time I got messages in the system logs,
they repeat for the whole time the file was copying.
Also, after copying the file I had this strange (-6) ReqActive count, is
it expected? Now (about 10 min later) it shows 0;

nmf@taz:~/Desktop/Downloads$ cat /proc/fs/cifs/DebugData
Display Internal CIFS Data Structures for Debugging
---------------------------------------------------
Servers:

1) Name: 10.1.1.14  Domain: GRAYCELL Mounts: 1 ServerOS: Windows 5.0
        ServerNOS: Windows 2000 LAN Manager     Capabilities: 0xf3fd
        SMB session status: 1   TCP status: 1
        Local Users To Server: 1 SecMode: 0x3 Req Active: -6
2) Name: 10.1.1.1  Domain: GRAYCELL Mounts: 1 ServerOS: Windows 5.0
        ServerNOS: Windows 2000 LAN Manager     Capabilities: 0xf3fd
        SMB session status: 3   TCP status: 1
        Local Users To Server: 1 SecMode: 0x3 Req Active: 0

Shares:

1) \\pepe\nmf Uses: 1 Type: FAT Characteristics: 0x20 Attributes: 0x6
PathComponentMax: 255 Status: 1 type: DISK
2) \\ODIE\GRAYCELL Uses: 1 Type: NTFS Characteristics: 0x20 Attributes: 0x700ff
PathComponentMax: 255 Status: 3 type: DISK      DISCONNECTED

Here are the errors
syslog
------
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:13:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:13:00 taz kernel:  CIFS VFS: No task to wake, unknown frame rcvd!
Aug 12 16:13:00 taz kernel: Received Data is: : dump of 37 bytes of data at 0xd9e10660
Aug 12 16:13:00 taz kernel:
Aug 12 16:13:00 taz kernel:  2f000000 424d53ff 0000002f c0018000 . . . / \xff S M B / . . . . . . \xc0
Aug 12 16:13:00 taz kernel:  00000000 00000000 00000000 0c796002 . . . . . . . . . . . . . ` y .
Aug 12 16:13:00 taz kernel:  0b39d000 2f00ff06 . \xd0 9 . .
Aug 12 16:13:02 taz kernel:  CIFS VFS: No response buffer
Aug 12 16:13:07 taz last message repeated 5 times
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: No task to wake, unknown frame rcvd!
Aug 12 16:14:00 taz kernel:
Aug 12 16:14:00 taz kernel:  2f000000 424d53ff 0000002f c0018000 . . . / \xff S M B / . . . . . . \xc0
Aug 12 16:14:00 taz kernel:  00000000 00000000 00000000 0c796000 . . . . . . . . . . . . . ` y .
Aug 12 16:14:00 taz kernel:  0cbeb800 2f00ff06 . \xb8 \xbe . .
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:00 taz kernel:  CIFS VFS: sends on sock dc041620 stuck for 30 seconds
Aug 12 16:14:00 taz kernel:  CIFS VFS: Error -11 sending data on socket to server.
Aug 12 16:14:02 taz kernel:  CIFS VFS: No response buffer
Aug 12 16:14:07 taz last message repeated 7 times

-- 
Nuno Ferreira

