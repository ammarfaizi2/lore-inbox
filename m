Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161285AbWHJN4p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161285AbWHJN4p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161273AbWHJN4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:56:44 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:25870 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1161285AbWHJN4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:56:44 -0400
Subject: Re: + r-o-bind-mount-clean-up-ocfs2-nlink-handling.patch added to
	-mm tree
From: Daniel Walker <dwalker@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: haveblue@us.ibm.com, hch@lst.de, mark.fasheh@oracle.com,
       viro@zeniv.linux.org.uk
In-Reply-To: <200608091912.k79JCnGh027465@shell0.pdx.osdl.net>
References: <200608091912.k79JCnGh027465@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 06:56:34 -0700
Message-Id: <1155218195.16579.3.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 12:12 -0700, akpm@osdl.org wrote:

> -	/* We can set nlink on the dinode now. clear the saved version
> -	 * so that it doesn't get set later. */
> +	if (S_ISDIR(inode->i_mode))
> +		drop_nlink(inode);
> +	drop_nlink(inode);
>  	fe->i_links_count = cpu_to_le16(inode->i_nlink);
> -	saved_nlink = 0;
>  
>  	status = ocfs2_journal_dirty(handle, fe_bh);


There's one too many drop_nlink()'s in this block, unless I'm not
reading this right.

Daniel

