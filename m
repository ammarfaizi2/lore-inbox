Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbVLaLqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVLaLqx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 06:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbVLaLqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 06:46:53 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:56331 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1751079AbVLaLqx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 06:46:53 -0500
Date: Sat, 31 Dec 2005 20:47:17 +0900 (JST)
Message-Id: <20051231.204717.124347182.yoshfuji@linux-ipv6.org>
To: torvalds@osdl.org
Cc: yang.y.yi@gmail.com, linux-kernel@vger.kernel.org, gregkh@suse.de,
       akpm@osdl.org, yoshfuji@linux-ipv6.org
Subject: Re: [PATCH] Fix user data corrupted by old value return of sysctl
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <Pine.LNX.4.64.0512300916220.3249@g5.osdl.org>
References: <43B4F287.6080307@gmail.com>
	<Pine.LNX.4.64.0512300916220.3249@g5.osdl.org>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

In article <Pine.LNX.4.64.0512300916220.3249@g5.osdl.org> (at Fri, 30 Dec 2005 09:25:35 -0800 (PST)), Linus Torvalds <torvalds@osdl.org> says:

> On Fri, 30 Dec 2005, Yi Yang wrote:
> >
> > If the user reads a sysctl entry which is of string type
> > by sysctl syscall, this call probably corrupts the user data
> > right after the old value buffer, the issue lies in sysctl_string
> > seting 0 to oldval[len], len is the available buffer size
> > specified by the user, obviously, this will write to the first
> > byte of the user memory place immediate after the old value buffer,
> > the correct way is that sysctl_string doesn't set 0, the user
> > should do it by self in the program.
:
> We _should_ zero-pad the data, at least if the result fits in the buffer.
:
> But even that is questionable: one alternative is to always zero-pad (like 
> we used to), but make sure that the buffer size is sufficient for it (ie 
> instead of adding one to the length of the string, we'd subtract one from 
> the buffer length and make sure that the '\0' fits..

How about returning -ENOMEM, as BSDs (FreeBSD and NetBSD
at least) do.  No?

--yoshfuji
