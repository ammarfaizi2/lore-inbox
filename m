Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSHJSlD>; Sat, 10 Aug 2002 14:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317209AbSHJSlD>; Sat, 10 Aug 2002 14:41:03 -0400
Received: from dsl-213-023-020-194.arcor-ip.net ([213.23.20.194]:64919 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317194AbSHJSlD>;
	Sat, 10 Aug 2002 14:41:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
Date: Sat, 10 Aug 2002 20:46:10 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0208101119320.2197-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0208101119320.2197-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17dbFa-0001a5-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 August 2002 20:32, Linus Torvalds wrote:
> On Sat, 10 Aug 2002, Daniel Phillips wrote:
> > I'm sure you're aware there's a lot more you can do with these tricks
> > than just zero-copy read - there's zero-copy write as well, and there
> > are both of the above, except a full pte page at a time.  There could
> > even be a file to file copy if there were an interface for it.
> 
> The file-to-file copy is really nasty to do, for the simple reason that
> one page really wants to have just one "owner". So while doing a
> file-to-file copy is certainly possible, it tends to imply removing the
> cached page from the source and inserting it into the destination.
> 
> Which is the right thing to do for streaming copies, but the _wrong_ thing 
> to do if the source is then used again.

If the source is only used for reading it's fine, and you'd know that in
advance if the file is opened r/o.

I will admit that this one is pretty far out there, there is just a ton of 
meat and potatoes cleanup work to do before these deathray-type features get 
to the top of the stack.  But when they do, it's going to be fun.

-- 
Daniel
