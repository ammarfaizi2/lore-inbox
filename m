Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265038AbUHAMdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265038AbUHAMdo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 08:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUHAMdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 08:33:44 -0400
Received: from holomorphy.com ([207.189.100.168]:63141 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265038AbUHAMdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 08:33:43 -0400
Date: Sun, 1 Aug 2004 05:33:34 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2-mm1
Message-ID: <20040801123334.GR2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040728020444.4dca7e23.akpm@osdl.org> <20040801023655.GN2334@holomorphy.com> <20040801010532.37966eda.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040801010532.37966eda.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> There's trouble here with the link checking; it pukes all over
>> sparc32's btfixup stuff. Not entirely sure what the proper form of a
>> solution is.

On Sun, Aug 01, 2004 at 01:05:32AM -0700, Andrew Morton wrote:
> Do you mean the "check vmlinux for undefined symbols" thing?
> That's proving to be a royal pain, although rmk's arguments for needing it
> are good.  Could you find a way of fixing it up?

I may need core help. The executable is postprocessed by a program in
arch/sparc/boot/ and so some kind of hook to give it a chance to
properly fix up the symbol table (which I'll have to add afresh), for
instance, an extra stage of .tmp_vmlinux*, seems to be needed.

It treats vmlinux as a throwaway, and does the real linking pass in
arch/sparc/boot/; exchanging the roles of the top-level and arch
linking phases in the makefiles is all that's needed to fix this up.

Once an optional extra pass is okayed, it's a SMOP to deal with the
rest (i.e. the real undefined symbol).

-- wli
