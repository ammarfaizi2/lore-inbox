Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130060AbRBAQqC>; Thu, 1 Feb 2001 11:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129442AbRBAQpv>; Thu, 1 Feb 2001 11:45:51 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:1776 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130264AbRBAQpn>; Thu, 1 Feb 2001 11:45:43 -0500
Date: Thu, 1 Feb 2001 14:45:04 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, David Gould <dg@suse.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] vma limited swapin readahead
In-Reply-To: <20010201143606.P11607@redhat.com>
Message-ID: <Pine.LNX.4.21.0102011441380.1321-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Feb 2001, Stephen C. Tweedie wrote:
> On Thu, Feb 01, 2001 at 08:53:33AM -0200, Marcelo Tosatti wrote:
> > On Thu, 1 Feb 2001, Stephen C. Tweedie wrote:
> > 
> > If we're under free memory shortage, "unlucky" readaheads will be harmful.
> 
> I know, it's a balancing act.  But given that even one
> successful readahead per read will halve the number of swapin
> seeks, the performance loss due to the extra scavenging has got
> to be bad to outweigh the benefit.

But only when the extra pages we're reading in don't
displace useful data from memory, making us fault in
those other pages ... causing us to go to the disk
again and do more readahead, which could potentially
displace even more pages, etc...

One solution could be to put (most of) the swapin readahead
pages on the inactive_dirty list, so pressure by readahead
on the resident pages is smaller and the not used readahead
pages are reclaimed faster.

(and with the size of the inactive list being 1 second worth
of page steals, those pages still have a good chance of being
used before they're being recycled)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
