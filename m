Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbTENRUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 13:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbTENRUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 13:20:16 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:65376 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263273AbTENRUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 13:20:15 -0400
Date: Wed, 14 May 2003 10:34:21 -0700
From: Andrew Morton <akpm@digeo.com>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: mika.penttila@kolumbus.fi, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: Race between vmtruncate and mapped areas?
Message-Id: <20030514103421.197f177a.akpm@digeo.com>
In-Reply-To: <18240000.1052924530@baldur.austin.ibm.com>
References: <154080000.1052858685@baldur.austin.ibm.com>
	<3EC15C6D.1040403@kolumbus.fi>
	<199610000.1052864784@baldur.austin.ibm.com>
	<20030513181018.4cbff906.akpm@digeo.com>
	<18240000.1052924530@baldur.austin.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 May 2003 17:32:58.0621 (UTC) FILETIME=[DC8082D0:01C31A3E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> wrote:
>
> Which the application thinks is still part of the file, and will expect its
>  changes to be written back.

How so?  Truncate will chop the page off the mapping - it doesn't
miss any pages.

Truncate has to wait for the page lock, so the page may be removed from the
mapping shortly after the major fault's IO has completed.  Maybe that's
what you are seeing.

