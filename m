Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVGFSAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVGFSAH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 14:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVGFSAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 14:00:06 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:45320 "EHLO
	ninja.slaphack.com") by vger.kernel.org with ESMTP id S261849AbVGFNSu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 09:18:50 -0400
Message-ID: <42CBDA43.6030305@slaphack.com>
Date: Wed, 06 Jul 2005 08:18:59 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Hans Reiser <reiser@namesys.com>, Hubert Chan <hubert@uhoreg.ca>,
       Ross Biro <ross.biro@gmail.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200507060255.j662tndQ005308@laptop11.inf.utfsm.cl>
In-Reply-To: <200507060255.j662tndQ005308@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:
> David Masover <ninja@slaphack.com> wrote:
> 
> [...]
> 
> 
>>Just don't allow user-created hardlinks inside either metafs (/meta) or
>>the magical meta directory inside files.
> 
> 
> And what is it useful for, after its advantage was that it was /exactly/
> like regular files &c, and now it is severely crippled?

The advantage was never that meta files look exactly like regular files, 
but that they look enough like regular files that you can use existing 
tools on them.  Of course, there are some times when you want meta files 
to look exactly like regular files, as in (I hate to bring it up again, 
but...) zip files.

So, a zip file (/meta/vfs/some/zip/file/.../contents/) would allow 
hardlinks between files inside the zipfile, but not outside of it.  This 
would be like creating a separate mountpoint for the zipfile's contents, 
and doing "mount --bind" when a hardlink to the zipfile is created.

I'm not sure if we actually have to pretend it's a mountpoint, or if we 
can just take the checking that mountpoints already do and generalize it.


Can you think of a way in which hardlinks are useful in /meta, in a 
*general* way, instead of within a specific directory controlled by a 
specific plugin?
