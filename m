Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291277AbSBMAlK>; Tue, 12 Feb 2002 19:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291272AbSBMAk5>; Tue, 12 Feb 2002 19:40:57 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23814 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291277AbSBMAkp>;
	Tue, 12 Feb 2002 19:40:45 -0500
Message-ID: <3C69B5D7.CFF9E8EA@zip.com.au>
Date: Tue, 12 Feb 2002 16:39:51 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Rik van Riel <riel@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <Pine.LNX.4.33L.0202122215020.12554-100000@imladris.surriel.com> from "Rik van Riel" at Feb 12, 2002 10:15:38 PM <E16anPg-0003cy-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I don't see why it should be different for applications
> > that write data after sync has started.
> 
> The guarantee about data written _before_ the sync started is also being
> broken unless I misread the code

That would be very broken.

The theory is: newly dirtied buffers are added at the "new"
end of the LRU.  write_some_buffers() starts at the "old"
end of the LRU.

So if write_unlock_buffers writes out the "oldest"
nr_buffers_type[BUF_DIRTY] buffers, then it knows
that it has written out everything which was dirty
at the time it was called.

Or did I miss something?

-
