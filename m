Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262162AbSIZMvb>; Thu, 26 Sep 2002 08:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262512AbSIZMvb>; Thu, 26 Sep 2002 08:51:31 -0400
Received: from unthought.net ([212.97.129.24]:42645 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S262162AbSIZMva>;
	Thu, 26 Sep 2002 08:51:30 -0400
Date: Thu, 26 Sep 2002 14:56:47 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@zip.com.au>
Subject: Re: jbd bug(s) (?)
Message-ID: <20020926125647.GT2442@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@zip.com.au>
References: <20020924072117.GD2442@unthought.net> <20020925173605.A12911@redhat.com> <20020926122124.GS2442@unthought.net> <20020926132723.D2721@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020926132723.D2721@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 01:27:23PM +0100, Stephen C. Tweedie wrote:
> Hi,

Hi !

...
> 
> The index is only updated when we purge stuff out of the journal.

Yes, of course.

> That can still be quite frequent on a really busy journal, but it's
> definitely not a required part of a transaction.  

No, but the correct writing of your index is a required part for the
successful re-play at recovery.

You can't re-play if you can't find the beginning of your journal  :)

Just *imagine* that half your index was written successfully to disk and
then the power failed.   That was what I imagined could happen.

Quite some people have pointed out to me by now, that I was wrong - so
don't worry about it  :)

> 
> That's deliberate --- the ext3 journal is designed to be written as
> sequentially as possible, so seeking to the index block is an expense
> which we try to avoid.

Of course - any sane journal should be designed that way.

> 
> > RAID wouldn't save me in the case where the journal index is screwed due
> > to a partial sector write and a power loss.
> 
> A partial sector write is essentially impossible.  It's unlikely that
> the data on disk would be synchronised beyond the point at which the
> write stopped, and even if it was, the CRC would be invalid, so you'd
> get a bad sector error return on subsequent attempts to read that data
> --- you'd not be given silently corrupt data.

I know.  What I imagined was, that there were disks out there which
*internally* worked with smaller sector sizes, and merely presented a
512 byte sector to the outside world.

That way, it would be perfecly possible for a disk to write 2 bytes of
your index pointer along with it's error correction codes and what not.
And it would be perfectly possible for it to return an invalid index
pointer (2 bytes of your new pointer, the remaining bytes from the old
pointer) - without returning a read error.

Let's hope that none of the partitioning formats or LVM projects out
there will misalign the filesystem so that your index actually *does*
cross a 512 byte boundary   ;)

> Making parts of the disk suddenly unreadable on power-fail is
> generally considered a bad thing, though, so modern disks go to great
> lengths to ensure the write finishes.

Lucky us  :)


 Cheers,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
