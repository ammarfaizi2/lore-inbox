Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263927AbUAMKp1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 05:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263963AbUAMKp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 05:45:27 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52781 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263927AbUAMKpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 05:45:15 -0500
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stronger ELF sanity checks v2
References: <Pine.LNX.4.56.0401130228490.2265@jju_lnx.backbone.dif.dk>
	<20040113033234.GD2000@vitelus.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Jan 2004 03:39:11 -0700
In-Reply-To: <20040113033234.GD2000@vitelus.com>
Message-ID: <m1brp8gmk0.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Lehmann <aaronl@vitelus.com> writes:

> On Tue, Jan 13, 2004 at 02:55:07AM +0100, Jesper Juhl wrote:
> > Here's the second version of my patch to add better sanity checks for
> > binfmt_elf
> 
> I assume this breaks Brian Raiter's tiny ELF executables[1]. 

Hmm. I would expect most of the to continue to work because they
are valid.  The only problem I see is when he starts scrunching
things together by changing the value of fields that have a specified
meaning.

> Even
> though these binaries are evil hacks that don't comply to standards
> and serve no serious purpose, I'm not sure what the purpose of the
> sanity checks is. Are there any risks associated with running
> non-compliant ELF executables? 

Sanity checks are always good for future compatibility so someone does
not come to rely on your bugs.  This is less of a problem in linux than
in some systems but still.  This is the primary reason cpus have undefined
opcode exceptions for example.

> (Now that I mention it, the
> proof-of-concept exploit for the brk() hole comes to mind, but I don't
> know offhand if that did anything against the spec.) I don't mean to
> question the usefulness of your work, especially as I don't know much
> about ELF, but I'm personally curious about why you think additional
> sanity checks are worth a slight increase in code complexity.

That was my impression as well.  Increasing the complexity of the
if statements when goto's are already in use seems silly.

Eric
