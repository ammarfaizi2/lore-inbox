Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWIJLVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWIJLVY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 07:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbWIJLVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 07:21:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60093 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750875AbWIJLVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 07:21:23 -0400
Subject: Re: [PATCH RFC]: New termios take 2
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <1157886908.22571.11.camel@localhost.localdomain>
References: <1157472883.9018.79.camel@localhost.localdomain>
	 <1157885180.2977.133.camel@pmac.infradead.org>
	 <1157886908.22571.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 10 Sep 2006 12:20:40 +0100
Message-Id: <1157887240.2977.147.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-10 at 12:15 +0100, Alan Cox wrote:
> Kernel headers are not intended for user space. In this case the struct
> termios presented by glibc already differs from the termios presented by
> the kernel so the problem doesn't arise at all.

Please note that we are moving away from the mindless repetition of that
phrase, and moving towards a system where we actually _mean_ it.

If you really don't want asm/term{bit,io}s.h to be visible in userspace,
then the way to express that is to provide a patch to
include/asm-generic/Kbuild which removes them from the export.

I don't think I agree -- I think these files _do_ provide part of the
kernel<->user ABI and should be kept. You're right that userspace in
_general_ shouldn't be touching them -- as I said, it's only really the
C libraries that are important here. As long as _they_ get it right when
built against the headers with your changes, we're fine.

But I don't think it's realistic to suggest that C libraries should be
built without access to our asm/term{bit,io}s.h at all. However, I'm
only really responsible for the new export _mechanism_ -- I'm not going
to impose policy except when people like Andi do stupid things and
sneakily send private patches to undo fixes I've already made.

So if you want to unexport those headers and make sure the C libraries
work like that, please do go ahead -- but don't just _say_ it, _do_ it
-- and please do make sure that at _least_ glibc still builds
afterwards.

-- 
dwmw2

