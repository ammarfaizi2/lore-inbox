Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317888AbSIERRk>; Thu, 5 Sep 2002 13:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317946AbSIERRk>; Thu, 5 Sep 2002 13:17:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7692 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317888AbSIERRk>; Thu, 5 Sep 2002 13:17:40 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [reiserfs-dev] Re: [PATCH] sparc32: wrong type of nlink_t
Date: Thu, 5 Sep 2002 17:24:52 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <al8414$a39$1@penguin.transmeta.com>
References: <3D76A6FF.509@namesys.com> <20020905054008.GH24323@louise.pinerecords.com> <20020904.223651.79770866.davem@redhat.com> <20020905135442.A19682@namesys.com>
X-Trace: palladium.transmeta.com 1031246506 19155 127.0.0.1 (5 Sep 2002 17:21:46 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 5 Sep 2002 17:21:46 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020905135442.A19682@namesys.com>,
Oleg Drokin  <green@namesys.com> wrote:
>
>Ok, since I really like this approach, below is the patch (for 2.4) that
>demonstrates my solution.

No, please just change i_nlink in <linux/fs.h> to be an "unsigned int"
instead.

The kernel internal VFS layers should not care about the fact that
nlink_t is of a limited type - the same way we internally can use larger
inode numbers than the old stat interfaces export. I'm already using a
32-bit i_nlink in my tree on 2.5.x for other reasons (/proc overflow
with hundreds of thousands of threads), we should internally be able to
handle them even if the external interfaces have problems.

(Besides, almost nobody in user space cares about i_nlink.  And as long
as the kernel internally doesn't care, if you actually have people with
nlink values in the >16-bit range, they can at least work around the few
problems they might have by using things like "-noleaf" for their find
commands. 

		Linus
