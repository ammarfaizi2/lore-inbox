Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130998AbQLHGrw>; Fri, 8 Dec 2000 01:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131880AbQLHGrn>; Fri, 8 Dec 2000 01:47:43 -0500
Received: from mail.blackdown.de ([62.159.133.162]:55556 "EHLO
	zaphod.blackdown.de") by vger.kernel.org with ESMTP
	id <S130998AbQLHGrb>; Fri, 8 Dec 2000 01:47:31 -0500
To: Frank de Lange <frank@unternet.org>
Cc: drepper@redhat.com, java-linux@java.blackdown.org,
        linux-kernel@vger.kernel.org
Subject: Re: java (and possibly other threaded apps) hanging in rt_sigsuspend
In-Reply-To: <20001207164251.A3239@unternet.org>
From: Juergen Kreileder <jk@blackdown.de>
Date: 08 Dec 2000 07:16:06 +0100
In-Reply-To: Frank de Lange's message of "Thu, 7 Dec 2000 16:42:51 +0100"
Message-ID: <878zpr1lqx.fsf@zaphod.blackdown.de>
Organization: "Blackdown Java-Linux Team"
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Frank" == Frank de Lange <frank@unternet.org> writes:

    Frank> I saw your remarks on the kernel mailing list
    Frank> wrt. 'threaded processes get stuck in
    Frank> rt_sigsuspend/fillonedir/exit_notify' dd. 20000911-12, and
    Frank> thought you might be interested in the fact that something
    Frank> quite like this also happens on 2.4.0-test11 with glibc-2.2
    Frank> (release), BUT NOT ALWAYS...

    Frank> I can reliably hang java (Blackdown port jdk1.3, FCS) using
    Frank> the -Xmx parameter (which specifies a maximum heap size),
    Frank> the weird thing is that it does NOT hang which this
    Frank> parameter is either not specified OR specified but larger
    Frank> than a certain value. When it hangs, it always is stuck in
    Frank> a rt_sigsuspend call just after a clone() call. An example:

    Frank>  [frank@behemoth frank]$ java
    Frank>         (java starts and spits out some info, then exits as
    Frank>         it should)

    Frank>  [frank@behemoth frank]$ java -Xmx32m
    Frank>         (java ALWAYS gets stuck:

    Frank> 	pipe([6, 7])                            = 0
    Frank> 	clone()                                 = 14732
    Frank> 	[pid 14679] write(7, "\0\0\0\0\5\0\0\0~\266\2@ $T@\0 T@\0 T@\300\265\2@\0\0\0"..., 148) = 148
    Frank> 	[pid 14679] rt_sigprocmask(SIG_SETMASK, NULL, [RT_0], 8) = 0
    Frank> 	[pid 14679] write(7, "`S\3@\0\0\0\0\20\321\377\277pD\37@\30&\5\10\0\0\0\200\0"..., 148) = 148
    Frank> 	[pid 14679] rt_sigprocmask(SIG_SETMASK, NULL, [RT_0], 8) = 0
    Frank> 	[pid 14679] rt_sigsuspend([]
    Frank> 	)

Can you reproduce this without strace?

I only see this problem when I run with 'strace -f' and java wants to
exit (apart from that java works correctly).  I don't see the dependency
on the heap size here.


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://www.blackdown.org/java-linux.html
JVM'01: http://www.usenix.org/events/jvm01/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
