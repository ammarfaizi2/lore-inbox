Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318816AbSHLVQn>; Mon, 12 Aug 2002 17:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318819AbSHLVQn>; Mon, 12 Aug 2002 17:16:43 -0400
Received: from dsl-213-023-022-055.arcor-ip.net ([213.23.22.55]:23982 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318816AbSHLVQn>;
	Mon, 12 Aug 2002 17:16:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
Date: Mon, 12 Aug 2002 23:21:53 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rusty Russell <rusty@rustcorp.com.au>, <akpm@zip.com.au>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0208121328280.1289-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0208121328280.1289-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17eMdO-0001sf-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 August 2002 22:29, Linus Torvalds wrote:
> On Mon, 12 Aug 2002, Daniel Phillips wrote:
> > 
> > That's the whole point of this: it's not a bug anymore.  (It's a feature.)
> 
> Well, it's a feature only if _intentional_, so I think Rusty's argument 
> was that we should call it something else than "copy_to/from_user()" if 
> we're ready to accept the fact that it fails for random reasons..

Right, I meant to follow up and correct that - the caller has the
responsibility of detecting the short transfer and taking corrective
action, but on the other hand, maybe the caller always had that
responsibility.

But for the cases where the caller 'knows' it holds no locks, it's
better to oops if that's untrue as Rusty said, plus the inc/dec is
saved in that case.

-- 
Daniel
