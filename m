Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261613AbSIXJWJ>; Tue, 24 Sep 2002 05:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261618AbSIXJWJ>; Tue, 24 Sep 2002 05:22:09 -0400
Received: from unthought.net ([212.97.129.24]:48363 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S261613AbSIXJWH>;
	Tue, 24 Sep 2002 05:22:07 -0400
Date: Tue, 24 Sep 2002 11:27:20 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org, Hans Reiser <reiser@namesys.com>
Subject: Re: ReiserFS buglet
Message-ID: <20020924092720.GF2442@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org,
	Hans Reiser <reiser@namesys.com>
References: <20020924072455.GE2442@unthought.net> <20020924132110.A22362@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020924132110.A22362@namesys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 01:21:10PM +0400, Oleg Drokin wrote:
> Hello!
> 
...
> 
> > I would suggest replacing the '!=' with a '<' in the while loop and
> > adding a sanity check afterwards.
> 
> What if overheated CPU will cause a bitflip exactly after such checks?
> You cannot protect against broken hardware. Such problems should be
> fixed by fsck.

Disk errors are common. Software can also flip that bit.

But I agree that it shouldn't be something that commonly happens, and I
suppose it is acceptable for a filesystem to barf if it has been
corrupted by malicious software.

> 
> > As I see it, the ReiserFS journal has the same problems as jbd wrt. to
> > atomicity of write operations of indexes.  Please see my recent mail
> > about the jbd problems.
> 
> journal header in reiserfs only occupies first 20 bytes of the block,
> since this fells within 1st 512 bytes hardware sector, it will be written
> atomically, I presume.

You presume wrong.

I posted to LKML about a month ago with some questions regarding exactly
this issue.  I had a disk that worked on 128 byte atomic writes - a
standard IDE disk.

The conclusion was something like "we know jack about the disk's
internal logic" so we need consistency measures instead of relying on
anything from the disk.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
