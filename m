Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269194AbTGJKus (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 06:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269197AbTGJKus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 06:50:48 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:57799 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S269194AbTGJKur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 06:50:47 -0400
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
In-Reply-To: <20030630135233.GN5586@malvern.uk.w2k.superh.com>
References: <20030630135233.GN5586@malvern.uk.w2k.superh.com>
Content-Type: text/plain
Message-Id: <1057835121.21073.208.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.1 (dwmw2) 
Date: Thu, 10 Jul 2003 12:05:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-30 at 14:52, Richard Curnow wrote:
> Hi Trond, Marcelo,
> 
> Below is a patch against 2.4.21 to tidy up the allocation of two
> structures in nfs3_proc_unlink_setup.  We need this change for NFS to
> work on the sh64 architecture, which has just been merged into 2.4 in
> the last couple of days.  Otherwise, 'res' is 4-byte aligned but not
> necessarily 8-byte aligned, but struct nfs_attr contains fields that are
> 8 bytes wide.  This leads to alignment exceptions on loads and stores
> into that structure.

What's wrong with alignment exceptions? They get fixed up by your
exception handler, surely?

If you assert that it's a performance-critical path and hence we
shouldn't be relying on the exception fixup, that's fine -- but in that
case it's not a correctness fix, it's just an optimisation.

-- 
dwmw2

