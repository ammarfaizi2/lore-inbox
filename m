Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130865AbQL1Pw2>; Thu, 28 Dec 2000 10:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130420AbQL1PwS>; Thu, 28 Dec 2000 10:52:18 -0500
Received: from hermes.mixx.net ([212.84.196.2]:21011 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S130865AbQL1PwG>;
	Thu, 28 Dec 2000 10:52:06 -0500
From: Daniel Phillips <phillips@innominate.de>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: innd mmap bug in 2.4.0-test12
Date: Thu, 28 Dec 2000 16:15:48 +0100
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012281310530.14052-100000@duckman.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0012281310530.14052-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Message-Id: <00122816191301.00966@gimli>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2000, Rik van Riel wrote:
> On Thu, 28 Dec 2000, Daniel Phillips wrote:
> 
> > It's logical that PageDirty should never be get for ramfs,
> 
> No. Not setting PageDirty will cause the system to move the
> page to the inactive_clean list and happily reclaim your data.
> 
> We _have to_ use something like PageDirty for this, and
> checking for the ->writepage method will even allow us to
> do stuff like dynamically switching swapping support for
> ramfs on/off (or other funny things).

You're suggesting using the absence of a method as a kind of flag, but
the code is really too full of obscure stuff like that already.

How about taking an extra user on the ramfs pages instead.  It doesn't
sound right to set PageDirty when you are not requesting IO.

-- 
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
