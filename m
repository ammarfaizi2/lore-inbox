Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269957AbUJNEK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269957AbUJNEK5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 00:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269960AbUJNEK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 00:10:57 -0400
Received: from virt10p.secure-wi.com ([209.216.203.97]:30897 "EHLO
	virt10p.secure-wi.com") by vger.kernel.org with ESMTP
	id S269957AbUJNEKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 00:10:52 -0400
Message-ID: <011c01c4b721$b7fd96b0$41c8a8c0@Eshwar>
From: "eshwar" <eshwar@moschip.com>
To: "Raj" <inguva@gmail.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <005101c4b763$5e3cba60$41c8a8c0@Eshwar> <b2fa632f0410122315753f8886@mail.gmail.com> <001401c4b796$abcddfb0$41c8a8c0@Eshwar> <1097663878.4440.0.camel@localhost.localdomain> <004f01c4b8a1$9ee2b6c0$41c8a8c0@Eshwar> <b2fa632f041013203968418d9f@mail.gmail.com>
Subject: Re: Write USB Device Driver entry not called
Date: Thu, 21 Oct 2004 09:24:52 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if I modify the code like this

char abc;
                 if(read(fd,&abc,1) < 0)
                         perror("read to bar failed: ");
                 close(fd);

Which will be sucess... This intern states that my file descriptor is right
.... but write returns EBADF... both are contradicting statements....

Eshwar

----- Original Message -----
From: "Raj" <inguva@gmail.com>
To: "eshwar" <eshwar@moschip.com>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>; "Linux Kernel Mailing List"
<linux-kernel@vger.kernel.org>
Sent: Thursday, October 14, 2004 9:09 AM
Subject: Re: Write USB Device Driver entry not called


> On Sat, 23 Oct 2004 07:12:56 +0530, eshwar <eshwar@moschip.com> wrote:
> > I agree but the return value from the vfs_write should not be the -EBADF
> > (Bad File descriptor) it might be -EACCES (premission denied)... Correct
me
> > if I am wrong...
> >
> > this can be code in fs/read_write.c vfs_write()
> >
> >  if (!(file->f_mode & FMODE_WRITE))
> >   return -EACCES;
>
> Wrong. You are confused between file perms & mode of access to files.
> If you cannot open a file due to insufficient perms, then EACCESS is
> what you get.
> If you opened a file for reading, but you tried to write, the you get a
EBADF.
>
> Run the following code, after you create two files, 'foo' ( perms 0400
> ) and 'bar' ( 0700 ).
>
> #include <fcntl.h>
>
> int main()
> {
>         int fd;
>
>         fd = open("foo",O_WRONLY);
>
>         if(fd < 0)
>                 perror("Opening foo:");
>         else
>                 close (fd);
>
>         fd = open("bar",O_RDONLY);
>
>         if(fd < 0)
>                 perror("Opening bar: ");
>         else {
>                 if(write(fd,'a',1) < 0)
>                         perror("Write to bar failed: ");
>                 close(fd);
>         }
>
> }
>
> Output would be:
> Opening foo:: Permission denied
> Write to bar failed: : Bad file descriptor
> --
> ######
> raj
> ######
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

