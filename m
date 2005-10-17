Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVJQDyP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVJQDyP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 23:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVJQDyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 23:54:15 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:61982 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932109AbVJQDyO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 23:54:14 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       linux-kernel@vger.kernel.org, khali@linux-fr.org,
       Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: VFS: file-max limit 50044 reached
X-Message-Flag: Warning: May contain useful information
References: <87fyr2ape5.fsf@foo.vault.bofh.ru>
	<87slv23bw5.fsf@foo.vault.bofh.ru> <20051016162306.GA10410@in.ibm.com>
	<Pine.LNX.4.64.0510161919450.23590@g5.osdl.org>
From: Roland Dreier <rolandd@cisco.com>
Date: Sun, 16 Oct 2005 20:54:03 -0700
In-Reply-To: <Pine.LNX.4.64.0510161919450.23590@g5.osdl.org> (Linus
 Torvalds's message of "Sun, 16 Oct 2005 19:34:24 -0700 (PDT)")
Message-ID: <52ach8ssro.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 17 Oct 2005 03:54:04.0770 (UTC) FILETIME=[6ADA1420:01C5D2CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > --- a/fs/file_table.c
    > +++ b/fs/file_table.c
    > @@ -39,21 +39,9 @@ void filp_ctor(void * objp, struct kmem_
    >  {
    >  	if ((cflags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
    >  	    SLAB_CTOR_CONSTRUCTOR) {
    > -		unsigned long flags;
    > -		spin_lock_irqsave(&filp_count_lock, flags);
    > -		files_stat.nr_files++;
    > -		spin_unlock_irqrestore(&filp_count_lock, flags);
    >  	}
    >  }

Am I missing something?  Why not delete the whole filp_ctor() function
rather than just the then clause of the if()?

 - R.
