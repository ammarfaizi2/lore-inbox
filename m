Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264692AbUEKOTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbUEKOTD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 10:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264736AbUEKOTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 10:19:03 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:5030 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S264692AbUEKOTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 10:19:01 -0400
Date: Tue, 11 May 2004 10:18:47 -0400
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040511141847.GA13217@delft.aura.cs.cmu.edu>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <20040508224835.GE29255@atrey.karlin.mff.cuni.cz> <20040510155359.GB16182@wohnheim.fh-wedel.de> <20040510192601.GA11362@delft.aura.cs.cmu.edu> <20040511100232.GA31673@wohnheim.fh-wedel.de> <20040511140853.GT24211@delft.aura.cs.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040511140853.GT24211@delft.aura.cs.cmu.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot a somewhat useful line there,

On Tue, May 11, 2004 at 10:08:53AM -0400, Jan Harkes wrote:
> int my_file_sendfile(struct file *in_file, loff_t *ppos, size_t count,
> 		     read_actor_t actor, void __user *target)
> {
>     struct file *out_file = NULL;
> 
>     /* We have to check the read_actor callback function to see if the
>      * target actually points at a struct file. */
>     if (actor != file_send_actor)
> 	goto copy_local;

      out_file = (struct file *)target;

>     /* are both source and destination within the same file system
>      * mountpoint? */
>     if (in_file->f_dentry->d_inode->i_sb != out_file->f_dentry->d_inode->i_sb)
> 	goto copy_local;

