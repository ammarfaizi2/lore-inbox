Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265742AbTGLN4n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 09:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265756AbTGLN4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 09:56:43 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:33963 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265742AbTGLN4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 09:56:39 -0400
Subject: Re: Sound updating, security of strlcpy and a question on pci v
	unload
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: mitch@sfgoth.com
Content-Type: text/plain
Organization: 
Message-Id: <1058018597.749.1317.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Jul 2003 10:03:17 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitchell Blank Jr writes:
> Mikulas Patocka wrote:

>> What's the difference there? strlcpy always creates null-terminated
>> string, strncpy doesn't. strncpy in kernel (unlike user strncpy) does not
>> pad the whole destination buffer with zeros (see comment and
>> implementation in lib/string.c), so I don't see any point why strncpy
>> should be more secure.
>
> Not only that, I think the point is usually moot anyway.
> If you're filling in a structure to pass to userspace like:
>
>  struct whatever foo;
>  strncpy(foo.name, "My Driver", sizeof(foo.name));
>  foo.count = 1;
>  [...]
>
> then you're STILL probably at risk of data leakage if "struct whatever"
> requires padding on any architecture.  The real fix is to make sure
> that "foo" is explicitly zero'ed out first.  Then strlcpy-vs-strncpy
> becomes a non-issue.

gcc -Wpadding ...

If the compiler has to add padding, then the programmer
most likely messed up. The warning catches stupidity.
Necessary padding can be explicit.



