Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277404AbRJJUWG>; Wed, 10 Oct 2001 16:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277401AbRJJUVq>; Wed, 10 Oct 2001 16:21:46 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:3254 "EHLO
	shookay.e-steel.com") by vger.kernel.org with ESMTP
	id <S277399AbRJJUVk>; Wed, 10 Oct 2001 16:21:40 -0400
To: storri@ameritech.net (Stephen Torri),
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Memory free report error (kernel-2.4.10-ac10)
In-Reply-To: <Pine.LNX.4.33.0110101605120.733-100000@base.torri.linux>
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
Date: 10 Oct 2001 16:22:09 -0400
In-Reply-To: <Pine.LNX.4.33.0110101605120.733-100000@base.torri.linux>
Message-ID: <xlt1ykbtfda.fsf@shookay.e-steel.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Which is the way unix works... Free memory is useless: better use it as
cache or else...

storri@ameritech.net (Stephen Torri) writes:
> I have installed and used kernel-2.4.10-ac10 on a SMP system (Dual P3)
> using 768 MB Ram. Yet on startup of the system (RedHat 7.0), the system
> resources are almost all used. Here are the files started:
> 
> USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
> root         1  1.1  0.0  1304  528 ?        S    15:56   0:06 init [3]
> root         2  0.0  0.0     0    0 ?        SW   15:56   0:00 [keventd]
> root         3  0.0  0.0     0    0 ?        SWN  15:56   0:00 [ksoftirqd_CPU0]
> root         4  0.0  0.0     0    0 ?        SWN  15:56   0:00 [ksoftirqd_CPU1]
> root         5  0.0  0.0     0    0 ?        SW   15:56   0:00 [kswapd]
> root         6  0.0  0.0     0    0 ?        SW   15:56   0:00 [kreclaimd]
> root         7  0.0  0.0     0    0 ?        SW   15:56   0:00 [bdflush]
> root         8  0.2  0.0     0    0 ?        SW   15:56   0:01 [kupdated]
> root         9  0.0  0.0     0    0 ?        SW   15:56   0:00 [khubd]
> root       341  0.0  0.0  1364  596 ?        S    16:03   0:00 syslogd -m 0
> root       351  0.1  0.1  2004 1176 ?        S    16:03   0:00 klogd
> nobody     405  0.0  0.0  7596  708 ?        S    16:03   0:00 identd -e -o
> nobody     407  0.0  0.0  7596  708 ?        S    16:03   0:00 identd -e -o
> nobody     408  0.0  0.0  7596  708 ?        S    16:03   0:00 identd -e -o
> nobody     409  0.0  0.0  7596  708 ?        S    16:03   0:00 identd -e -o
> nobody     410  0.0  0.0  7596  708 ?        S    16:03   0:00 identd -e -o
> daemon     424  0.0  0.0  1336  576 ?        S    16:03   0:00 /usr/sbin/atd
> root       455  0.0  0.1  2192  992 ?        S    16:03   0:00 xinetd -stayalive
> root       473  0.0  0.2  1904 1896 ?        SL   16:03   0:00 ntpd
> root       524  0.0  0.2  3224 1552 ?        S    16:03   0:00 sendmail: accepti
> root       540  0.0  0.0  1328  492 ?        S    16:03   0:00 gpm -t ps/2
> root       555  0.0  0.0  1532  708 ?        S    16:03   0:00 crond
> xfs        594  0.1  0.4  4404 3176 ?        S    16:03   0:00 xfs -droppriv -da
> root       630  0.0  0.0  1276  432 tty2     S    16:04   0:00 /sbin/mingetty tt
> root       631  0.0  0.0  1276  432 tty3     S    16:04   0:00 /sbin/mingetty tt
> root       632  0.0  0.0  1276  432 tty4     S    16:04   0:00 /sbin/mingetty tt
> root       633  0.0  0.0  1276  432 tty5     S    16:04   0:00 /sbin/mingetty tt
> root       634  0.0  0.0  1276  432 tty6     S    16:04   0:00 /sbin/mingetty tt
> root       677  0.1  0.1  2264 1204 tty1     S    16:04   0:00 login -- torri
> torri      678  0.0  0.1  2436 1416 tty1     S    16:04   0:00 -bash
> torri      700  0.0  0.1  2048 1080 ?        S    16:04   0:00 /usr/bin/fetchmai
> torri      733  0.1  0.3  6588 2640 tty1     T    16:05   0:00 pine
> torri      734  0.0  0.0  2528  732 tty1     R    16:06   0:00 ps aux
> 
> Here is the report of the memory (free -m):
>              total       used       free     shared    buffers     cached
> Mem:           751        662         89          0        564         18
> -/+ buffers/cache:         78        672
> Swap:          133          0        133
> 
> Here is the version I am using (/proc/version):
> 
> Linux version 2.4.10-ac10 (root@base.torri.linux) (gcc version 3.0.2
> 20010908 (prerelease)) #2 SMP Wed Oct 10 14:16:51 EDT 2001
> 
> I have never run across this problem. I don't know where to begin or what
> information is required to help debug this. Advise would be helpful.
> 
> Stephen Torri
> storri@ameritech.net
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Mathieu Chouquet-Stringer              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
