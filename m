Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265701AbUHaRmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUHaRmA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265086AbUHaRmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:42:00 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:1782 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265999AbUHaRlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:41:11 -0400
Subject: Re: What policy for BUG_ON()?
From: Albert Cahalan <albert@users.sf.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       bunk@fs.tum.de, arjanv@redhat.com, axboe@suse.de
In-Reply-To: <Pine.LNX.4.58.0408310945580.2295@ppc970.osdl.org>
References: <1093964782.434.7054.camel@cube>
	 <Pine.LNX.4.58.0408310945580.2295@ppc970.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1093973977.434.7097.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 31 Aug 2004 13:39:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-31 at 12:52, Linus Torvalds wrote:
> On Tue, 31 Aug 2004, Albert Cahalan wrote:
> > 
> > The normal expectation for non-debug builds
> > would be this:
> > 
> > #define BUG_ON(x)
> 
> No, this is bad, for one big reason: it generates compiler
> warnings if 'x' happens to be the only thing that uses some value.
...
> This is generally why you should have macros like this not
> become empty, but become something that the compiler can
> compile away. Which is why I'd much rather see
> 
> 	#define BUG_ON(x) (void)(x)
> 
> regardless of any side-effect issues - it's a way to let the
> compiler optimize the thing away, but still show that
> something was used at least "conceptually"..

Expensive function calls won't get optimized away unless you
mark them __attribute__((__const__)) or __attribute__((__pure__)).
(perhaps that should be encouraged)

Then of course the compiler must assume that the function
really needed the arguments it was passed, and that it
might have modified memory, and so on.

Eh, how about a BUG_ON_WITH_SIDE_EFFECT() macro?


