Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263195AbUC2Xwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 18:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263196AbUC2Xwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 18:52:46 -0500
Received: from holomorphy.com ([207.189.100.168]:36510 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263195AbUC2Xwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 18:52:45 -0500
Date: Mon, 29 Mar 2004 15:52:33 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Paul Jackson <pj@sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH] mask ADT: bitmap and bitop tweaks [1/22]
Message-ID: <20040329235233.GV791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Matthew Dobson <colpatch@us.ibm.com>, Paul Jackson <pj@sgi.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>
References: <20040329041249.65d365a1.pj@sgi.com> <1080601576.6742.43.camel@arrakis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1080601576.6742.43.camel@arrakis>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 03:06:16PM -0800, Matthew Dobson wrote:
> Do we need to check the last word specially?  If we're assuming that the
> unused bits are 0's, then they can't affect the check, right?  If we're
> not assuming the unused bits are 0's, then we need to do this last word
> special casing in bitmap_xor & bitmap_andnot, because they could set the
> unused bits.  Or am I confused?

No, not those two. xor of 0's is 0 again. and of 0 and anything is 0 again.
xornot and ornot would need those checks if implemented.


On Mon, Mar 29, 2004 at 03:06:16PM -0800, Matthew Dobson wrote:
> Same comments here, both the double ';' and the last word special
> casing...
> Looking ahead, patch 2/22 specifically states that we assume all our
> input masks have the high/unused bits cleared and we promise not to set
> them.  So we shouldn't need the last word special casing in
> bitmap_intersect & bitmap_subset...  I think. ;)

It looks like Paul wants those invariants. Which is fine; I can do things
on behalf of users, or stand back and let them do things themselves.

You're right that intersection (and) and subset (andnot) shouldn't require
any special cases for the final word.


-- wli
