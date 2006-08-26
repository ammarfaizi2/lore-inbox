Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751192AbWHZCdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWHZCdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 22:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbWHZCdd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 22:33:33 -0400
Received: from mother.openwall.net ([195.42.179.200]:4319 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1751192AbWHZCdd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 22:33:33 -0400
Date: Sat, 26 Aug 2006 06:29:55 +0400
From: Solar Designer <solar@openwall.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Ernie Petrides <petrides@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: printk()s of user-supplied strings (Re: [PATCH] binfmt_elf.c : the BAD_ADDR macro again)
Message-ID: <20060826022955.GB21620@openwall.com>
References: <20060822030755.GB830@openwall.com> <200608222023.k7MKNHpH018036@pasta.boston.redhat.com> <20060824164425.GA17692@openwall.com> <20060824164633.GA21807@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824164633.GA21807@1wt.eu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 06:46:33PM +0200, Willy Tarreau wrote:
> On Thu, Aug 24, 2006 at 08:44:25PM +0400, Solar Designer wrote:
> > Yet there are lots of such printk()s - and I suggest that we make a
> > determination on all of them before we possibly start fixing individual
> > ones.  In fact, perhaps there are too many of them to be fixing any in
> > 2.4, unless we determine to somehow harden printk() itself.
> > 
> > Even current->comm is untrusted user input, but there are at least 58
> > printk()s of it in 2.4.33.  (58 is the number spotted by a grep that
> > would only match those that have current->comm on the same line with
> > printk itself.)
> 
> I still fail to imagine a useful case for printk("%s") to output non-printable
> chars verbatim. I really think that the right solution would be for printk()
> to output all non-printable chars escaped (eg: \n, \r, \xXX).

Well, this would be ASCII codes 0 through 0x1f and 0x7f through 0x9f.
Unfortunately, some of the latter correspond to national letters and
other visible characters with weird charsets:

	http://en.wikipedia.org/wiki/Windows_code_page

but perhaps it is OK to not support them in kernel logs - syslogd's
printline() would escape them anyway, so we can do it earlier to also
protect the console.

Would you escape backslashes themselves, though?  Perhaps not.  syslogd
(as maintained in Linux sysklogd) doesn't.  Yes, this escaping is not
reliably reversible in that case.

> It would
> definitely fix the problem without removing useful information. I remember
> having had the problem a long time ago with a name extracted from a string
> supplied by the BIOS which mangled the dmesg at early boot.
> 
> It would be too much work (and too risky) to expect from all drivers to check
> their strings for correctness, so the hardening way would be the best one IMHO.

I agree.

Alexander
