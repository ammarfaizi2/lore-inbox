Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319711AbSIMRFP>; Fri, 13 Sep 2002 13:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319708AbSIMRFP>; Fri, 13 Sep 2002 13:05:15 -0400
Received: from dsl-213-023-022-092.arcor-ip.net ([213.23.22.92]:20112 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319711AbSIMRFO>;
	Fri, 13 Sep 2002 13:05:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Thunder from the hill <thunder@lightweight.ods.org>
Subject: Re: [RFC] Raceless module interface
Date: Fri, 13 Sep 2002 19:12:13 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209131031480.10048-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0209131031480.10048-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ptzJ-0008BP-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 18:39, Thunder from the hill wrote:
> Hi,
> 
> On Fri, 13 Sep 2002, Daniel Phillips wrote:
> > That's debatable.  Arguably, a failed ->module_cleanup() should be
> > retried on every rmmod -a, but expecting module.c to just keep
> > retrying mindlessly on its own sounds too much like a busy wait.
> 
> Hmmm. You might as well give it back to the user.
> 
> rmmod: remove failed: do it again!

That's what happens now.  We can certainly improve the error message,
and actually, that just falls out, from properly adding an error
return code to ->cleanup_module()

> So the cleanup code could as well just do it on its own.

???

> > > Why is that sloppy? E.g. kfree() happily accepts NULL pointers as well.
> > 
> > That is sloppy.  Different discussion.
> 
> What should kfree do in your opinion? BUG()?

Yuppers:

static inline void kfree_test(void *object)
{
	if (object)
		kfree(object);
}

#define kfree_sloppy kfree_test

s/kfree/kfree_sloppy/g

(But see "different discussion" above.)

> doodle.c:12: attempted to free NULL pointer, as you know it already is.

Um.  You know it's NULL and you freed it anyway?

(But see "different discussion" above.)

> > I take it that the points you didn't reply to are points that you
> > agree with?  (The main point being, that we both advocate a simple,
> > two-method interface for module load/unload.)
> 
> You could even do it using three methods.

Yes, or two, my favorite.

-- 
Daniel
