Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135940AbREGAca>; Sun, 6 May 2001 20:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135942AbREGAcU>; Sun, 6 May 2001 20:32:20 -0400
Received: from geos.coastside.net ([207.213.212.4]:58332 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S135940AbREGAcG>; Sun, 6 May 2001 20:32:06 -0400
Mime-Version: 1.0
Message-Id: <p05100310b71b9d713659@[207.213.214.37]>
Date: Sun, 6 May 2001 17:32:08 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: page_launder() bug
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:07 AM +0200 2001-05-07, BERECZ Szabolcs wrote:
>On Sun, 6 May 2001, Jonathan Morton wrote:
>
>  > >-			 page_count(page) == (1 + !!page->buffers));
>>
>>  Two inversions in a row?  I'd like to see that made more explicit,
>>  otherwise it looks like a bug to me.  Of course, if it IS a bug...
>it's not a bug.
>if page->buffers is zero, than the page_count(page) is 1, and if
>page->buffers is other than zero, page_count(page) is 2.
>so it checks if page is really used by something.
>maybe this last line is not true, but the !!page->buffers is not a bug.

There's something to be said for expressing it a little more clearly:

	page_count(page) == (page->buffers ? 2 : 1);

(sorry, I don't remember the relative precedence of == and ?:)
-- 
/Jonathan Lundell.
