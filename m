Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263553AbTDCTsm 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263554AbTDCTsm 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:48:42 -0500
Received: from [12.47.58.55] ([12.47.58.55]:49275 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263553AbTDCTsf 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 14:48:35 -0500
Date: Thu, 3 Apr 2003 12:00:39 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.66-mm2] Fix page_convert_anon locking issues
Message-Id: <20030403120039.5c95813c.akpm@digeo.com>
In-Reply-To: <92070000.1049381395@[10.1.1.5]>
References: <8910000.1049303582@baldur.austin.ibm.com>
	<20030402132939.647c74a6.akpm@digeo.com>
	<80300000.1049320593@baldur.austin.ibm.com>
	<20030402150903.21765844.akpm@digeo.com>
	<102170000.1049325787@baldur.austin.ibm.com>
	<20030402153845.0770ef54.akpm@digeo.com>
	<110950000.1049326945@baldur.austin.ibm.com>
	<20030402155220.651a1005.akpm@digeo.com>
	<116640000.1049327888@baldur.austin.ibm.com>
	<92070000.1049381395@[10.1.1.5]>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Apr 2003 19:59:55.0081 (UTC) FILETIME=[9895CB90:01C2FA1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> wrote:
>
> 
> --On Wednesday, April 02, 2003 17:58:08 -0600 Dave McCracken
> <dmccr@us.ibm.com> wrote:
> 
> > It's looking more and more like we should use your other suggestion.  It's
> > definitely simpler if we can make it failsafe.  I'll code it up tomorrow.
> 
> I thought of a big hole in the simpler scheme you suggested.  It occurred
> to me that try_to_unmap will fail.  It will see the PageAnon flag so it'll
> just walk the pte_chain and assume it doesn't have to walk the vmas.  This
> will leave the page with some stranded mappings.  Actually
> page_convert_anon will then finish, and we'll have a page where
> try_to_unmap claims it has succeeded but still has mappings.
> 

Lock the page, and page reclaim will not go near it.  It needs to be locked
across page_convert_anon() anyway, to protect ->mapping.

