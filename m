Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271278AbRIRNYG>; Tue, 18 Sep 2001 09:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271333AbRIRNX5>; Tue, 18 Sep 2001 09:23:57 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:39934 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S271246AbRIRNXm>; Tue, 18 Sep 2001 09:23:42 -0400
Importance: Normal
Subject: Re: Deadlock on the mm->mmap_sem
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF9C225A25.EEAFFE81-ONC1256ACB.0048279B@de.ibm.com>
From: "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>
Date: Tue, 18 Sep 2001 15:22:54 +0200
X-MIMETrack: Serialize by Router on D12ML028/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 18/09/2001 15:22:54
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

>+   if (retval > count) BUG();
>+   if (copy_to_user(buf, kbuf, retval)) {
>+        retval = -EFAULT;
>+   } else {
>+        *ppos = (lineno << MAPS_LINE_SHIFT) + loff;
>    }
>    up_read(&mm->mmap_sem);

The copy_to_user is still done with the lock held ...  I guess you just
forgot to move the up_read() up before the copy_to_user(), right?


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com

