Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWCJIbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWCJIbi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWCJIbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:31:38 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:48768 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751271AbWCJIbh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:31:37 -0500
Date: Fri, 10 Mar 2006 08:31:36 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Kirill Korotaev <dev@openvz.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andrey Savochkin <saw@saw.sw.com.sg>, devel@openvz.org
Subject: Re: [PATCH] ext3: ext3_symlink should use GFP_NOFS allocations inside
Message-ID: <20060310083136.GW27946@ftp.linux.org.uk>
References: <441133FD.2070808@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441133FD.2070808@openvz.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 11:08:29AM +0300, Kirill Korotaev wrote:
> +	page = find_or_create_page(mapping, 0,
> +			mapping_gfp_mask(mapping) | gfp_mask);

> +int page_symlink(struct inode *inode, const char *symname, int len)
> +{
> +	return __page_symlink(inode, symname, len, GFP_KERNEL);

s/GFP_KERNEL/0/; if somebody has e.g. GFP_NOFS in their mapping flags,
you end up breaking their code.  We really pass extra flags to be added
to default ones; page_symlink() should pass 0.
