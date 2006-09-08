Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWIHVDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWIHVDe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 17:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWIHVDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 17:03:34 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:42998 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751253AbWIHVDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 17:03:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CKV8YXI0qivTyfmCTXBhNA9O2A6iOh7ohRKGQaamh/+M2vbnaea2NB+OBrNo0tukjAt/4Lu35wYITFz3B0kLyIVhlzlcpGMmadKtQ8lZixB7yMeD7VVGaGHHbsMaT06CZptICVh34fCt9IetYUNNVUsrx4OaUBt94zPOVI2NUYY=
Message-ID: <1b270aae0609081403u11b76ae9v72ad933475a2319f@mail.gmail.com>
Date: Fri, 8 Sep 2006 23:03:31 +0200
From: "Metathronius Galabant" <m.galabant@googlemail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: top displaying 50% si time and 50% idle on idle machine
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060907175323.57a5c6b0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1b270aae0609071108h22bc10b0v5d2227abfc66c53c@mail.gmail.com>
	 <20060907175323.57a5c6b0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Kernel 2.6.17.11 with tg3 network driver, NAPI enabled (Distro CentOS 4.4).
>> top shows strangely 50% idle even if the machine is _completely_ idle.
>>
>> top - 01:04:30 up 4 days, 12:05,  2 users,  load average: 0.00, 0.00, 0.00
>> Tasks:  34 total,   2 running,  32 sleeping,   0 stopped,   0 zombie
>> Cpu(s):  0.0% us,  0.0% sy,  0.0% ni, 50.0% id,  0.0% wa,  0.0% hi, 50.0%si

> Do `ps aux', look for a process stuck in D state.

The issue that startled me: there is _NO_ process in a D state!
BTW what means si? (interrupt service time? google didn't find anything)

ps auxwm output following:

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.0  1692  572 ?        -    Sep04   0:00 init [3]

root         -  0.0    -     -    - -        Ss   Sep04   0:00 -
root         2  0.0  0.0     0    0 ?        -    Sep04   0:00 [ksoftirqd/0]
root         -  0.0    -     -    - -        SN   Sep04   0:00 -
root         3  0.0  0.0     0    0 ?        -    Sep04   0:00 [events/0]
root         -  0.0    -     -    - -        S<   Sep04   0:00 -
root         4  0.0  0.0     0    0 ?        -    Sep04   0:00 [khelper]
root         -  0.0    -     -    - -        S<   Sep04   0:00 -
root         5  0.0  0.0     0    0 ?        -    Sep04   0:00 [kthread]
root         -  0.0    -     -    - -        S<   Sep04   0:00 -
root         7  0.0  0.0     0    0 ?        -    Sep04   0:00 [kblockd/0]
root         -  0.0    -     -    - -        S<   Sep04   0:00 -
root         8  0.0  0.0     0    0 ?        -    Sep04   0:00 [kseriod]
root         -  0.0    -     -    - -        S<   Sep04   0:00 -
root        70  0.0  0.0     0    0 ?        -    Sep04   0:00 [pdflush]
root         -  0.0    -     -    - -        S    Sep04   0:00 -
root        71  0.0  0.0     0    0 ?        -    Sep04   0:00 [pdflush]
root         -  0.0    -     -    - -        S    Sep04   0:00 -
root        72  0.0  0.0     0    0 ?        -    Sep04   0:00 [kswapd0]
root         -  0.0    -     -    - -        S    Sep04   0:00 -
root        73  0.0  0.0     0    0 ?        -    Sep04   0:00 [aio/0]
root         -  0.0    -     -    - -        S<   Sep04   0:00 -
root       672  0.0  0.0     0    0 ?        -    Sep04   0:00 [kpsmoused]
root         -  0.0    -     -    - -        S<   Sep04   0:00 -
root       685  0.0  0.0     0    0 ?        -    Sep04   0:00 [kjournald]
root         -  0.0    -     -    - -        S<   Sep04   0:00 -
root      1666  0.0  0.0  1588  464 ?        -    Sep04   0:00 udevd
root         -  0.0    -     -    - -        S<s  Sep04   0:00 -
root      2065  0.0  0.0     0    0 ?        -    Sep04   0:00 [kjournald]
root         -  0.0    -     -    - -        S<   Sep04   0:00 -
root      2073  0.0  0.0     0    0 ?        -    Sep04   0:00 [kjournald]
root         -  0.0    -     -    - -        S<   Sep04   0:00 -
root      2763  0.0  0.0  2484  928 ?        -    Sep04   0:00 crond
root         -  0.0    -     -    - -        Ss   Sep04   0:00 -
root      2779  0.0  0.0  1532  408 tty2     -    Sep04   0:00
/sbin/mingetty tty2
root         -  0.0    -     -    - -        Ss+  Sep04   0:00 -
root      2780  0.0  0.0  1536  416 tty3     -    Sep04   0:00
/sbin/mingetty tty3
root         -  0.0    -     -    - -        Ss+  Sep04   0:00 -
root      4495  0.0  0.0  2904 1236 ?        -    Sep04   0:00 login -- root
root         -  0.0    -     -    - -        Ss   Sep04   0:00 -
root      6582  0.0  0.0     0    0 ?        -    Sep04   0:00 [reiserfs/0]
root         -  0.0    -     -    - -        S<   Sep04   0:00 -
root      7406  0.0  0.0  2344 1380 tty1     -    Sep06   0:00 -bash
root         -  0.0    -     -    - -        Ss+  Sep06   0:00 -
root      8158  0.0  0.0  4076 1132 ?        -    Sep06   0:01 /usr/sbin/sshd
root         -  0.0    -     -    - -        Ss   Sep06   0:01 -
root     10342  0.0  0.0  2244  608 ?        -    Sep08   0:03 syslogd -m 0
root         -  0.0    -     -    - -        Ss   Sep08   0:03 -
root     10347  0.0  0.0  1672  384 ?        -    Sep08   0:00 klogd -x
root         -  0.0    -     -    - -        Ss   Sep08   0:00 -
root     16078  0.0  0.0  8040 2240 ?        -    Sep10   0:00 sshd: root@pts/0
root         -  0.0    -     -    - -        Ss   Sep10   0:00 -
root     16089  0.0  0.0  2516 1256 pts/0    -    Sep10   0:00 -bash
root         -  0.0    -     -    - -        Ss   Sep10   0:00 -
nscd     24962  0.0  0.0 106476 840 ?        -    03:43   0:00 /usr/sbin/nscd
nscd         -  0.0    -     -    - -        Ssl  03:43   0:00 -
nscd         -  0.0    -     -    - -        Ssl  03:43   0:00 -
nscd         -  0.0    -     -    - -        Ssl  03:43   0:00 -
nscd         -  0.0    -     -    - -        Ssl  03:43   0:00 -
nscd         -  0.0    -     -    - -        Ssl  03:43   0:00 -
nscd         -  0.0    -     -    - -        Ssl  03:43   0:00 -
nscd         -  0.0    -     -    - -        Ssl  03:43   0:00 -
root     24972  0.0  0.0  2548  724 pts/0    -    03:44   0:00 ps auxwm
root         -  0.0    -     -    - -        R+   03:44   0:00 -

>         echo t > /proc/sysrq-trigger
>         dmesg -s 1000000 > foo
>
> then edit foo, search for the process in D state (look for " D ") and send
> that process's backtrace record.

This does only make sense if I have found the offender? I tried it,
nothing unusual and almost no output.

Is there any way to track it down? Just hints in the right direction
are highly appreciated!
Thanks,
M.
