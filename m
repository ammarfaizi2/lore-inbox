Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318939AbSIITVR>; Mon, 9 Sep 2002 15:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318938AbSIITVR>; Mon, 9 Sep 2002 15:21:17 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:21465 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S318937AbSIITVP>; Mon, 9 Sep 2002 15:21:15 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: "'Andrew Morton'" <akpm@digeo.com>,
       "'Daniel Phillips'" <phillips@arcor.de>
Cc: <root@chaos.analogic.com>, "'David S. Miller'" <davem@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Calculating kernel logical address ..
Date: Mon, 9 Sep 2002 12:23:20 -0700
Message-ID: <01a901c25836$5c1d2f50$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3D7CF322.98045305@digeo.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Andrew Morton
Sent: Monday, September 09, 2002 12:15 PM
To: Daniel Phillips
Cc: imran.badr@cavium.com; root@chaos.analogic.com; 'David S. Miller';
linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..


Daniel Phillips wrote:
>
> ...
> > down(&current->mm->mmap_sem) would help.
>
> Not for anon pages, and how do you know whether it's anon or not before
> looking at the page, which may be free by the time you look at it?
> In other words, mm->page_table_lock is the one, because it's required
> for unmapping a pte, and any mapped page will be forced to hold a count
> increment until it gets past that lock.  Without this lock, the results
> of pte_page are unstable.

>The caller of get_user_pages() needs to hold mmap_sem for reading
>to prevent the vmas from going away.  get_user_pages() does the
>right thing wrt page_table_lock.  (As a quick peek at the code
>would reveal...)
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/


So, I am hearing the get_user_pages is the right choice for me. BTW, did
anybody take a look at the code snippet that posted earlier? That code
mmap's kmalloc'ed memory to process space and then in the ioctl call, I
calculate kernel logical address.
Please have a look and advise any portability issue.

Thanks,
Imran.


