Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbSK1DaQ>; Wed, 27 Nov 2002 22:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265134AbSK1DaQ>; Wed, 27 Nov 2002 22:30:16 -0500
Received: from 222-251.dslpool.net ([64.254.222.251]:56200 "EHLO sixfold.com")
	by vger.kernel.org with ESMTP id <S265132AbSK1DaO>;
	Wed, 27 Nov 2002 22:30:14 -0500
Date: Wed, 27 Nov 2002 21:17:18 -0600 (CST)
From: Ivan Pulleyn <ivan@sixfold.com>
To: Philippe Troin <phil@fifi.org>
cc: <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Subject: Re: Wierd listen/connect: accept queue never fills up
In-Reply-To: <87y97ee6xy.fsf@ceramic.fifi.org>
Message-ID: <Pine.LNX.4.33.0211272112200.25730-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



What was the sysctl value for net.ipv4.tcp_syn_max_backlog set to
while running this test? That's the value you are testing, not the
listen() queue size.

Ivan...


On 27 Nov 2002, Philippe Troin wrote:

> [Andi, I've CC'ed you since you're listed as the author of the `new
> listen' code in net/ipv4/tcp_ipv4.c]
> 
> Seen on linux 2.4.20rc2.
> 
> This program is always able to establish new connections to itself:
> the accept queue never fills up and connections always succeed
> (although they take quite some time after the first four):
> 
>   #include <stdio.h>
>   #include <sys/types.h>
>   #include <sys/socket.h>
>   #include <netinet/in.h>
> 
>   int main(void)
>   {
>     int fd;
>     struct sockaddr_in sin;
>     socklen_t sinlen;
> 
>     if ((fd = socket(PF_INET, SOCK_STREAM, 0)) == -1)
>       perror("socket"), exit(1);
> 
>     sin.sin_family      = AF_INET;
>     sin.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
>     sin.sin_port	      = htons(0);
>     if (bind(fd, (struct sockaddr*)&sin, sizeof(sin)) == -1)
>       perror("bind"), exit(1);
>     if (listen(fd, 1) == -1)
>       perror("listen"), exit(1);
> 
>     sinlen = sizeof(sin);
>     getsockname(fd, (struct sockaddr*)&sin, &sinlen);
> 
>     while (1)
>       {
>         int fdc;
> 
>         if ((fdc = socket(PF_INET, SOCK_STREAM, 0)) == -1)
>   	perror("socket"), exit(1);
>         printf("%c", connect(fdc, (struct sockaddr*)&sin, sinlen) == -1
>   	     ? 'F' : '.');
>         fflush(stdout);
>       }
> 
>     exit(0);
>   }
> 
> I've tried enabling and disabling tcp_syncookies, without any effect.
> 
> The same program starts returning errors after two successful connects
> on Solaris and one on HP-UX. Linux keeps returning new connections...
> 
> Phil.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 

----------------------------------------------------------------------
Ivan Pulleyn
Sixfold Technologies, LLC
Chicago Technology Park
2201 West Campbell Drive
Chicago, IL 60612

email:    ivan@sixfold.com
voice:    (866) 324-5460 x601
fax:      (312) 421-0388
----------------------------------------------------------------------

