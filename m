Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263645AbUD0B0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbUD0B0J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 21:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263655AbUD0B0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 21:26:09 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:57156 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263645AbUD0B0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 21:26:06 -0400
Date: Tue, 27 Apr 2004 11:24:40 +1000
From: Nathan Scott <nathans@sgi.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Return more useful error number when acls are too large
Message-ID: <20040427112440.B604510@wobbly.melbourne.sgi.com>
References: <1082973939.3295.16.camel@winden.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1082973939.3295.16.camel@winden.suse.de>; from agruen@suse.de on Mon, Apr 26, 2004 at 12:27:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Andreas,

On Mon, Apr 26, 2004 at 12:27:58PM +0200, Andreas Gruenbacher wrote:
> Hello,
> 
> could you please add this to mainline? Getting EINVAL when an acl
> becomes too large is quite confusing.
> 
>   	if (acl) {
>  		if (acl->a_count > EXT2_ACL_MAX_ENTRIES)
> -			return -EINVAL;
> +			return -ENOSPC;

That seems an odd error code to change it to, since its not
related to the device running out of free space right?  Maybe
use -E2BIG instead?

XFS has a similar check (different limit as you know), so is
also affected by this; could you update XFS at the same time
with whatever value gets chosen, if its not EINVAL?  Or just
let me know what gets chosen & I'll fix it up later.

thanks.

-- 
Nathan
