Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWIDJ0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWIDJ0H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 05:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWIDJ0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 05:26:07 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:32985 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751265AbWIDJ0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 05:26:02 -0400
Date: Mon, 4 Sep 2006 05:25:34 -0400
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH 05/22][RFC] Unionfs: Copyup Functionality
Message-ID: <20060904092534.GA19836@filer.fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060901014251.GF5788@fsl.cs.sunysb.edu> <Pine.LNX.4.61.0609040852550.9108@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0609040852550.9108@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2006 at 08:59:08AM +0200, Jan Engelhardt wrote:
> >+	newattrs.ia_atime = old_hidden_dentry->d_inode->i_atime;
> >+	newattrs.ia_mtime = old_hidden_dentry->d_inode->i_mtime;
> >+	newattrs.ia_ctime = old_hidden_dentry->d_inode->i_ctime;
> 
> How about,
> 
> 	struct inode *ohi = old_hidden_dentry->d_inode;
> 	newattrs.ia_atime = ohi->i_atime;
> 
> reduces typing a little.

Makes sense.

> >+	} else {
> >+		printk(KERN_ERR "Unknown inode type %d\n",
> >+				old_mode);
> >+		BUG();
> >+	}
> 
> Is BUG the right thing, what do others think? (Using WARN, and set err to
> something useful?)
 
Well, it is definitely a condition which Unionfs doesn't expect - if it
doesn't know about the type, how could it copy it up?
 
> >+	if (!path)
> >+		;
> 
> Woha?!
 
Eeek. Good catch. The 'goto out' disappeared somehow.
 
Thanks for the comments.

Josef 'Jeff' Sipek.
 
-- 
Real Programmers consider "what you see is what you get" to be just as bad a
concept in Text Editors as it is in women. No, the Real Programmer wants a
"you asked for it, you got it" text editor -- complicated, cryptic,
powerful, unforgiving, dangerous.

-- 
VGER BF report: H 0.0308323
