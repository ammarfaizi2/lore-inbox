Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTENA4Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 20:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTENA4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 20:56:25 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:34067 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S261797AbTENA4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 20:56:23 -0400
Date: Tue, 13 May 2003 18:10:22 -0700
From: Andrew Morton <akpm@digeo.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: wli@holomorphy.com, mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-Id: <20030513181022.6dbc5418.akpm@digeo.com>
In-Reply-To: <220550000.1052866808@baldur.austin.ibm.com>
References: <154080000.1052858685@baldur.austin.ibm.com>
	<3EC15C6D.1040403@kolumbus.fi>
	<199610000.1052864784@baldur.austin.ibm.com>
	<20030513224929.GX8978@holomorphy.com>
	<220550000.1052866808@baldur.austin.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 01:09:06.0715 (UTC) FILETIME=[6ABE7EB0:01C319B5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> wrote:
>
> Actually it does fix it.  I added code in vmtruncate_list() to do a
>  down_write(&vma->vm_mm->mmap_sem) around the zap_page_range(), and the
>  problem went away.  It serializes against any outstanding page faults on a
>  particular page table.  New faults will see that the page is no longer in
>  the file and fail with SIGBUS.  Andrew's test case stopped failing.
> 
>  I've attached the patch so you can see what I did.
> 
>  Can anyone think of any gotchas to this solution?

mmap_sem nests outside i_shared_sem.
