Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263353AbTENRnB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 13:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTENRnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 13:43:01 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:57190 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263353AbTENRnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 13:43:00 -0400
Date: Wed, 14 May 2003 10:57:06 -0700
From: Andrew Morton <akpm@digeo.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-Id: <20030514105706.628fba15.akpm@digeo.com>
In-Reply-To: <82240000.1052934152@baldur.austin.ibm.com>
References: <154080000.1052858685@baldur.austin.ibm.com>
	<3EC15C6D.1040403@kolumbus.fi>
	<199610000.1052864784@baldur.austin.ibm.com>
	<20030513181018.4cbff906.akpm@digeo.com>
	<18240000.1052924530@baldur.austin.ibm.com>
	<20030514103421.197f177a.akpm@digeo.com>
	<82240000.1052934152@baldur.austin.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 17:55:43.0697 (UTC) FILETIME=[0A269410:01C31A42]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> wrote:
>
> task 1 waits for IO in the page fault.
> 
>  task 2 calls truncate, which does zap_page_range() on the range that page
>  is in.
> 
>  task 1 wakes up and maps the page.
> 
>  task 2 calls truncate_inode_pages which removes the newly mapped page from
>  the page cache.
> 
>  Now the state is that the page has been disconnected from the file, but
>  it's still mapped in task 1's address space.  That task thinks it has valid
>  data from the file in that page, and may continue to read/write there, and
>  assume any changes will get written back..

yes.  It's a very complex way of allocating anonymous memory.

I am told that Stephen, Linus and others discussed this at length at KS a
couple of years ago and the upshot was that the application is racy anyway
and there's nothing wrong with it.

Hugh calls these "Morton pages" but it wasn't me and nobody saw me do it.

It would be nice to make them go away - they cause problems.
