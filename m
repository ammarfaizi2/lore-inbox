Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261564AbREOV2s>; Tue, 15 May 2001 17:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261551AbREOV22>; Tue, 15 May 2001 17:28:28 -0400
Received: from PeeWee.appsig.com ([198.211.246.93]:51614 "EHLO
	PeeWee.appsig.com") by vger.kernel.org with ESMTP
	id <S261559AbREOV2Z>; Tue, 15 May 2001 17:28:25 -0400
Message-ID: <3B019F2E.7CC8C39A@appsig.com>
Date: Tue, 15 May 2001 14:27:10 -0700
From: "Timothy A. Seufert" <tas@appsig.com>
Organization: Applied Signal Technology, Inc.
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.5-pre1 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> wrote:

>On Tue, 15 May 2001, Alexander Viro wrote:
>> Driver can export a tree and we mount it on fb0. After that you have
>> the whole set - yes, /dev/fb0/colourspace, etc. - no problem. And no
>> need to do mknod, BTW. Yes, we'll need to use /dev/fb0/frame for
>> frame itself. BFD...
>
>Actually, we can just continue to use "/dev/fb0", which would continue to
>work the way ti has always worked.
>
>It's a mistake to think that a directory has to be a directory. Or to
>think that a device node has to be a device node. It's perfectly ok to
>just think of it as namespaces. So opening /dev/fb0 continues to open the
>"master fd", whatever that means (in this case, the actual frame
>buffer). The namespaces _under_ /dev/fb0 would be the control channels, or
>in fact _anything_ that the frame buffer driver wants to expose.

Why not take it a step further than just devices?  This is a perfect
model for supporting named forks.

In fact, I believe this is how MacOS X is exposing HFS+ named forks to
the UNIX side of things.  (HFS+ supports not just the old style
Macintosh data and resource forks but an arbitrary number of named
forks.)  So: you open "foo", you get what an older MacOS would consider
the "data" fork.  Open "foo/rsrc" and you get the resource fork.  Open
"foo/joesfork" and you get whatever Joe wanted to use a named fork for.
