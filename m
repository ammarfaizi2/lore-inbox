Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTLIDAD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 22:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTLIDAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 22:00:03 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:46977 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262591AbTLIDAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 22:00:00 -0500
Date: Tue, 9 Dec 2003 02:59:52 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Nikita Danilov <Nikita@Namesys.COM>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org
Subject: Re: const versus __attribute__((const))
Message-ID: <20031209025952.GA26439@mail.shareable.org>
References: <200312081646.42191.arnd@arndb.de> <3FD4B9E6.9090902@zytor.com> <16340.49791.585097.389128@laputa.namesys.com> <3FD4C375.2060803@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FD4C375.2060803@zytor.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Actually, the reason it doesn't use it for the inlines is because it 
> doesn't need to -- it already has full visibility, so it doesn't need it 
> to be spelled out.

Until a few minutes ago, I disagreed.  I thought GCC wouldn't
eliminate calls to inline functions which contain an inline asm, such
as current_thread_info().

But having just looked, multiple calls to current_thread_info() are
eliminated.  GCC inspects the arguments of the inline asm which is the
body of this function, and concludes that the asm itself is to be
optimised like a const function, depending only on its input operands.

In fact to get GCC to _not_ optimise away inline asms, or even to
behave like "pure" (allowing memory to be read) instead of "const",
they must be declared volatile, or have no outputs.  Putting "memory"
in the clobber list says only that the asm clobbers memory, not that
it reads memory.

It would be nice to have a way to declare an asm like "pure" not
"const", so that it's allowed to read memory but multiple calls can be
eliminated; I don't know of a way to express that.

-- Jamie
