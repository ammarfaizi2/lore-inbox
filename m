Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291252AbSBGUBE>; Thu, 7 Feb 2002 15:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291259AbSBGUAu>; Thu, 7 Feb 2002 15:00:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17934 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291252AbSBGUAV>;
	Thu, 7 Feb 2002 15:00:21 -0500
Message-ID: <3C62DC97.51066181@zip.com.au>
Date: Thu, 07 Feb 2002 11:59:19 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: Robert Love <rml@tech9.net>, Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, nigel <nigel@nrg.org>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <3C62D49A.4CBB6295@zip.com.au> <Pine.LNX.4.33.0202072226100.447-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Thu, 7 Feb 2002, Andrew Morton wrote:
> 
> > Quite a few.  Significant ones.  pagemap_lru_lock and lru_list_lock
> > come to mind.
> 
> ugh. Are you sure we want to *sleep* with something like pagemap_lru_lock
> held?

Not guilty :)  I was answering rml's question.

I suspect lru_list_lock is the shining example.  We often
take it for very short periods and occasionally take it
for enormous periods.

> That pretty much brings all pagecache related operations to a
> grinding halt.

yup.  We'd go into a sheduling storm until we find the process
which holds the lock.

> I think complex spinlocked sections should be simplified
> rather.

yes.

-
