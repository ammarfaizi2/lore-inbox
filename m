Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285129AbRLQNFK>; Mon, 17 Dec 2001 08:05:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285127AbRLQNFA>; Mon, 17 Dec 2001 08:05:00 -0500
Received: from [195.66.192.167] ([195.66.192.167]:57872 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S285129AbRLQNEt>; Mon, 17 Dec 2001 08:04:49 -0500
Content-Type: text/plain;
  charset="PT 154"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Dmitry Volkoff <vdb@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: Unfreeable buffer/cache problem in 2.4.17-rc1 still there
Date: Mon, 17 Dec 2001 15:01:12 -0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20011216223909.A230@localhost>
In-Reply-To: <20011216223909.A230@localhost>
MIME-Version: 1.0
Message-Id: <01121715011208.02146@manta>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 December 2001 17:39, Dmitry Volkoff wrote:
> Hello!
>
> Below is simple test case which I think is related to "memory disappear"
> problem.
>
> My real program is doing something like this:
>
> // test.c
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <stdio.h>
> #include <unistd.h>
>
> int main(void)
> {
>   int fd;
>   int r;
>   char data[10] = "0123456789";
>   int i;
>   int end = 30;
>   for (i=0;i<end;i++) {
>     fd = open("testfile", O_WRONLY | O_NDELAY | O_TRUNC | O_CREAT, 0644);
>     if (fd == -1) {
>       printf("unable to open\n");
>       return;
>     }
>     r = write(fd,data,sizeof data);
>     if (r == -1) {
>       printf("unable to write\n");
>       close(fd);
>       return;
>     }
>     close(fd);
>     sleep(1);
>   }
> }
> // end test.c

I removed sleep(1). Is it needed?

After 10000+ runs of this proggy swap usage isn't changed on 2.4.17-pre7.
top reports constant 2304K of swap usage.
--
vda
