Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291414AbSBSOIw>; Tue, 19 Feb 2002 09:08:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291418AbSBSOIn>; Tue, 19 Feb 2002 09:08:43 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:5344 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S291414AbSBSOId>; Tue, 19 Feb 2002 09:08:33 -0500
Message-ID: <4545776.1014127684480.JavaMail.nobody@web11.us.oracle.com>
Date: Tue, 19 Feb 2002 06:08:04 -0800 (GMT-08:00)
From: "ALESSANDRO.SUARDI" <ALESSANDRO.SUARDI@oracle.com>
To: hirofumi@mail.parknet.co.jp
Subject: Re: gnome-terminal acts funny in recent 2.5 series
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
x-priority: 3
x-mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> 
> Alessandro Suardi <alessandro.suardi@oracle.com> writes:
> 
>> Running Ximian-latest for rh72/i386, latest 2.5 kernels (including
>>   2.5.4-pre2, 2.5.4, 2.5.5-pre1).
>> 
>> Symptom:
>>    - clicking on the panel icon for gnome-terminal shows a flicker
>>       of the terminal window coming up then the window disappears.
>>      No leftover processes.

[snip]

> Probably, this problem had occurred in libzvt which gnome-terminal 
> is using.
> 
> libzvt was using file descriptor passing via UNIX domain socket for
> pseudo terminal. Then because ->passcred was not initialized in
> sock_alloc(), unexpected credential data was passing to libzvt.
> 
> The following patch fixed this problem, but I'm not sure.
> Could you review the patch? (attached file are test program)
> 
> --- socket.c.orig     Mon Feb 11 18:21:59 2002
> +++ socket.c     Tue Feb 19 16:20:18 2002
> @@ -501,6 +501,8 @@ struct socket *sock_alloc(void)
>      sock->ops = NULL;
>      sock->sk = NULL;
>      sock->file = NULL;
> +//     init_waitqueue_head(&sock->wait);     this is needed?
> +     sock->passcred = 0;
> 
>      sockets_in_use[smp_processor_id()].counter++;
>      return sock;

Success on first attempt - thanks. Of course since this wasn't
 fully reproducable I'll assume the patch fixes the bug, unless
 proven wrong.

Thanks again,

--alessandro
