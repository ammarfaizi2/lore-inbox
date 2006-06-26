Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWFZWYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWFZWYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWFZWYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:24:54 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:20147 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751269AbWFZWYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:24:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XqeIbk259ejFDtOMrq6X583IM/8d083H16dUKZDd46NlxIsGpb63MrTHki2k/zfSd+9OTxLD9gVM5Z1wLxpI8UVfb0Chwc03ghChIWfQUka/zUp2Jiw9nBTb2lXIprDX3WZLzhz+Pq9/2gCVJahenhqlxeaIO0RuKJ8BwTiHEzM=
Message-ID: <6bffcb0e0606261524l44ef1ce0r1f11f32b4d87c716@mail.gmail.com>
Date: Tue, 27 Jun 2006 00:24:53 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Linus Torvalds" <torvalds@osdl.org>
Subject: Re: oom-killer problem
Cc: "Sam Ravnborg" <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0606261335230.3927@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6bffcb0e0606261306i7f5a3326oa0c7f53aac2aa18d@mail.gmail.com>
	 <Pine.LNX.4.64.0606261335230.3927@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Mon, 26 Jun 2006, Michal Piotrowski wrote:
> >
> > I have noticed a small problem with
> > 2.6.17-5fd571cbc13db113bda26c20673e1ec54bfd26b4 - in fact, it doesn't
> > work.
>
> Well, it looks to me like you have IDE problems (and shaky hands ;)
>
> Can you pinpoint when these things started happening? "git bisect" is your
> friend..

[michal@ltg01-fedora linux-git]$ git-bisect bad
e5c44fd88c146755da6941d047de4d97651404a9
e5c44fd88c146755da6941d047de4d97651404a9 is first bad commit
commit e5c44fd88c146755da6941d047de4d97651404a9
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sat Jun 24 22:50:18 2006 +0200

    kbuild: fix make -rR breakage

    make failed to supply the filename when using make -rR and using $(*F)
    to get target filename without extension.
    This bug was not reproduceable in small scale but using:
    $(basename $(notdir $@)) fixes it with same functionality.

    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

:040000 040000 88f5ba77585f29510879579cf2737470e4f5eaef
a7e1133f110192016e5a34b123eb8929c2f5d40e M      scripts

Please revert this commit.


BTW "git show e5c44fd88c146755da6941d047de4d97651404a9" doesn't show
any IDE specific changes.

>
>                 Linus
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
