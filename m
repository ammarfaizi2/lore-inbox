Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286161AbRLZFvm>; Wed, 26 Dec 2001 00:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286167AbRLZFvd>; Wed, 26 Dec 2001 00:51:33 -0500
Received: from oe31.law14.hotmail.com ([64.4.20.88]:51977 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S286161AbRLZFvW>;
	Wed, 26 Dec 2001 00:51:22 -0500
X-Originating-IP: [65.27.38.196]
From: "Idrigal \(Eric Rautenkranz\)" <darklordoflinux@hotmail.com>
To: "Paul Boley" <pboley@home.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <3C295D5C.50EE365D@home.com>
Subject: Re: severe slowdown with 2.4 series w/heavy disk access
Date: Tue, 25 Dec 2001 23:51:15 -0600
Organization: Ion Networks, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE31AHYoHyYGNTrzLHw0000763c@hotmail.com>
X-OriginalArrivalTime: 26 Dec 2001 05:51:16.0275 (UTC) FILETIME=[555A5830:01C18DD1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is quite possible your MB routes all disk access straight through the
processor, while using system ram to cache itself.  Tar does not (to my
knowledge) limit itself, and is quite nasty on such things.  My MB has had
troubles as such before.  I know of no workaround, except get a new MB.

><><>< Idrigal of Imladris
----- Original Message -----
From: "Paul Boley" <pboley@home.com>
To: <linux-kernel@vger.kernel.org>
Sent: Tuesday, 25 December, 2001 11:17 PM
Subject: severe slowdown with 2.4 series w/heavy disk access


> I have been having this problem with the whole 2.4 kernel series.. Under
> heavy disk access, the entire system will slow down and almost all of my
> memory, save 5 megs, gets used up, never to return.  I am currently
> running 2.4.17 on a machine with 416 megs of ram, Duron 750, not
> overclocked.  Cpu temp does not exceed 107 deg F ever, so I don't think
> its a heat issue.  I have an MSI K7T Pro2 motherboard, using the KT133
> chipset.  Anyway, the following is how I can duplicate the problem, in
> about 5 minutes.  I only used mozilla for this because I was working
> with it when I decided to isolate the problem.  Also note this happens
> more than just with tar, and sometimes it happens for no apparent reason
> at all.
>
> *** free and ps -ax, before the slowdown:
>
>              total       used       free     shared    buffers
> cached
> Mem:        417472      30104     387368          0       1264
> 21748
> -/+ buffers/cache:       7092     410380
> Swap:       136544          0     136544
>
>   PID TTY      STAT   TIME COMMAND
>     1 ?        S      0:04 init
>     2 ?        SW     0:00 [keventd]
>     3 ?        SWN    0:00 [ksoftirqd_CPU0]
>     4 ?        SW     0:00 [kswapd]
>     5 ?        SW     0:00 [bdflush]
>     6 ?        SW     0:00 [kupdated]
>    63 ?        S      0:00 /usr/sbin/syslogd
>    66 ?        S      0:00 /usr/sbin/klogd -c 3
>    78 ?        S      0:00 /usr/sbin/atd -b 15 -l 1
>    90 tty1     S      0:00 -bash
>    91 tty2     S      0:00 -bash
>    92 tty3     S      0:00 /sbin/agetty 38400 tty3 linux
>    93 tty4     S      0:00 /sbin/agetty 38400 tty4 linux
>    94 tty5     S      0:00 /sbin/agetty 38400 tty5 linux
>    95 tty6     S      0:00 /sbin/agetty 38400 tty6 linux
>   192 tty2     S      0:00 top
>   200 tty1     R      0:00 ps -ax
>
> *** I then rm -rf'd mozilla, and tar -zxvf mozilla-source-0.9.7.tar.gz,
> *** and immediately after, ran free and ps -ax again.  The system
> started
> *** losing memory and slowing down about 10 seconds into the
> *** decompression.
>
>              total       used       free     shared    buffers
> cached
> Mem:        417472     412192       5280          0      20632
> 315680
> -/+ buffers/cache:      75880     341592
> Swap:       136544          0     136544
>
>   PID TTY      STAT   TIME COMMAND
>     1 ?        S      0:04 init
>     2 ?        SW     0:00 [keventd]
>     3 ?        SWN    0:00 [ksoftirqd_CPU0]
>     4 ?        SW     0:00 [kswapd]
>     5 ?        SW     0:00 [bdflush]
>     6 ?        SW     0:02 [kupdated]
>    63 ?        S      0:00 /usr/sbin/syslogd
>    66 ?        S      0:00 /usr/sbin/klogd -c 3
>    78 ?        S      0:00 /usr/sbin/atd -b 15 -l 1
>    90 tty1     S      0:00 -bash
>    91 tty2     S      0:00 -bash
>    92 tty3     S      0:00 /sbin/agetty 38400 tty3 linux
>    93 tty4     S      0:00 /sbin/agetty 38400 tty4 linux
>    94 tty5     S      0:00 /sbin/agetty 38400 tty5 linux
>    95 tty6     S      0:00 /sbin/agetty 38400 tty6 linux
>   192 tty2     S      0:01 top
>   207 tty1     R      0:00 ps -ax
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
