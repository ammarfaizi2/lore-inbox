Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbWCWBhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbWCWBhJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 20:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWCWBhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 20:37:09 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:165 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932502AbWCWBhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 20:37:07 -0500
Date: Thu, 23 Mar 2006 12:36:31 +1100
From: David Chinner <dgc@sgi.com>
To: xfs-masters@oss.sgi.com
Cc: Nathan Scott <nathans@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [xfs-masters] Re: [PATCH] xfs: kill kmem_zone init
Message-ID: <20060323013631.GF1173973@melbourne.sgi.com>
References: <Pine.LNX.4.58.0603201501540.18684@sbz-30.cs.Helsinki.FI> <20060321082037.A653275@wobbly.melbourne.sgi.com> <Pine.LNX.4.58.0603210859450.14023@sbz-30.cs.Helsinki.FI> <20060322085520.A664708@wobbly.melbourne.sgi.com> <Pine.LNX.4.58.0603220932230.27326@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0603220932230.27326@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 09:37:33AM +0200, Pekka J Enberg wrote:
> Would 
> you accept patches to convert code under PF_FSTRANS to use KM_NOFS so we 
> can kill the check in kmem_flags_convert()?

No.

XFS is full of code that can be called under both PF_FSTRANS and
!PF_FSTRANS contexts and hence recursion during allocation is
context dependent. Rather than pollute >20 call sites throughout XFS
with this check it got put in common code. Makes sense, yes?

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
