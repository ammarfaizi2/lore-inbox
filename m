Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277626AbRJHXoW>; Mon, 8 Oct 2001 19:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277622AbRJHXoD>; Mon, 8 Oct 2001 19:44:03 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:51210 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S277624AbRJHXn4>; Mon, 8 Oct 2001 19:43:56 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: gregory.hosler@eno.ericsson.se
Date: Tue, 9 Oct 2001 09:30:11 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15298.14083.831047.525536@notabene.cse.unsw.edu.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel: svc: bad direction / kernel: svc: short len 4, dropping request
In-Reply-To: message from Gregory Hosler on Friday October 5
In-Reply-To: <XFMail.011005112704.gregory.hosler@eno.ericsson.se>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday October 5, gregory.hosler@eno.ericsson.se wrote:
> Hi,
> 
> I'm running Linux kernel 2.4.7, and I'm seeing the following in my syslog:
> 
> Oct  5 09:13:44 camelot kernel: svc: short len 4, dropping request
> Oct  5 09:13:45 camelot kernel: svc: short len 4, dropping request
> Oct  5 09:13:46 camelot kernel: svc: bad direction 525795537, dropping request
> Oct  5 09:13:46 camelot kernel: svc: short len 4, dropping request
> Oct  5 09:13:47 camelot kernel: svc: short len 4, dropping request
> Oct  5 09:13:48 camelot kernel: svc: bad direction 525861077, dropping request
> Oct  5 09:13:48 camelot kernel: svc: bad direction 525927291, dropping request
> Oct  5 09:13:48 camelot kernel: svc: bad direction 525992033, dropping request
> Oct  5 09:13:48 camelot kernel: svc: bad direction 526057939, dropping request
> Oct  5 09:13:48 camelot kernel: svc: bad direction 526123899, dropping request
> Oct  5 09:13:48 camelot kernel: svc: short len 4, dropping request
> Oct  5 09:13:49 camelot kernel: svc: short len 4, dropping request
> Oct  5 09:13:49 camelot kernel: svc: bad direction 526189001, dropping request
> Oct  5 09:13:50 camelot kernel: svc: short len 4, dropping request
> Oct  5 09:13:50 camelot kernel: svc: bad direction 526254179, dropping request
> 
> several (3 to 5) messages per second.
> 
> I have tracked down these messages to coming out of:
> 
>         /usr/src/linux/net/sunrpc/svc.c
> 
> but I do not understand what's triggering them, or what to do about
> them.

Looks like garbage packets are being delivered to either your NFS
server port (port 2049) or your lockd server port (run rpcinfo -p to
find the number).

I would run tcpdump on the interface watching for packets to those
ports from unexpected sources.

NeilBrown

> 
> any suggestions, pointers, hints appreciated.
> 
> thank you, and regards,
> 
> -Greg
> 
> ----------------------------------
> E-Mail: Gregory Hosler <gregory.hosler@eno.ericsson.se>
> Date: 05-Oct-01
> Time: 11:23:35
> 
>    You can release software that's good, software that's inexpensive, or
>    software that's available on time.  You can usually release software
>    that has 2 of these 3 attributes -- but not all 3.
> 
> ----------------------------------
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
