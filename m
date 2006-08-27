Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWH0SgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWH0SgM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 14:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWH0SgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 14:36:12 -0400
Received: from ns2.suse.de ([195.135.220.15]:59082 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932248AbWH0SgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 14:36:10 -0400
From: Andi Kleen <ak@suse.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: Re: [PATCH RFC 0/6] Implement per-processor data areas for i386.
Date: Sun, 27 Aug 2006 20:35:34 +0200
User-Agent: KMail/1.9.3
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
References: <20060827084417.918992193@goop.org> <200608272004.38280.ak@suse.de> <20060827182708.GB12642@rhlx01.fht-esslingen.de>
In-Reply-To: <20060827182708.GB12642@rhlx01.fht-esslingen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608272035.34839.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 August 2006 20:27, Andreas Mohr wrote:
> Hi,
> 
> On Sun, Aug 27, 2006 at 08:04:38PM +0200, Andi Kleen wrote:
> > 
> > > Something like that had to be done eventually about the inefficient
> > > current_thread_info() mechanism, 
> > 
> > Inefficient? It's two fast instructions. I won't call that inefficient.
> 
> And that AGI stall?

What AGI stall?

[btw AGI stall is an outdated concept on modern x86 CPUs]

> > > I guess it's due to having tried that on an older installation with gcc 3.2,
> > > which probably does less efficient opcode merging of current_thread_info()
> > > requests compared to a current gcc version.
> > 
> > gcc normally doesn't merge inline assembly at all.
> 
> Depends on use of volatile, right?

No.  It can only merge statements it knows anything about, and it doesn't
about inline assembly.

> OK, so probably there was no merging of separate requests,
> but opcode intermingling could have played a role.

It seems to make some difference if it's able to move asm around
and if they don't have memory clobbers. memory clobbers really seem
to cause much worse code in the whole function.

But current_thread_info didn't have that.

-Andi

