Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270477AbRHNH3B>; Tue, 14 Aug 2001 03:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270488AbRHNH2v>; Tue, 14 Aug 2001 03:28:51 -0400
Received: from mailhost.lineo.fr ([194.250.46.226]:10766 "EHLO
	mailhost.lineo.fr") by vger.kernel.org with ESMTP
	id <S270485AbRHNH2i>; Tue, 14 Aug 2001 03:28:38 -0400
Date: Tue, 14 Aug 2001 09:28:49 +0200
From: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: ptrace(), fork(), sleep(), exit(), SIGCHLD
Message-ID: <20010814092849.E13892@pc8.lineo.fr>
In-Reply-To: <20010813093116Z270036-761+611@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: =?iso-8859-1?Q?=3C20010813093116Z270036-76?=
	=?iso-8859-1?Q?1+611=40vger=2Ekernel=2Eorg=3E=3B_from_bruce=40cs=2Eusyd?=
	=?iso-8859-1?Q?=2Eedu=2Eau_on_lun=2C_ao=FB?= 13, 2001 at 10:29:32 +0200
X-Mailer: Balsa 1.2.pre1-cvs20010812
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you receive off-line answers?
I guess that it's certainly more a strace issue and that it's perhaps
'trivial' for most people here. But I would be interesting in knowing the
why behind this.

Christophe

Le lun, 13 aoû 2001 10:29:32, Bruce Janson a écrit :
> Hi,
>     The following program behaves incorrectly when traced:
> 
>   $ uname -a
>   Linux dependo 2.4.2-2 #1 Sun Apr 8 19:37:14 EDT 2001 i686 unknown
>   $ cc -v
>   Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
>   gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-81)
>   $ strace -V
>   strace -- version 4.2
>   $ cat t.c
>   main()
>   {
>   	switch (fork())
>   	{
>   	case -1:
>   		write(2, "fork\n", 5);
>   		break;
>   
>   	case 0:
>   		usleep(1000000);
>   		break;
>   
>   	default:
>   		if (usleep(5000000) == -1)
>   			write(2, "wrong\n", 6);
>   		break;
>   	}
>   
>   	exit(0);
>   }
>   $ cc t.c
>   $ time ./a.out
>   
>   real    0m5.011s
>   user    0m0.000s
>   sys     0m0.000s
>   $ time strace -o /dev/null ./a.out
>   wrong
>   
>   real    0m1.025s
>   user    0m0.010s
>   sys     0m0.010s
>   $ 
> 
> The problem appears to be that, when traced, the child process' exit()
> interrupts the parent's usleep() with a SIGCHLD, the latter returning
> EINTR.
> It also fails in the same way under Linux 2.2.16 and 2.2.19.
> 
> What am I missing?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-- 
Christophe Barbé
Software Engineer - christophe.barbe@lineo.fr
Lineo France - Lineo High Availability Group
42-46, rue Médéric - 92110 Clichy - France
phone (33).1.41.40.02.12 - fax (33).1.41.40.02.01
http://www.lineo.com
