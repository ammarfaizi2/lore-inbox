Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272072AbRH2Ur4>; Wed, 29 Aug 2001 16:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272066AbRH2Urq>; Wed, 29 Aug 2001 16:47:46 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:26638 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S272070AbRH2Urc>; Wed, 29 Aug 2001 16:47:32 -0400
Message-ID: <3B8D54F3.46DC2ABB@zip.com.au>
Date: Wed, 29 Aug 2001 13:47:47 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Rees <dbr@greenhydrant.com>
CC: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com
Subject: Re: kupdated, bdflush and kjournald stuck in D state on RAID1 device 
 (deadlock?)
In-Reply-To: <20010829131720.A20537@greenhydrant.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Rees wrote:
> 
> ...
> USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
> root         1  0.0  0.0  1368   72 ?        S    Aug27   0:05 init [3]
> root         2  0.0  0.0     0    0 ?        SW   Aug27   0:00 [keventd]
> root         3  0.0  0.0     0    0 ?        SWN  Aug27   0:00 [ksoftirqd_CPU0]
> root         4  0.0  0.0     0    0 ?        SW   Aug27   0:03 [kswapd]
> root         5  0.0  0.0     0    0 ?        SW   Aug27   0:00 [kreclaimd]
> root         6  0.0  0.0     0    0 ?        DW   Aug27   0:00 [bdflush]
> root         7  0.0  0.0     0    0 ?        DW   Aug27   0:00 [kupdated]
> root         9  0.0  0.0     0    0 ?        SW<  Aug27   0:00 [mdrecoveryd]
> root        10  0.0  0.0     0    0 ?        SW<  Aug27   0:00 [raid1d]
> root        11  0.0  0.0     0    0 ?        SW   Aug27   0:02 [kjournald]
> root       130  0.0  0.0     0    0 ?        SW   Aug27   0:00 [kjournald]
> root       131  0.0  0.0     0    0 ?        DW   Aug27   0:01 [kjournald]
> root       374  0.0  0.0  1428  176 ?        S    Aug27   0:00 syslogd -m 0
> root       379  0.0  0.0  1984  396 ?        S    Aug27   0:00 klogd -2
> [sybase@zorro ~]$
> 
> As you can see, bdflush, kupdated and kjournald appear to be deadlocked.
> 

Certainly seems that way.

Can you please send the output of

	ps xwo pid,command,wchan

Also, try a SYSRQ-T and, if the result makes it into the
logs, please pass it through `ksymoops -m System.map'.

Thanks.

-
