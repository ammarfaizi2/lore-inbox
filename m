Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267151AbSLaEly>; Mon, 30 Dec 2002 23:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267153AbSLaElx>; Mon, 30 Dec 2002 23:41:53 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:60856
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S267151AbSLaElw>; Mon, 30 Dec 2002 23:41:52 -0500
Message-ID: <3E1121F7.60808@redhat.com>
Date: Mon, 30 Dec 2002 20:49:59 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021224
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Jakub Jelinek <jakub@redhat.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: glibc binaries w/ sysenter support
References: <Pine.LNX.4.44.0212301838050.1614-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212301838050.1614-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>  can you tell me what the new glibc does for different "clone()" system
> calls?

clone() and vfork() both use int $0x80.  The vfork() problem is obvious.
And the way we use clone() with a separate stack for the child it is
easy to see that we cannot prepare the stack appropriately for both
situations.  When the child is started it returns with a carefully
crafted stack which among other values find the start functions address
on the stack.

There might be a way to make this use int and vsyscall at the same time
but I don't think it is worth it.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

