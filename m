Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269948AbUJNDY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269948AbUJNDY4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 23:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269950AbUJNDYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 23:24:55 -0400
Received: from virt10p.secure-wi.com ([209.216.203.97]:44203 "EHLO
	virt10p.secure-wi.com") by vger.kernel.org with ESMTP
	id S269948AbUJNDYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 23:24:45 -0400
Message-ID: <004f01c4b8a1$9ee2b6c0$41c8a8c0@Eshwar>
From: "eshwar" <eshwar@moschip.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Raj" <inguva@gmail.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <005101c4b763$5e3cba60$41c8a8c0@Eshwar> <b2fa632f0410122315753f8886@mail.gmail.com> <001401c4b796$abcddfb0$41c8a8c0@Eshwar> <1097663878.4440.0.camel@localhost.localdomain>
Subject: Re: Write USB Device Driver entry not called
Date: Sat, 23 Oct 2004 07:12:56 +0530
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

I agree but the return value from the vfs_write should not be the -EBADF
(Bad File descriptor) it might be -EACCES (premission denied)... Correct me
if I am wrong...

this can be code in fs/read_write.c vfs_write()

 if (!(file->f_mode & FMODE_WRITE))
  return -EACCES;

Eshwar

----- Original Message -----
From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
To: "eshwar" <eshwar@moschip.com>
Cc: "Raj" <inguva@gmail.com>; "Linux Kernel Mailing List"
<linux-kernel@vger.kernel.org>
Sent: Wednesday, October 13, 2004 4:07 PM
Subject: Re: Write USB Device Driver entry not called


> On Iau, 2004-10-21 at 18:52, eshwar wrote:
> > Open is sucessfull.... I don't think the problem the flags of open
>
> I do. See any book on C/Unix style file opening. For an existing file
> you want
> open("foo", O_flags)
>
> for a new file possibly
>
> open("foo", O_CREAT|o_flags, S_Iblah)
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

