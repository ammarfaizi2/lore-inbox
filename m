Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWEDQmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWEDQmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 12:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030216AbWEDQmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 12:42:49 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:7387 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1030220AbWEDQms convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 12:42:48 -0400
Date: Thu, 4 May 2006 09:42:47 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Eric Piel <Eric.Piel@tremplin-utc.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: limits / PIPE_BUF?
In-Reply-To: <4459AA1B.9020207@tremplin-utc.net>
Message-ID: <Pine.LNX.4.58.0605040940200.19371@shell3.speakeasy.net>
References: <Pine.LNX.4.58.0605032244230.25908@shell2.speakeasy.net>
 <4459AA1B.9020207@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2006, Eric Piel wrote:

> 05/04/2006 07:55 AM, Vadim Lobanov wrote/a écrit:
> > Hi,
> Hi!
>
> > A snippet from include/linux/limits.h:
> > #define PIPE_BUF        4096    /* # bytes in atomic write to a pipe */
> >
> > PIPE_BUF is a bit of an oddity. It is defined there, then redefined in
> > the arm header files, even though those header files are never included
> > anywhere.
> Actually, here, on a 2.6.16 source code, PIPE_BUF is used in
> arch/sparc/kernel/sys_sunos.c, arch/sparc64/kernel/sys_sunos32.c, and
> arch/sparc64/solaris/fs.c . It seems it's some kind of compatibility
> value with Sun's OS...

Yes, I saw those. But they're really just "magic numbers" that userland
expects to see. In my opinion, the constant values should be inlined
into that compat code. Or, at best, moved into the sparc compat header
files.

> > Also, PIPE_BUF is never referenced by name in any of the Linux
> > code. And yet, it is still being mentioned in some Big And Scary
> > Warnings (tm): fs/autofs4/waitq.c or include/linux/pipe_fs_i.h, for
> > example.
> Maybe they wanted to say PIPE_BUFFERS ? (just wild guess)

Doesn't look like it to me. PIPE_BUFFERS stands for something else
entirely, if my understanding is correct. PIPE_BUF is the one that
"guarantees" atomicity.

> c u,
> Eric
>

- Vadim Lobanov
