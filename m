Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130753AbQL2WGi>; Fri, 29 Dec 2000 17:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130867AbQL2WG2>; Fri, 29 Dec 2000 17:06:28 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:33032 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S130753AbQL2WGR>; Fri, 29 Dec 2000 17:06:17 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Roy Hills <Roy.Hills@nta-monitor.com>
Date: Sat, 30 Dec 2000 08:35:31 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14925.931.62753.695344@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UDP ports 800-n used by NFS client in 2.2.17
In-Reply-To: message from Roy Hills on Friday December 29
In-Reply-To: <4.3.2.7.2.20001229133326.00b28990@192.168.124.1>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday December 29, Roy.Hills@nta-monitor.com wrote:
> Does anyone know what causes netstat to show UDP port 800
> as active on a Linux NFS client with 2.2.17 kernel when an NFS filesystem
> is mounted?
> 
> Using Debian Linux 2.2 with Kernel 2.2.17 with one NFS filesystem mounted, 
> I see
> the following:
> 
>     rsh@lithium [3]$ netstat -n -a -u
>     Active Internet connections (servers and established)
>     Proto Recv-Q Send-Q Local Address          Foreign Address
>     udp        0      0 0.0.0.0:800            0.0.0.0:*
> 
> If I unmount the NFS Filesystem, the UDP port disappears.

That will be the local port that is used to talk to the NFS server.

> 
> It appears that each NFS mounted filesystem uses a separate UDP
> port, and that they count down from port 800.  I.e. the first
> mount uses UDP port 800, the second UDP port 799.
> 
> "lsof -i" doesn't show this port belonging to any process, and the "-p" 
> option to netstat
> doesn't show any process info either. I assume that this means that it's a 
> kernel thing
> rather than a process level thing.
> 
> A network sniff while mounting and umounting the NFS filesystem
> doesn't show any traffic on UDP port 800 - I just see portmapper, mountd 
> and nfs
> traffic.

While mounting and unmounting you might not (I'm not sure) but while
accessing the filesystem you definately should.
You say that you see "nfs" traffic.  Each packet has a source port and
a destintation port.  For an NFS request, the destination port will be 2049
on the server, the source port will be 800 (or 799 ...) on the client.

> 
> Does anyone know what this is or where I can look in the source for more info?
> I've searched /usr/src/linux/fs/nfs/*.c for 800 and 320 (800 in hex) 
> without success.

Check out net/sunrpc/xprt.c:xprt_bindresvport

NeilBrown

> 
> Roy Hills
> --
> Roy Hills                                    Tel:   +44 1634 721855
> NTA Monitor Ltd                              FAX:   +44 1634 721844
> 14 Ashford House, Beaufort Court,
> Medway City Estate,                          Email: Roy.Hills@nta-monitor.com
> Rochester, Kent ME2 4FA, UK                  WWW:   http://www.nta-monitor.com/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
