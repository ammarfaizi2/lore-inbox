Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbVHKAuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbVHKAuk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 20:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030194AbVHKAuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 20:50:40 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:37782 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030191AbVHKAuj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 20:50:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=k+7N9mbqhhisXjMQ3d3q4HsVSZfMO49Ah7bIE8fCBoMgc1rzO/eVBvLaNjIPR2BiGy62IKQIil+3rCHVql0+s5bqDHqE7YARCZIpHbZu5VAh4BKLJsgO5E3FCgWorNRr7Xmew+1woNIJIlRGCIU0y3m6rca5W8nlE5lNSCaijIY=
Message-ID: <57792e85050810175041d2bad4@mail.gmail.com>
Date: Wed, 10 Aug 2005 17:50:38 -0700
From: steve roussey <iamstever@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Question about SO_LINGER
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a conversation the other yesterday about web servers, this came up
in conversation by another much more informed than I. I'm not sure if
the information is up to date to current kernel builds, so I pose the
question here: Does the linux kernel block on SO_LINGER?

Here is paragraph in the other conversation:

"The big problem is that most operating systems, for reasons I have never
understood, block on the close when SO_LINGER is set on it.  I always
thought that made absolutely no sense and is something the damn kernel's
stack should just take care of, but it doesn't, and you end up sitting
around twiddling your thumbs in userspace waiting for the lingering
socket to shut down.  Apache has a workaround called lingering_close()
that tries to address broken SO_LINGER implementations, but it also blocks."

I was guessing (but did not ask) that this information came from
apache so I grabbed this from apache's comments:

 * In an ideal world, this function would be accomplished by simply
 * setting the socket option SO_LINGER and handling it within the
 * server's TCP stack while the process continues on to the next request.
 * Unfortunately, it seems that most (if not all) operating systems
 * block the server process on close() when SO_LINGER is used.
 * For those that don't, see USE_SO_LINGER below.  For the rest,
 * we have created a home-brew lingering_close.

But when I looked at when this was added, it was around Apache 1.2
(and it references problems with Linux 2.0.31 -- that is has SO_LINGER
but it is faster/better to not use it). Apache 2.x has all of Apache
1.x's comments about this, though their implementation is different
and doesn't match. I'm going to ask them when I get a definitive
answer here.

Thanks,
-steve--
