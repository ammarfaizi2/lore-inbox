Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283261AbRK2OlM>; Thu, 29 Nov 2001 09:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283260AbRK2OlC>; Thu, 29 Nov 2001 09:41:02 -0500
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:9127 "EHLO
	albatross.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S283259AbRK2Okn>; Thu, 29 Nov 2001 09:40:43 -0500
Date: Thu, 29 Nov 2001 09:40:40 -0500 (EST)
Message-Id: <20011129.094040.124092017.wscott@bitmover.com>
To: linux-kernel@vger.kernel.org
Cc: jmd@turbogeek.org
Subject: Re: Extraneous whitespace removal?
From: Wayne Scott <wscott@bitmover.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeremy M. Dolan <jmd@turbogeek.org>
> Pluses:
>  - clean up messy whitespace
>  - cut precious picoseconds off compile time
>  - cut kernel tree by 200k (+/- alot)
>
> Minuses:
>  - adds 3.8M bzip2 or 4.7M gzip to next diff

As someone who has spend a lot of time working on version control and
file merging, let be tell you the big minus you missed. 

After this patch go into the Linux kernel, everyone who is maintaining
a set of patches in parallel with the main kernel has a lot of extra
work resolving the conflicts caused by this change.  You have touched
a huge number of lines and people will have to walk a list of merge
conflicts everywhere they have made local changes and pick their side.
And anytime people do a whole series of the same edits over and over
they will miss that real conflict in the middle and lose some
important change.

The other problem that occurs is for people who maintain version
histories.  It is really useful to know where (and why) a line was
last changed.  This obscures that information by a layer of edits that
made no change.

While saving a little space is nice, it is not worth the pain and risk
it involves.  I much prefer the solution suggested where incoming
patches are filtered before they are applied. Used consistantly, the
whitespace will be removed over time.

-Wayne
