Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbTLaNo3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 08:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbTLaNo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 08:44:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52694 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264493AbTLaNo2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 08:44:28 -0500
Date: Wed, 31 Dec 2003 13:44:27 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Valdis.Kletnieks@vt.edu
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: hmm..
Message-ID: <20031231134427.GO4176@parcelfarce.linux.theplanet.co.uk>
References: <3FE74FD3.8040807@antitux.net> <Pine.LNX.4.58.0312221316090.6868@home.osdl.org> <200312250756.hBP7ubq8014587@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312250756.hBP7ubq8014587@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 25, 2003 at 02:56:37AM -0500, Valdis.Kletnieks@vt.edu wrote:
> work-around because IBM refused to fix it on the grounds that the VALC macro
> was to protect against a SEGV if the macro was fed an 'int' rather than a
> 'char' (why they didn't just use 'mask[__c & 255]' is beyond me), and that you

Err...

a) is...() must be able to deal with any value that fits into unsigned char
and with EOF.  Behaviour on anything else is undefined, so their argument
is obviously bogus.

b) mask[__c & 255] is _not_ a solution, simply because EOF and 255 might
have different properties.  Doesn't apply to kernel, but our is...()
do not bother with EOF at all.  Userland ones have to.
