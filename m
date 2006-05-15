Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWEOW5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWEOW5O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWEOW5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:57:14 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:8336 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750722AbWEOW5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:57:13 -0400
Date: Tue, 16 May 2006 08:56:34 +1000
From: Nathan Scott <nathans@sgi.com>
To: Andrew Morton <akpm@osdl.org>, pbadari@us.ibm.com
Cc: hch@lst.de, bcrl@kvack.org, cel@citi.umich.edu, zach.brown@oracle.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Streamline generic_file_* interfaces and filemap cleanups
Message-ID: <20060516085634.G5598@wobbly.melbourne.sgi.com>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com> <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com> <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com> <1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com> <1147728206.6181.7.camel@dyn9047017100.beaverton.ibm.com> <20060516082804.F5598@wobbly.melbourne.sgi.com> <20060515154240.49534bd8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060515154240.49534bd8.akpm@osdl.org>; from akpm@osdl.org on Mon, May 15, 2006 at 03:42:40PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 03:42:40PM -0700, Andrew Morton wrote:
> Nathan Scott <nathans@sgi.com> wrote:
> > Any chance that could be renamed to something thats a bit clearer,
> > maybe generic_file_non_aio_read and generic_file_non_aio_write?
> 
> I guess that logically, we should avoid the double-negative and use
> generic_file_sio_*.

"s" as in "sync"?  But its not sync.

> I dunno if we want to be that logical though ;)

The real problem I guess is that "aio" isn't clear enough, as there
are different types of async io.  Maybe generic_posix_aio_* versus
generic_file_aio_* - *shrug*, thats probably not much better really.
Pretty much anything would be better than do_sync_write (describing
buffered not-sync writes) though. :)

On Mon, May 15, 2006 at 03:47:15PM -0700, Badari Pulavarty wrote:
> You  mean "left-in-pagecache-not-really-written-to-disk" synchronous ? 

Heh - yes, thats the one (you have a contradiction in terms there -
if its the former, its not the latter ;)

> Yeah. I see it..
> I prefer, generic_file_aio_read_and_wait(), 
> generic_file_aio_write_and_wait() - but

Well, yeah - maybe - getting a bit long winded, but thats possibly the
best option so far.

> I also have a small issue with the current do_sync_*() routines - if 
> some one calls it
> without setting their ->aio_read()/->aio_write(), we panic. May be we 

Hmm.  I imagine the author of the fs code would quickly find out they'd
made that mistake though, and it'd fail in a fairly easily debuggable
way, so perhaps not really a big issue in practice.

cheers.

-- 
Nathan
