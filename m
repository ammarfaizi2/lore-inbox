Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQKKCp4>; Fri, 10 Nov 2000 21:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129097AbQKKCpr>; Fri, 10 Nov 2000 21:45:47 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:14249 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129226AbQKKCph>; Fri, 10 Nov 2000 21:45:37 -0500
Message-ID: <3A0CB2D8.EA3E3DA4@uow.edu.au>
Date: Sat, 11 Nov 2000 13:45:44 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Wild thangs, was: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue
In-Reply-To: <20001110095227.A15010@sendmail.com> <3A0C37FF.23D7B69@timpanogas.org> <20001110101138.A15087@sendmail.com> <3A0C3F30.F5EB076E@timpanogas.org> <20001110133431.A16169@sendmail.com> <3A0C6B7C.110902B4@timpanogas.org> <3A0C6E01.EFA10590@timpanogas.org> <3A0C929B.EE6F7137@linux.com> <3A0C9277.273FA907@timpanogas.org> <3A0C96FD.8441F995@linux.com>,
		<3A0C96FD.8441F995@linux.com>; from david@linux.com on Fri, Nov 10, 2000 at 04:46:53PM -0800 <20001110202527.A3342@vger.timpanogas.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jeff V. Merkey" wrote:
> 
> They're not modprobes, they're misnamed processes sleeping from NWFS.
> I got the fix from someone so now they display their proper names.
> top displays the names correctly, ps does not.  Several people have
> verified this problem, and all you are saying is that your servers
> are never heavily loaded for long periods of time, say 200 hours
> at a stretch of consatnt ftp traffic?

Kernel threads?  Do this:

     strcpy(current->comm, "threadname");			/* 16 char array!! */
     current->mm->arg_start = current->mm->arg_end = 0;		/* black magic */

and `ps' should be happy.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
