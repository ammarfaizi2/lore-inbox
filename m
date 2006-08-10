Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161368AbWHJQCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161368AbWHJQCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161369AbWHJQCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:02:49 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:38337 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161368AbWHJQCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:02:48 -0400
Subject: Re: + r-o-bind-mount-clean-up-ocfs2-nlink-handling.patch added to
	-mm tree
From: Dave Hansen <haveblue@us.ibm.com>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, hch@lst.de, mark.fasheh@oracle.com,
       viro@zeniv.linux.org.uk
In-Reply-To: <1155218195.16579.3.camel@c-67-188-28-158.hsd1.ca.comcast.net>
References: <200608091912.k79JCnGh027465@shell0.pdx.osdl.net>
	 <1155218195.16579.3.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 09:02:37 -0700
Message-Id: <1155225757.19249.232.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 06:56 -0700, Daniel Walker wrote:
> On Wed, 2006-08-09 at 12:12 -0700, akpm@osdl.org wrote:
> > -	/* We can set nlink on the dinode now. clear the saved version
> > -	 * so that it doesn't get set later. */
> > +	if (S_ISDIR(inode->i_mode))
> > +		drop_nlink(inode);
> > +	drop_nlink(inode);
> >  	fe->i_links_count = cpu_to_le16(inode->i_nlink);
> > -	saved_nlink = 0;
> >  
> >  	status = ocfs2_journal_dirty(handle, fe_bh);
>
> There's one too many drop_nlink()'s in this block, unless I'm not
> reading this right.

It needs to be double-dropped for any directory inodes.  Some of the
older code just did i_nlink-=2, and I chose to just call drop_nlink()
twice instead of making another helper to do arbitrary arithmetic on
i_nlink.

I believe this made up for the 

        if (S_ISDIR(inode->i_mode))
                inode->i_nlink = 0;

in the old code.

-- Dave

