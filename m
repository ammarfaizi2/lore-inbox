Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbVIEIwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbVIEIwx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 04:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVIEIwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 04:52:53 -0400
Received: from ns.suse.de ([195.135.220.2]:47853 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932324AbVIEIwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 04:52:53 -0400
Date: Mon, 5 Sep 2005 10:52:47 +0200 (CEST)
From: Michael Matz <matz@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: ak@suse.de, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] [2.6 patch] include/asm-x86_64 "extern inline" ->
 "static inline"
In-Reply-To: <20050902203123.GT3657@stusta.de>
Message-ID: <Pine.LNX.4.58.0509051047530.27439@wotan.suse.de>
References: <20050902203123.GT3657@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2 Sep 2005, Adrian Bunk wrote:

> "extern inline" doesn't make much sense.

It does.  It's a GCC extension which says "never ever emit an out-of-line
version of this function, not even if its address is taken", i.e. it's
implicitely assumed, that if there is a need for such out-of-line variant,
then it is provided by some other mean (for instance by defining it
without inline markers in some .o file).  Usually there won't be such need
as all instances are inlined, in which case the out-of-line version would
be dead bloat, which you can't get rid of without this extension.  And if
some calls are not inlined then this extension serves as a poor mans
check, because a link error will result.

All in all, it does make sense, and no it's not the same as a "static 
inline", not even if forced always_inline.


Ciao,
Michael.
