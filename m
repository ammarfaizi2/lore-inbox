Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293411AbSCEQ1U>; Tue, 5 Mar 2002 11:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293422AbSCEQ1K>; Tue, 5 Mar 2002 11:27:10 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:6916 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S293411AbSCEQ0y>; Tue, 5 Mar 2002 11:26:54 -0500
To: frankeh@watson.ibm.com
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: Fwd: [Lse-tech] get_pid() performance fix
In-Reply-To: <20020305145004.BFA503FE06@smtp.linux.ibm.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 06 Mar 2002 01:26:20 +0900
In-Reply-To: <20020305145004.BFA503FE06@smtp.linux.ibm.com>
Message-ID: <87bse39e1f.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubertus Franke <frankeh@watson.ibm.com> writes:

> @@ -153,13 +155,18 @@
>                               if(last_pid & 0xffff8000)
>                                     last_pid = 300;
>                               next_safe = PID_MAX;
> +                             goto repeat;
>                         }
> -                       goto repeat;
> +                       if(unlikely(last_pid == beginpid))
> +                             goto nomorepids;
> +                       continue;

It isn't guaranteed that pid is unique.

In the case:
	task->pid = 300, task->xxx = 301
	pid 301 is free

	This get_pid() returns 301.

Regards.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
