Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271627AbRIOAzF>; Fri, 14 Sep 2001 20:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271669AbRIOAyq>; Fri, 14 Sep 2001 20:54:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19984 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S271627AbRIOAyg>; Fri, 14 Sep 2001 20:54:36 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ISOFS corrupt filesizes
Date: 14 Sep 2001 17:54:55 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9nu8sv$fnj$1@cesium.transmeta.com>
In-Reply-To: <20010914145352.A9952@stud.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010914145352.A9952@stud.tu-muenchen.de>
By author:    Matthias Kramm <matthias.kramm@stud.tu-muenchen.de>
In newsgroup: linux.dev.kernel
> According to the (2.4.9) MAINTAINERS-File,  ISOFS doesn't have a maintainer,
> so this probably best fits in this list.
> 
> I came across a (commercial) DVD with an ISOFS Filesystem on it and filesizes
> bigger than 1M.
>

1 GB (not MB) you mean...

> My personal guess would be that the assumption that iso files can't be
> bigger than 1M unless the CD-ROM is defective is wrong.
> (I don't know where the 1M comes from. 2M sounds more logical to me,
>  however)

1 GB comes from the fact that some old CD's actually put garbage in
the upper byte of the file size, so the test triggers if the size is
larger than any CD can be.  Unfortunately, DVDs are a lot bigger than
CDs and that assumption is no longer correct.

> After removing the "indode->i_size > 1073741824" test, I got the correct
> output for ls. Also was I able to cat (css-cat, actually) the whole 1201278976 
> bytes without an error, which may lead to the assumption the file
> is actually that big.
> If I'm wrong and the dvd is actually broken, however, I'd like to 
> suggest making the automatic cruft mount optional.

The automatic cruft mount option should probably be conditionalized
not on a fixed size, but on the actual size of the filesystem.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
