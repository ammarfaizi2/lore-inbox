Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289817AbSBTAN6>; Tue, 19 Feb 2002 19:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290657AbSBTANt>; Tue, 19 Feb 2002 19:13:49 -0500
Received: from maila.telia.com ([194.22.194.231]:7932 "EHLO maila.telia.com")
	by vger.kernel.org with ESMTP id <S289817AbSBTANm>;
	Tue, 19 Feb 2002 19:13:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jakob Kemi <jakob.kemi@telia.com>
To: Andreas Dilger <adilger@turbolabs.com>
Subject: Re: [PATCH] hex <-> int conve
Date: Wed, 20 Feb 2002 01:12:26 +0100
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <02021919474003.00447@jakob> <20020219125622.B25713@lynx.adilger.int>
In-Reply-To: <20020219125622.B25713@lynx.adilger.int>
MIME-Version: 1.0
Message-Id: <02022001122600.01789@jakob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 19 February 2002 20.56, Andreas Dilger wrote:
> If it is a matter of UUID parsing, just add (or use existing) function
> uuid_parse() similar to that in libuuid.  Some UUID-related functions were
> added to the kernel for ia64 GPM partitions, so this would just make the
> UUID support in the kernel more complete.

Yes it might be appropriate to use and/or extend those functions.


> Note that unless LDM has some serious brain-damage, there should not be any
> need to have these special functions, as the user-space UUID-related code
> works just fine without them.

Unfortunately LDM has some serious brain-damage, nothing we can't handle
though. We don't need these special functions, we can continue to have them
in ldm.c (I'm talking about the new cvs version, soon to hit 2.5). However,
for those who read the beginning of this thread, I also gave the reason for
adding them where others can use them. As I grepped through the kernel I
found 27 (!) different _implementations_ (I might have missed some with non-
obvious names) of hex to int functions all of them were using variations of a
form which compiles to (on x86) twice the size and double execution time of
this one. Not that speed really matters in this context. I also found a dozen
or so of different int to hex implementations. In order to reduce code
duplication and increase the homogeneity of the kernel I think it's a good
idea to use _one_ implementation.

Cheers,
	Jakob Kemi
