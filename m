Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267187AbTAUTmI>; Tue, 21 Jan 2003 14:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267190AbTAUTmI>; Tue, 21 Jan 2003 14:42:08 -0500
Received: from packet.digeo.com ([12.110.80.53]:18399 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267187AbTAUTmG>;
	Tue, 21 Jan 2003 14:42:06 -0500
Message-ID: <3E2DA4A5.C5C17138@digeo.com>
Date: Tue, 21 Jan 2003 11:51:01 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Tomas <bzzz@tmi.comex.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] vmtruncate releases pages of MAP_PRIVATE vma
References: <m3hec2i9su.fsf@lexa.home.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Jan 2003 19:51:06.0150 (UTC) FILETIME=[6F935460:01C2C186]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
> 
> Good day!
> 
> I've just encountered that vmtruncate() releases all pages of
> selected VMA. It does even if VMA is MAP_PRIVATE. Is this right
> behaviour?

     If the size of the mapped file changes after the call to mmap()
     as a result of some other operation on the mapped file, the
     effect of references to portions of the mapped region that
     correspond to added or removed portions of the file is
     unspecified.

> I think vmtruncate() should preserve that pages.

That would make sense.  But we'd have to go and create zillions
of copies of pages inside truncate, and given that the behaviour
is unspecified, it is questionable whether anyone should be
relying on the behaviour anyway..
