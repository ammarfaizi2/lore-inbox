Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751644AbWF1Wlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbWF1Wlm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 18:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751643AbWF1Wlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 18:41:42 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49085 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751644AbWF1Wll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 18:41:41 -0400
Date: Thu, 29 Jun 2006 08:41:28 +1000
From: Nathan Scott <nathans@sgi.com>
To: Erik Frederiksen <erik_frederiksen@pmc-sierra.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IS_ERR Threshold Value
Message-ID: <20060629084128.C1344246@wobbly.melbourne.sgi.com>
References: <1151528227.3904.1110.camel@girvin.pmc-sierra.bc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1151528227.3904.1110.camel@girvin.pmc-sierra.bc.ca>; from erik_frederiksen@pmc-sierra.com on Wed, Jun 28, 2006 at 02:57:07PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erik,

On Wed, Jun 28, 2006 at 02:57:07PM -0600, Erik Frederiksen wrote:
> 
> from include/asm-mips/errno.h
> #define EDQUOT      1133    /* Quota exceeded */
> 
> I noticed that the errno value for EDQUOT on MIPS is considerably larger
> than all others.  This can lead to a situation where functions using
> ERR_PTR() to return error codes in pointers cannot return this error
> code without IS_ERR() thinking that the pointer is valid.  In my case,
> it caused an alignment exception in the XFS open call when quota has
> been exceeded in the linux-mips 2.6.14 kernel.  I think that the XFS
> code has changed enough that this bug isn't in newer versions, though I
> haven't done a thorough investigation.  

Hmm, I'm not sure I understand the XFS side of your report here - on
open, for quota to be coming into play we must be creating a new inode
and those code paths inside XFS have no use of IS_ERR/ERR_PTR magic...
did you mean there's generic problems here (I can see those macros are
used in the generic VFS open() code) ... or am I missing your point?

thanks.

-- 
Nathan
