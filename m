Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271860AbTGRP6d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269950AbTGRP4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:56:40 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:13820 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S271815AbTGRPzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 11:55:54 -0400
Subject: Re: NFS structure allocation alignment patch
From: David Woodhouse <dwmw2@infradead.org>
To: Richard Curnow <Richard.Curnow@superh.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mundt <lethal@linux-sh.org>,
       Ben Gaster <Benedict.Gaster@superh.com>,
       Sean McGoogan <sean.mcgoogan@superh.com>,
       Boyd Moffat <boyd.moffat@superh.com>
In-Reply-To: <20030716150326.GA320@malvern.uk.w2k.superh.com>
References: <20030630135233.GN5586@malvern.uk.w2k.superh.com>
	 <1057835121.21073.208.camel@passion.cambridge.redhat.com>
	 <20030716150326.GA320@malvern.uk.w2k.superh.com>
Content-Type: text/plain
Message-Id: <1058544639.29924.15.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Fri, 18 Jul 2003 17:10:39 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-16 at 16:03, Richard Curnow wrote:
> Apart from this issue, we haven't seen any code- or compiler-related
> problems due to misaligned loads and stores occurring.

That doesn't mean they don't exist. Various parts of the network code
_require_ alignment fixups -- the common case is that it'll be aligned,
and we take the hit only in the _rare_ case of misalignment rather than
using get_unaligned() in the fast path.

Also the flash code does the same in places too. It _did_ use
get_unaligned() for a while but it was removed since it's never valid
for an architecture to _not_ fix up unaligned in-kernel accesses.

> I bet someone will wonder how the misalignment hadn't shown up before.

Because all other architectures implement alignment fixups.

-- 
dwmw2

