Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752030AbWISEB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbWISEB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 00:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbWISEB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 00:01:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:6787 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1752030AbWISEB6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 00:01:58 -0400
Date: Tue, 19 Sep 2006 14:01:32 +1000
From: David Chinner <dgc@sgi.com>
To: David Howells <dhowells@redhat.com>
Cc: David Chinner <dgc@sgi.com>, "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>,
       linux-kernel@vger.kernel.org, xfs-masters@oss.sgi.com, akpm@osdl.org
Subject: Re: [PATCH 5 of 11] XFS: Use SEEK_{SET, CUR, END} instead of hardcoded values
Message-ID: <20060919040132.GI3034@melbourne.sgi.com>
References: <20060918033431.GV3034@melbourne.sgi.com> <patchbomb.1158455366@turing.ams.sunysb.edu> <4cdee5980dad9980ec8f.1158455371@turing.ams.sunysb.edu> <2442.1158575435@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2442.1158575435@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2006 at 11:30:35AM +0100, David Howells wrote:
> David Chinner <dgc@sgi.com> wrote:
> 
> > The hard coded values  used in xfs_change_file_space() are documented as part
> > of the API to the userspace functions that use this interface in xfsctl(3).
> 
> Hmmm... that's a good point.  I think you're right on this account, and so the
> comments in:
> 
> 		case 0: /*SEEK_SET*/
> 			break;
> 		case 1: /*SEEK_CUR*/
> 			bf->l_start += offset;
> 			break;
> 		case 2: /*SEEK_END*/
> 			bf->l_start += ip->i_d.di_size;
> 			break;
> 
> should be stripped off as they are not exactly correct.

Sure, they're not _exactly_ the same as seek semantics, but the
comment is informative enough to tell you what the magic numbers
are supposed to mean as you read the code.

If you really want to strip these out these comments, can you please
replace them with a new comment that documents the magic number
behaviour?

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
