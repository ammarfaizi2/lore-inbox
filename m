Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129640AbQK0Sbr>; Mon, 27 Nov 2000 13:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130781AbQK0Sbi>; Mon, 27 Nov 2000 13:31:38 -0500
Received: from mailb.telia.com ([194.22.194.6]:21253 "EHLO mailb.telia.com")
        by vger.kernel.org with ESMTP id <S130607AbQK0SbE>;
        Mon, 27 Nov 2000 13:31:04 -0500
From: Roger Larsson <roger.larsson@norran.net>
Date: Mon, 27 Nov 2000 18:58:03 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="US-ASCII"
To: Mastoras <mastoras@hack.gr>, rtl@rtlinux.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSF.4.21.0011270332160.9529-100000@papari.hack.gr>
In-Reply-To: <Pine.BSF.4.21.0011270332160.9529-100000@papari.hack.gr>
Subject: Re: RTlinux & Linux Question
MIME-Version: 1.0
Message-Id: <00112718580301.01110@dox>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 November 2000 02:36, Mastoras wrote:
> Hello,
>
>         I'm trying to use RTlinux to make a unix process wakeup
> periodicaly, in terms of "real time".

Have I understood correctly - you try to use a RTLinux process to get a
finer grained periodical wakeup than linux standard 10 ms?

>
> 1) the unix process uses 2 system calls, one to make it self periodic, and
> one to suspend its self until the next period.
>
> 2) The system call that makes the unix process periodic, creates a Rtlinux
> thread, which is periodic with the same period.
>
> 3) The periodic RT linux thread, sets a flag & sends fakes IRQ0 to linux,
> in order to force its scheduling as soon as possible and then suspends it
> self. (i know that this advances time, but this is not the question right
> now).
>
> 4) The unix process wakeups perfectely when there is no disk activity, but
> when there is some disk activity ("find /" and/or "updatedb") or the
> period is too small (300us) i noticed that sometimes it loses one or two
> periods. This is very rare, i mean 14 loses in 5000 executions at 5ms
> period.
>
> 5) The unix process isn't scheduled the appropriate time although that
> every IRQ is received by linux correctly, the myprocess->counter is
> initialized to a very high value (in each period) and
> current->need_resched is set to 1.
>

You have been hit by the kernel latency, see
http://www.gardena.net/benno/linux/audio

(There are patches)

> 6) I don't want to use PSC.

All attempts to guarantee wake up of a linux process within any
time frame will fail.
Applying a low latency kernel patch will help - good enough for many
applications, but no guarantees...

To get guarantees you need to do your stuff in a RTLinux thread.
(and why not, you are already using it?)


/RogerL

-- 
Home page:
  http://www.norran.net/nra02596/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
