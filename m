Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVGFGjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVGFGjQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 02:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbVGFGfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 02:35:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58795 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262085AbVGFFD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 01:03:56 -0400
Date: Wed, 6 Jul 2005 14:56:52 +1000
From: Nathan Scott <nathans@sgi.com>
To: Nicholas Hans Simmonds <nhstux@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Andrew G. Morgan" <morgan@transmeta.com>,
       Alexander Kjeldaas <astor@guardian.no>
Subject: Re: [PATCH] Filesystem capabilities support
Message-ID: <20050706045652.GB1773@frodo>
References: <20050702214108.GA755@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050702214108.GA755@laptop>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicholas,

On Sat, Jul 02, 2005 at 10:41:08PM +0100, Nicholas Hans Simmonds wrote:
> This is a simple attempt at providing capability support through extended
> attributes.
> ...
> +#define XATTR_CAP_SET XATTR_SECURITY_PREFIX "cap_set"
> ...
> +	ret = bprm_getxattr(bprm_dentry,XATTR_CAP_SET,&caps,sizeof(caps));
> +	if(ret == sizeof(caps)) {
> +		if(caps.version == _LINUX_CAPABILITY_VERSION) {
> +			cap_t(bprm->cap_effective) &= caps.mask_effective;
> ...

Since this is being stored on-disk, you may want to consider
endianness issues.  I guess for binaries this isn't really a
problem (since they're unlikely to be run on other platforms),
though perhaps it is for shell scripts and the like.  Storing
values in native endianness poses problems for backup/restore
programs, NFS, etc.

IIRC, the other LSM security attribute values are stored as
ASCII strings on-disk to avoid this sort of issue.

cheers.

-- 
Nathan
