Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263794AbSK0BhX>; Tue, 26 Nov 2002 20:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263968AbSK0BhX>; Tue, 26 Nov 2002 20:37:23 -0500
Received: from ivoti.terra.com.br ([200.176.3.20]:56218 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP
	id <S263794AbSK0BhQ>; Tue, 26 Nov 2002 20:37:16 -0500
Date: Tue, 26 Nov 2002 23:44:29 -0200
From: Christian Reis <kiko@async.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19+trond and diskless locking problems
Message-ID: <20021126234429.C9737@blackjesus.async.com.br>
References: <20021003184418.K3869@blackjesus.async.com.br> <shsy99f16np.fsf@charged.uio.no> <20021003202602.M3869@blackjesus.async.com.br> <15772.60202.510717.850059@charged.uio.no> <20021120120223.A15034@blackjesus.async.com.br> <15835.49194.109931.227732@charged.uio.no> <20021126224123.A9660@blackjesus.async.com.br> <15844.7306.735524.133781@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <15844.7306.735524.133781@charged.uio.no>; from trond.myklebust@fys.uio.no on Wed, Nov 27, 2002 at 02:14:50AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 02:14:50AM +0100, Trond Myklebust wrote:
> >>>>> " " == Christian Reis <kiko@async.com.br> writes:
> 
>      > a) ps ax | grep lockd returns:
> 
>      >    94 ?  DW 0:00 [lockd]
> 
>      >     Why would lockd be in state "D"? Looks bad. Can this happen
>      >     in normal usage? It kicks the loadavg up 1 point.
> <snip>
>      >     [ 10-second delay here ]
> 
>      >     09:24:18.988289 violinux.async.com.br.793 >
>      >     anthem.async.com.br.sometimes-rpc4: udp 180 (DF)
> 
>      >     [ 11-second delay here ]
> 
> OK, so you are sending out the RPC request to the server's NLM daemon,
> which is clearly receiving the packet (since tcpdump was able to log
> it), but is never sending a reply. Are you seeing any kernel messages
> in the syslog?

No. The kernel log (kern.* in syslog) is very quite during this period -
the only messenges I get are the eth0 promiscuous mode messages that
tcpdump triggers when it runs.

My messenges file just lists the mounts:

Nov 22 09:24:04 anthem rpc.mountd: authenticated mount request from violinux.async.com.br:800 for /
export/root (/export) Nov 22 09:24:06 anthem dhcpd: DHCPDISCOVER from 00:01:03:d7:f3:0a via eth0
Nov 22 09:24:06 anthem dhcpd: DHCPOFFER on 192.168.99.2 to 00:01:03:d7:f3:0a via eth0
Nov 22 09:24:06 anthem dhcpd: DHCPDISCOVER from 00:01:03:d7:f3:0a via eth0
Nov 22 09:24:06 anthem dhcpd: DHCPOFFER on 192.168.99.2 to 00:01:03:d7:f3:0a via eth0
Nov 22 09:24:06 anthem dhcpd: DHCPREQUEST for 192.168.99.2 (192.168.99.4) from 00:01:03:d7:f3:0a via eth0
Nov 22 09:24:06 anthem dhcpd: DHCPACK on 192.168.99.2 to 00:01:03:d7:f3:0a via eth0
Nov 22 09:24:08 anthem rpc.mountd: authenticated mount request from violinux.async.com.br:707 for /home (/home) 
Nov 22 09:24:08 anthem rpc.mountd: authenticated mount request from violinux.async.com.br:711 for /mondo (/mondo) 
Nov 22 09:24:08 anthem rpc.mountd: authenticated mount request from violinux.async.com.br:715 for /dist (/dist) 
Nov 22 09:24:08 anthem rpc.mountd: authenticated mount request from violinux.async.com.br:719 for /var/spool/mail (/var/spool/mail) 
Nov 22 09:24:08 anthem rpc.mountd: authenticated mount request from
violinux.async.com.br:712 for /export/root/var/spool/violinux (/export) 
Nov 22 09:24:08 anthem rpc.mountd: authenticated mount request from violinux.async.com.br:714 for /export/root/var/log/violinux (/export) 
Nov 22 09:27:31 anthem named[141]: "lab.16.106.143.in-addr.arpa IN NS"
points to a CNAME (grande.ic .unicamp.br)

(yep, unrelated last line just to show nothing is going on)

> BTW: the tcpdumps you're showing are all UDP, not TCP...

100% true, as I noticed as I pressed "y" to send. :-)

Take care,
--
Christian Reis, Senior Engineer, Async Open Source, Brazil.
http://async.com.br/~kiko/ | [+55 16] 261 2331 | NMFL
