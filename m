Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbTDBXlc>; Wed, 2 Apr 2003 18:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263216AbTDBXlc>; Wed, 2 Apr 2003 18:41:32 -0500
Received: from [12.47.58.55] ([12.47.58.55]:28432 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id <S263215AbTDBXlb>;
	Wed, 2 Apr 2003 18:41:31 -0500
Date: Wed, 2 Apr 2003 15:52:20 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.66-mm2] Fix page_convert_anon locking issues
Message-Id: <20030402155220.651a1005.akpm@digeo.com>
In-Reply-To: <110950000.1049326945@baldur.austin.ibm.com>
References: <8910000.1049303582@baldur.austin.ibm.com>
	<20030402132939.647c74a6.akpm@digeo.com>
	<80300000.1049320593@baldur.austin.ibm.com>
	<20030402150903.21765844.akpm@digeo.com>
	<102170000.1049325787@baldur.austin.ibm.com>
	<20030402153845.0770ef54.akpm@digeo.com>
	<110950000.1049326945@baldur.austin.ibm.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Apr 2003 23:52:53.0138 (UTC) FILETIME=[F9BE4720:01C2F972]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> wrote:
>
> 
> Oops.  The pmd_present() check should be after the page_to_pfn() !=
> pte_pfn() check.
> 

hmmmm.  It also probably needs both compiler barriers and memory barriers.

It does give me creepy feelings.  I worry that because nobody uses
remap_file_pages() yet, we will hit 2.6.25 before discovering that we have
fundamental VM locking problems which affect $major$ applications.


