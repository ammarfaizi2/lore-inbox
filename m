Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263403AbTIGRh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 13:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263386AbTIGRgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 13:36:33 -0400
Received: from ns.suse.de ([195.135.220.2]:8069 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263390AbTIGRei (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 13:34:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
References: <Pine.LNX.4.44.0309071024010.2977-100000@home.osdl.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I have no actual hairline...
Date: Sun, 07 Sep 2003 19:34:36 +0200
In-Reply-To: <Pine.LNX.4.44.0309071024010.2977-100000@home.osdl.org> (Linus
 Torvalds's message of "Sun, 7 Sep 2003 10:29:28 -0700 (PDT)")
Message-ID: <jeekysjydv.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 7 Sep 2003, Andreas Schwab wrote:
>> 
>> Here is a patch that enforces the use of types in the third argument.  It
>> requires gcc >= 3.1 for the check to work, I couldn't find a method for
>> previous versions.
>
> Ehh, what's wrong with the obvious approach: declare a dummy variable. If 
> it's not a type, then the declaration won't work.
>
> Ie, change the (sizeof(x)) to something like
>
> 	({ x __dummy; sizeof(__dummy); })
>
> which should work with all compiler versions.

This won't work with array types, eg. in <linux/random.h>:

#define RNDGETPOOL	_IOR( 'R', 0x02, int [2] )

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
