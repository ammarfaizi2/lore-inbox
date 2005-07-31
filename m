Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVGaI20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVGaI20 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 04:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVGaI1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 04:27:34 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:2679 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261845AbVGaI1J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 04:27:09 -0400
Date: Sun, 31 Jul 2005 10:29:24 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: vmlinux.lds.S Distinguish absolute symbols
Message-ID: <20050731082924.GA8409@mars.ravnborg.org>
References: <m1u0id1k47.fsf@ebiederm.dsl.xmission.com> <20050729211954.GA8263@mars.ravnborg.org> <m13bpxgmw9.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m13bpxgmw9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >
> > I recall that when Kai Germaschewski long time ago started the
> > unification of the vmlinux.lds files some people had boot problems
> > exactly because the label was defined inside the section and therefore
> > ld caused it to have another value as if it was placed outside the
> > section.
> 
> I remember seeing something like that.  I don't know if those problems
> apply to a modern ld, but it is certainly worth looking into.
I was googling a bit with no luck.
But apperantly looking at include/asm-generic/vmlinux.lds.h
I'm utterly wrong. It was the other way around that caused problems.

Placing the labels outside {} sometimes gave an unaligned start address,
whereas placing the label inside {} gave the correct address.
At his also makes sense. If ld decide to align a section then it will do
so after a label defined outside the section.

	Sam
