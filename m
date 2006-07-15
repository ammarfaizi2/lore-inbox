Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161248AbWGOHUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161248AbWGOHUO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 03:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161270AbWGOHUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 03:20:13 -0400
Received: from canuck.infradead.org ([205.233.218.70]:23234 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1161248AbWGOHUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 03:20:12 -0400
Subject: Re: 2.6.18 Headers - Long
From: David Woodhouse <dwmw2@infradead.org>
To: Jim Gifford <maillist@jg555.com>
Cc: David Miller <davem@davemloft.net>, arjan@infradead.org,
       linux-kernel@vger.kernel.org, ralf@linux-mips.org
In-Reply-To: <44B80543.4050608@jg555.com>
References: <44B7F062.8040102@jg555.com>
	 <1152905987.3159.46.camel@laptopd505.fenrus.org>
	 <1152908202.3191.98.camel@pmac.infradead.org>
	 <20060714.131957.57444250.davem@davemloft.net> <44B80543.4050608@jg555.com>
Content-Type: text/plain
Date: Sat, 15 Jul 2006 08:19:42 +0100
Message-Id: <1152947982.3191.116.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 13:57 -0700, Jim Gifford wrote:
> Do we have a list of what headers are "user-space" and which ones should 
> not be "user-space"?

Well, we have the lists in include/*/Kbuild files, of course -- but
that's all. As I've stated before, I've been somewhat liberal with the
exports to far, to match what's currently (ab)used, because I wanted to
concentrate on the _mechanism_, not the policy.

The intention is that we can now start to tighten it up -- I've already
sent the patches which drop asm/atomic.h and asm/io.h, and there are
more which should go. Next on that list (and already commented as such
in include/asm-generic/Kbuild.asm) are asm/page.h and asm/elf.h.

> Also David W, let me know what I can do to help you out, a lot of people 
> on my end want to get this working properly.

Thanks. One thing you can do which would be extremely useful is to
investigate dropping page.h and elf.h, and make sure that stuff like gdb
(and anything using ptrace.h) will still build. Then just look for
anything else which should be removed from view. The git repository at
http://git.kernel.org/git/?p=linux/kernel/git/dwmw2/kernel-headers.git
(git://git.kernel.org/pub/scm/linux/kernel/git/dwmw2/kernel-headers.git)
should help with that task. Provide patches to move stuff within #ifdef
__KERNEL__ or to move it to unexported files.

There are some who think that it would be nice to get rid of __KERNEL__
entirely -- files would be either entirely exported, or not at all. I
don't think we necessarily need to go that far; the export step with
unifdef isn't so bad.

-- 
dwmw2

