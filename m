Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbSLIDq2>; Sun, 8 Dec 2002 22:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbSLIDq2>; Sun, 8 Dec 2002 22:46:28 -0500
Received: from havoc.daloft.com ([64.213.145.173]:53967 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S262449AbSLIDqZ>;
	Sun, 8 Dec 2002 22:46:25 -0500
Date: Sun, 8 Dec 2002 22:54:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: bit testing nervousness...
Message-ID: <20021209035400.GA20470@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey...

WRT all these test_bit()/set_bit() cleanups.   I am a bit nervous about
these changes that are coming in...

When I see types change from "u8" or "u32" to "long" just to make
<foo>_bit() work, that really makes me think that cleanup is wrong.  I
haven't looked closely at the recent set_bit() cleanups yet, but I am
willing to bet that at least some of them are wrongly changing the size
of a variable's type.

My preference would be to _eliminate_ the set_bit call and simply
open-code the bitop, i.e.
	set_bit(bitnum, &foo);
become
	foo |= (1 << bitnum);
	
Really, for each cleanup, you need to look hard at the change and
see if <foo>_bit() is being used for atomicity reasons or simply
programmer preference.  (and other issues like endian issues)  The
latter can easily be changed to open-coding.

Disclaimer, my argument is null and void if each change has been closely
studied and is really correct :)  However I'm guessing we all are only
glancing at the changes :)

	Jeff



