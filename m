Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289790AbSAJXxh>; Thu, 10 Jan 2002 18:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289791AbSAJXx0>; Thu, 10 Jan 2002 18:53:26 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:58631 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289790AbSAJXxP>; Thu, 10 Jan 2002 18:53:15 -0500
Message-ID: <3C3E2819.6A3AAD77@zip.com.au>
Date: Thu, 10 Jan 2002 15:47:37 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pagecache lock ordering
In-Reply-To: <3C3CE5D6.2204BD27@zip.com.au> <Pine.LNX.4.21.0201101332560.1121-100000@localhost.localdomain> <3C3DFBEF.BA050536@zip.com.au>,
		<3C3DFBEF.BA050536@zip.com.au>; from akpm@zip.com.au on Thu, Jan 10, 2002 at 12:39:11PM -0800 <20020110182804.D8433@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> On Thu, Jan 10, 2002 at 12:39:11PM -0800, Andrew Morton wrote:
> > I'm struggling to see a use for generic_buffer_fdatasync().  Maybe
> > for a filesystem which doesn't implement ->writepage()?  Dunno.
> 
> I seem to be using it in aio.  Well, at least code based on it which
> seems to work for most filesystems for O_DATASYNC...
> 

You seem to be using writeout_one_page().  What I was
thinking of was:

- Kill generic_buffer_fdatasync().
- Move writeout_one_page() into fs/buffer.c
- Move waitfor_one_page() into fs/buffer.c.  This is just
  for completeness; I expect this function will have no
  callers soon.  __iodesc_sync_wait_page() could use it though.

OK by you?

-
