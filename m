Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAYXEx>; Thu, 25 Jan 2001 18:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129703AbRAYXEn>; Thu, 25 Jan 2001 18:04:43 -0500
Received: from adsl-209-182-168-213.value.net ([209.182.168.213]:8196 "EHLO
	draco.foogod.com") by vger.kernel.org with ESMTP id <S129406AbRAYXEh>;
	Thu, 25 Jan 2001 18:04:37 -0500
Date: Thu, 25 Jan 2001 15:03:53 -0800
From: alex@foogod.com
To: Thunder from the hill <thunder@ngforever.de>
Cc: Daniel Phillips <phillips@innominate.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: named streams, extended attributes, and posix
Message-ID: <20010125150353.C870@draco.foogod.com>
In-Reply-To: <Pine.LNX.4.30.0101182129050.1089-100000@nvws005.nv.london> <004701c081ef$e32dcb90$8501a8c0@gromit> <3A708F8F.17426D2@innominate.de> <3A70957F.649C6A49@ngforever.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A70957F.649C6A49@ngforever.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2001 at 02:07:11PM -0700, Thunder from the hill wrote:
> Daniel Phillips wrote:
> > For some reason totally beyond my comprehension // inside a file name is
> > taken to be the same as /, but if it wasn't it could be the stream
> > separator.  *sigh*
> It seems that you mix up forward and backward slashes. a // means //,
> but a \\ means a single \. So if you want a double backslash, you have

No, he's referring to the fact that multiple path separators ("/") in a file 
specification are collapsed to be equivalent to one.  Thus "/some//file///path"
is equivalent to "/some/file/path" as far as the system is concerned.

This is actually a very handy thing, IMHO, and avoids tons of 
trailing-slash/leading-slash special-case logic in apps, not to mention subtle 
bugs resulting from lack of same as I have encountered way too many times on 
other platforms...

I agree however, that it would perhaps have been nice if POSIX hadn't been 
quite so gung-ho about any-character-under-the-sun-is-ok-in-filenames so we had a couple of reserved characters to play with down the line..

Here's an idea: streams/etc are reached by appending "/.../xxx" or some 
such to paths, thus:
  for streamname on /dir/file, we have "/dir/file/.../streamname" 
    -- a few more characters to type but no big deal really,
  for a directory /dir/dir, we get /dir/dir/.../streamname" 
    -- "..." is a special subdirectory of any directories which have 
    attached streams.  If the name of such a directory is chosen well 
    (personally, I think "..." is a good choice as it goes well with "." and 
    ".." as a filesystem-intrinsic name), this is much less likely to 
    conflict with normal filesystem namespaces.

This also has the advantage of being extendable (using strings other than 
"...") for other applications or future additions.

-alex
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
