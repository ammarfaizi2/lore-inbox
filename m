Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265853AbTIJVxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 17:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbTIJVxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 17:53:22 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:14737 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265854AbTIJVw5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 17:52:57 -0400
Date: Wed, 10 Sep 2003 22:52:26 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Dave Jones <davej@redhat.com>, Mitchell Blank Jr <mitch@sfgoth.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops_in_progress is unlikely()
Message-ID: <20030910215226.GC24258@mail.jlokier.co.uk>
References: <20030907221323.GC28927@redhat.com> <20030910142031.GB2589@elf.ucw.cz> <20030910142308.GL932@redhat.com> <20030910152902.GA2764@elf.ucw.cz> <Pine.LNX.4.53.0309101147040.14762@chaos> <20030910183138.GA23783@mail.jlokier.co.uk> <Pine.LNX.4.53.0309101439390.18459@chaos> <20030910201240.GB24424@mail.jlokier.co.uk> <Pine.LNX.4.53.0309101619020.18924@chaos> <20030910212757.GA257@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910212757.GA257@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> He's right. Even without subsections you can move code somewhere
> outside the function. And gcc should be smart enough to do that.

It is:

	extern int a, b;
	int test()
	{
	  if (__builtin_expect(a > 1, 1))
	    foo();
	  else
	    bar();
	  return b;
	}

Compiles to (with gcc -Os -fomit-frame-pointer):

	test:	cmpl	$1, a
		jle	.L2
		call	foo
	.L3:	movl	b, %eax
		ret
	.L2:	call	bar
		jmp	.L3

Enjoy,
-- Jamie
