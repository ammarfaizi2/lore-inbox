Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751148AbWHBEeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbWHBEeq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 00:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWHBEeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 00:34:46 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:5445 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751148AbWHBEep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 00:34:45 -0400
Date: Tue, 1 Aug 2006 21:34:27 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, herbert@13thfloor.at,
       hch@infradead.org
Subject: Re: [PATCH 04/28] OCFS2 is screwy
Message-ID: <20060802043427.GH29686@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060801235240.82ADCA42@localhost.localdomain> <20060801235243.EA4890B4@localhost.localdomain> <20060802021411.GG29686@ca-server1.us.oracle.com> <1154488906.7232.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154488906.7232.20.camel@localhost.localdomain>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Tue, Aug 01, 2006 at 08:21:46PM -0700, Dave Hansen wrote:
> Please ignore that last one.  It didn't correctly handle directories'
> with a remaining i_nlink of 2.
Thanks for following up with this patch - it looks pretty good. One comment
below.


> @@ -888,7 +890,9 @@
>  	/* We can set nlink on the dinode now. clear the saved version
>  	 * so that it doesn't get set later. */
>  	fe->i_links_count = cpu_to_le16(inode->i_nlink);
> -	saved_nlink = 0;
> +	inode_drop_nlink(inode);
> +	if (S_ISDIR(inode->i_mode))
> +		inode_drop_nlink(inode);
The set of 'i_links_count' on 'fe' should be below the inode_drop_nlink()
calls - otherwise we'll be setting the old nlink value on the disk inode :)

While you're there you can just remove that comment - it's no longer
accurate :)

Thanks again,
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
