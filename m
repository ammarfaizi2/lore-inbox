Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265091AbUEYV3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbUEYV3q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUEYV3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:29:46 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:48515
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S265091AbUEYV3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:29:44 -0400
From: Rob Landley <rob@landley.net>
To: Jan Harkes <jaharkes@cs.cmu.edu>,
       =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Date: Fri, 21 May 2004 18:23:12 -0500
User-Agent: KMail/1.5.4
Cc: Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <20040511100232.GA31673@wohnheim.fh-wedel.de> <20040511140853.GT24211@delft.aura.cs.cmu.edu>
In-Reply-To: <20040511140853.GT24211@delft.aura.cs.cmu.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405211823.12230.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 May 2004 09:08, Jan Harkes wrote:

> int my_file_sendfile(struct file *in_file, loff_t *ppos, size_t count,
> 		     read_actor_t actor, void __user *target)
> {
>     struct file *out_file = NULL;
>
>     /* We have to check the read_actor callback function to see if the
>      * target actually points at a struct file. */
>     if (actor != file_send_actor)
> 	goto copy_local;
>
>     /* are both source and destination within the same file system
>      * mountpoint? */
>     if (in_file->f_dentry->d_inode->i_sb !=
> out_file->f_dentry->d_inode->i_sb) goto copy_local;
>
>     /* are we copying the entire source file? */
>     if (*ppos != 0 || count != in_file->f_dentry->d_inode->i_size)
> 	goto copy_local;

Is there a race condition for i_size to change between the api getting called 
and the copy being done?  More to the point, is there some way to specify a 
count of -1 or something to easily say "to end of file"?

Rob
-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)


