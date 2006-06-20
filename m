Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWFTOpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWFTOpJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWFTOpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:45:09 -0400
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:38737 "HELO
	smtp104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751161AbWFTOpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:45:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=6fsBFW8ivGQpocUR+YopscK5oqXmlsGtv/Y1JPWU1I62DOHPg6n9P4ZuXrKGV65+6biu4kF3hv9fQFp6QxbJkAeXmbdXMnCNgJsKbyg0DqoU7MNVqdmbQem+tbKyZpN3FEWUYUlDjxt3/TWwbSxoKJ5/EaBctf6i0Wx7Z3dhyRY=  ;
Message-ID: <44980064.6040306@yahoo.com.au>
Date: Wed, 21 Jun 2006 00:04:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Whitehouse <swhiteho@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>, David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>	 <4497EAC6.3050003@yahoo.com.au> <1150807630.3856.1372.camel@quoit.chygwyn.com>
In-Reply-To: <1150807630.3856.1372.camel@quoit.chygwyn.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.

Steven Whitehouse wrote:
>  kernel/printk.c                    |    1 
>  mm/filemap.c                       |    1 
>  mm/readahead.c                     |    1 

These EXPORTs are a bit unfortunate.

BTW. you have one function that calls file_ra_state_init but never appears
to use the initialized ra_state.

Why is gfs2_internal_read() called the "external read function" in the
changelog?

The internal_read function doesn't look like a great candidate for passing
a ra_state to, which invokes all the mechanism expecting a regular file
being accessed by a user program.

It seems as though you could explicitly control readahead more optimally,
but I don't know what the best way to do that would be. I assume Andrew
has had a quick look and doesn't know either.

The part where you needed file_read_actor looks like pretty much a stright
cut and paste from __generic_file_aio_read, which indicates that you might
be exporting at the wrong level.

Not sure about the tty_ export. Would it be better to make a generic
printfish interface on top of it and also replace the interesting dquot.c
gymnastics? (I don't know)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
