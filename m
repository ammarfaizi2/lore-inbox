Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVACXvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVACXvr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVACXvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:51:32 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:25231 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262003AbVACXqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:46:45 -0500
Subject: Re: [PATCH] get/set FAT filesystem attribute bits
From: Nicholas Miell <nmiell@comcast.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41D9D3C8.1040602@zytor.com>
References: <41D9B1C4.5050507@zytor.com>
	 <1104787447.3604.9.camel@localhost.localdomain>
	 <41D9BA8B.2000108@zytor.com>
	 <1104788816.3604.17.camel@localhost.localdomain>
	 <41D9C111.2090504@zytor.com>
	 <1104790243.3604.23.camel@localhost.localdomain>
	 <41D9C64E.7080508@zytor.com>
	 <1104794219.3604.29.camel@localhost.localdomain>
	 <41D9D3C8.1040602@zytor.com>
Content-Type: text/plain
Date: Mon, 03 Jan 2005 15:46:41 -0800
Message-Id: <1104796001.3604.51.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-03 at 15:22 -0800, H. Peter Anvin wrote:
> [Pruning the Cc: list.]
> 
> Nicholas Miell wrote:
> > On Mon, 2005-01-03 at 14:25 -0800, H. Peter Anvin wrote:
> > 
> >>I'm honestly not sure that using an ASCII string in an xattr is the sane 
> >>way of doing this.  Even a binary byte in an xattr would make more sense 
> >>in some ways.
> > 
> > ASCII strings require no special tools to manipulate from shell scripts.
> > 
> 
> You need some kind of special tool anyway, i.e. getfattr/setfattr.  What 
> tool you use isn't really important.

I was talking about getdosattr and setdosattr (and the corresponding
pair for every other filesystem with it's own set of special
attributes).

getfattr and setfattr are standard tools already provided with the
distro.

> The fact that getfattr/setfattr can't deal with attributes that aren't 
> ASCII strings seem like flaws in these tools.

They can. Non-ASCII xattrs are either base64 encoded or octal escaped.

Try

getfattr -n system.posix_acl_access some_file_with_an_acl
getfattr -e text -n system.posix_acl_access some_file_with_an_acl

for a quick example.

> > The design does allow users to store whatever they want as an xattr
> > without having to worry about how the kernel chooses to interpret it,
> > though. (i.e. the user namespace is just a byte array that the kernel
> > stores for you, while the system/security namespaces are probably
> > generated and interpreted on demand.)
>  >
> 
> Exactly, and that's a total screwup.  It makes something that would 
> otherwise be possible -- for some filesystems to have an attribute (call 
> it "system.dosattrib") which is used, and for others which is stored. 
> The problem is that with the current design, that won't happen.
> 

I responded to this in the other thread already.

> Encoding this in the namespace, therefore preventing this kind of 
> compatiblity, is daft.  From the looks of it, the CIFS people were 
> planning to do the "put everything in user.*" workaround for this design 
> error.
> 



> 	-hpa
-- 
Nicholas Miell <nmiell@comcast.net>

