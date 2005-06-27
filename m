Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVF0Jal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVF0Jal (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 05:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVF0Jal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 05:30:41 -0400
Received: from relay2.beelinegprs.ru ([217.118.71.5]:49115 "EHLO
	relay2.beelinegprs.ru") by vger.kernel.org with ESMTP
	id S261998AbVF0JaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 05:30:01 -0400
From: Alexander Zarochentsev <zam@namesys.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: reiser4 plugins
Date: Mon, 27 Jun 2005 13:30:06 +0400
User-Agent: KMail/1.8
Cc: David Masover <ninja@slaphack.com>, Jeff Garzik <jgarzik@pobox.com>,
       Hans Reiser <reiser@namesys.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
References: <20050620235458.5b437274.akpm@osdl.org> <42B92AA1.3010107@slaphack.com> <20050626170203.GC18942@infradead.org>
In-Reply-To: <20050626170203.GC18942@infradead.org>
Organization: namesys
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506271330.07451.zam@namesys.com>
X-SpamTest-Info: Profile: Formal (248/050617)
X-SpamTest-Info: Profile: Detect Hard No RBL (4/030526)
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (2/030321)
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0129], SpamtestISP/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 June 2005 21:02, Christoph Hellwig wrote:
> On Wed, Jun 22, 2005 at 04:08:49AM -0500, David Masover wrote:
> > I've been reading a bit of history, and the reason Linux got so popular
> > in the first place was the tendency to include stuff that worked and
> > provided a feature people wanted, even if it was ugly.  The philosophy
> > would be:  choose a good implementation over an ugly one, but choose an
> > ugly one over nothing at all.
>
> And things change over time.  Back in those days the linux codebase was
> small and it was easy to change things all over the place.  These times
> our codebase is huge, and people that know enough parts of the kernel to
> do big changes are overloaded with work.  Thus we have to set our
> acceptance criteria a lot higher now - else we'd be totally lost with
> the current size of the project already.
>
> > > We have to maintain said ugly code for decades.  Maintainability is a
> > > big deal when you deal with the timeframes we deal with.
> >
> > Maintainability is like optimization.  The maintainability of a
> > non-working program is irrelevant.  You'd be right if we already had
> > plugins-in-the-VFS.  We don't.  The most maintainable solution for
> > plugins-in-the-FS that actually exists is Reiser4, exactly as it is now
> > - -- because it is the _only_ one that actually exists right now.
>
> We do have plugins in the VFS, every filesystem is a set of a few of them
> and some gluecode.
>
> <skipping a lot stuff>
>
> David and Hans, I've read through my backlog a lot now, and I must say
> it's pretty pointless - you're discussing lots of highlevel what if and
> don't actually care about something as boring as actual technical details.
>
> Hans has lots of very skillfull technical people like zam and vs, and maybe
> he should give them some freedom to sort out technical issues for a basic
> reiser4 merge, and one that is done we can turn back to discussion of
> advanced features and their implementation, hopefully with a few more
> arguments on both sides and a real technical discussion.

Unfortunately, this is not only a technical discussion...  it is about linux 
development model too.

Well, about the plugins. We can clean reiser4<->VFS interface up by setting 
per-vfs-object inode/dentry/super ops instead using of our own dispatcher.  
So different reiser4 inodes/files will have different i_ops/f_ops.  That 
would be only visible-in-VFS part of reiser4 object plugins.   

Would the help to solve "reiser4 plugins" question?  It is just as other FS do 
-- procfs  has seq_file and sysconfig interfaces below the VFS and l-k people 
do not complain each day about layering violation ;-)  Procfs is taken as an 
example because it deals with objects of different types, actually anybody 
may create own procfs objects more or less general way.

I don't belive that you want to see all reiser4-specific things as item 
plugins, disk format plugins in the VFS.

Thanks,
Alex.

