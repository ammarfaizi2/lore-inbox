Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268367AbUIBOsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268367AbUIBOsb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 10:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268360AbUIBOsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 10:48:31 -0400
Received: from mailrelay.tu-graz.ac.at ([129.27.3.7]:31264 "EHLO
	mailrelay02.tugraz.at") by vger.kernel.org with ESMTP
	id S268392AbUIBOkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 10:40:08 -0400
From: Christian Mayrhuber <christian.mayrhuber@gmx.net>
To: reiserfs-list@namesys.com, Spam <spam@tnonline.net>
Subject: Re: The argument for fs assistance in handling archives
Date: Thu, 2 Sep 2004 16:38:30 +0200
User-Agent: KMail/1.7
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20040826150202.GE5733@mail.shareable.org> <4699bb7b0409020245250922f9@mail.gmail.com> <812032218.20040902120259@tnonline.net>
In-Reply-To: <812032218.20040902120259@tnonline.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409021638.31161.christian.mayrhuber@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 September 2004 12:02, Spam wrote:
> > As I say I like the idea, but I can't see anyway of implementing it in
> > a way that is useful without first putting considerable effort into at
> > least the VFS if not all the actual fs drivers.
> 
>   Indeed. It is important that something like this gets implemented as
>   a transparent way as possible. If it could be done in a general way
>   so other filesystems like ext3/4 can eventually support it then that
>   would be wonderful. I do not, however, think that we should block it
>   in reiser4 because no other filesystems support it.

What about extending the namespace with leading ".." and "...".

In Unix names starting with a  "." already have the meaning of being a 
hidden/config entry.

A name starting ".." means streams/metainformation, etc. something belonging 
to the file/directory that should get backed up, copied, etc.
There could be a "..streams", "..metas" or a "..acl" entry.

If it starts with "..." it means some system specific information, like the
name of the hash algorithm used for the current directory. It's basically 
information that is not portable and not required by applications, like
"...fsplugins".

There is still the big problem of how to copy files with their associated 
streams or meta information onto a standard unix filesystem as the 
file/directory duality cannot be expressed. (It's forbidden to have
a directory + file with the same name in the same directory)
Maybe copy could create something like a ".#filename" directory for this kind
of information if the advanced features are not supported on the target 
filesystem. This is neither nice nor clean, but at least you don't loose 
information. I do not suggest that the kernel should simulate the advanced 
features with  ".#filename" directories, it's more a backup/restore thing 
that could work if it's written down properly.

-- 
lg, Chris

