Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283368AbRK2VBo>; Thu, 29 Nov 2001 16:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283393AbRK2VBe>; Thu, 29 Nov 2001 16:01:34 -0500
Received: from dialin-145-254-146-210.arcor-ip.net ([145.254.146.210]:7218
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S283368AbRK2VB2>; Thu, 29 Nov 2001 16:01:28 -0500
Message-ID: <3C06A222.1C7AB589@loewe-komp.de>
Date: Thu, 29 Nov 2001 22:01:22 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.13-xfs i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Christopher Friesen <cfriesen@nortelnetworks.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: logging to NFS-mounted files seems to cause hangs when NFS dies
In-Reply-To: <3C065D2F.B45332C6@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen schrieb:
> 
> I'm working on an embedded platform and we seem to be having a problem with
> syslog and logging to NFS-mounted files.
> 
> We have syslog logging to NFS and also logging to a server on another machine.
> The desired behaviour is that if the NFS server or the net connection conks out,
> the logs are silently dropped.  (Critical logs are also logged in memory that
> isn't wiped out on reboot.)
> 
> Currently,  /var/log is mounted with the following options:
> rw,rsize=4096,wsize=4096,timeo=7,retrans=3,bg,soft,intr
> 
> We started off with hard mounts due to the warnings about soft mounts, but that
> led to boxes totally hanging when the network connections were pulled or the NFS
> server was taken down.  In this scenario we are even unable to login as root at
> the console.  This forced us to go to soft mounts in an attempt to fix this
> behaviour.
> 
> The problem we are seeing is that if we lose the network connection or the NFS
> mount (which immediately causes an attempt to log the problem), it seems that
> syslog gets stuck in NFS code in the kernel and other stuff can be delayed for a
> substantial amount of time (many tens of seconds).  Just for kicks we tried
> logging to ramdisk, and everything works beautifully.
> 
> Now I'm a bit unclear as to why other processes are being delayed--does anyone
> have any ideas?  My current theories are that either the nfs client code has a
> bug, or syslog() calls are somehow blocking if syslogd can't write the file
> out.  I've just started looking at the syslog code, but its pretty rough going
> as there are very few comments.
> 
> Help?  We're running a customized 2.2.17 kernel and syslog 1.4.1.
> 

I can recommend syslogd's ability to log to remote syslogd via

/etc/syslog.conf

*.info	|host.or.ip


The remote site has to run syslogd with "syslogd -r".
Since it uses UDP there is no blocking.
