Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266176AbUHAVKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266176AbUHAVKl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 17:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266177AbUHAVKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 17:10:41 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:13462 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266176AbUHAVKj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 17:10:39 -0400
Date: Sun, 1 Aug 2004 23:11:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rmk-lkml@arm.linux.org.uk
Subject: Re: 2.6.8-rc2-mm1
Message-ID: <20040801211146.GA7954@mars.ravnborg.org>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	rmk-lkml@arm.linux.org.uk
References: <20040728020444.4dca7e23.akpm@osdl.org> <20040801023655.GN2334@holomorphy.com> <20040801010532.37966eda.akpm@osdl.org> <20040801123334.GR2334@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040801123334.GR2334@holomorphy.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 01, 2004 at 05:33:34AM -0700, William Lee Irwin III wrote:
> William Lee Irwin III <wli@holomorphy.com> wrote:
> >> There's trouble here with the link checking; it pukes all over
> >> sparc32's btfixup stuff. Not entirely sure what the proper form of a
> >> solution is.
> 
> On Sun, Aug 01, 2004 at 01:05:32AM -0700, Andrew Morton wrote:
> > Do you mean the "check vmlinux for undefined symbols" thing?
> > That's proving to be a royal pain, although rmk's arguments for needing it
> > are good.  Could you find a way of fixing it up?
> 
> I may need core help. The executable is postprocessed by a program in
> arch/sparc/boot/ and so some kind of hook to give it a chance to
> properly fix up the symbol table (which I'll have to add afresh), for
> instance, an extra stage of .tmp_vmlinux*, seems to be needed.

Took a look at this and atm compiling a sparc tool-chain to try it out.
What about moving the check added by rmk to kallsyms.c?
This would remove the extra pass on vmlinux which is for no use for
most people anyway. On the other hand an error could go unpassed
because we (for now) do not do the kallsyms stuff if not configured in.

We could make the kallsyms run independent on the configuration, but
only link in the symbols if required to do so.
This would also allow us to have architecture specific final-linking
rules in one place if sparc needs special rules.
Today kallsyms already knows about 'SDA_BASE*_' only valid for ppc.

wli - can you post the output of a failing sparc compile?

	Sam
