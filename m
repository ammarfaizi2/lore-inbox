Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751530AbVKBXt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbVKBXt7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 18:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbVKBXt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 18:49:59 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:55188 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751253AbVKBXt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 18:49:58 -0500
Date: Thu, 3 Nov 2005 10:49:56 +1100
From: Nathan Scott <nathans@sgi.com>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: XFS information leak during crash
Message-ID: <20051103104956.B6081538@wobbly.melbourne.sgi.com>
References: <20051102212722.GC6759@fi.muni.cz> <20051103101107.O6239737@wobbly.melbourne.sgi.com> <20051102233629.GD6759@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20051102233629.GD6759@fi.muni.cz>; from kas@fi.muni.cz on Thu, Nov 03, 2005 at 12:36:29AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 12:36:29AM +0100, Jan Kasprzak wrote:
> ...
> 	Yes, of course. However, the issue is probably much worse
> on XFS, because on XFS it probably affects not only the files being
> created/extended, but also the files being rewritten. Most other

No, thats not correct - XFS behaves as most filesystems do and
will write over the top of existing data.

> filesystems rewrite the files in-place, so when you rewrite the file,
> even with data=writeback you get only the mix of the old and new
> contents. Not somebody else's random data.

XFS also rewrites files in-place.  You will never get someone else's
current data (that would be metadata corruption...), it would only
ever be uninitialised, previously-free space.  But as I said, other
filesystems have the same window in which this can happen (in the
absence of stronger data ordering/journalling semantics, of course).

cheers.

-- 
Nathan
