Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293461AbSCEQoK>; Tue, 5 Mar 2002 11:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293464AbSCEQoD>; Tue, 5 Mar 2002 11:44:03 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:38028 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293459AbSCEQno>;
	Tue, 5 Mar 2002 11:43:44 -0500
Importance: Normal
Sensitivity: 
Subject: Re: Fwd: [Lse-tech] get_pid() performance fix
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF810580E6.8672B341-ON85256B73.005AF9B8@pok.ibm.com>
From: "Rajan Ravindran" <rajancr@us.ibm.com>
Date: Tue, 5 Mar 2002 11:43:24 -0500
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.9a |January 7, 2002) at
 03/05/2002 11:43:26 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Yes, pid's are guaranteed to be unique.
Here the problem we focused is the time taken in finding the next
available free pid.
I really don't mean by your task->xxx.

-Rajan



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

_______________________________________________
Lse-tech mailing list
Lse-tech@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/lse-tech




