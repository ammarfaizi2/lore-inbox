Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbVKITAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbVKITAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 14:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932473AbVKITAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 14:00:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13971 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932444AbVKITAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 14:00:02 -0500
Date: Wed, 9 Nov 2005 10:59:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ram Pai <linuxram@us.ibm.com>
cc: Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@ftp.linux.org.uk>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
In-Reply-To: <1131561849.5400.384.camel@localhost>
Message-ID: <Pine.LNX.4.64.0511091054290.3247@g5.osdl.org>
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk>  <E1EZUC9-0007oJ-00@dorka.pomaz.szeredi.hu>
  <1131464926.5400.234.camel@localhost>  <E1EZVoO-000807-00@dorka.pomaz.szeredi.hu>
 <1131561849.5400.384.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Nov 2005, Ram Pai wrote:
>
> And 'umount .' really doen't make sense. What does it mean? umount the 
> current mount? or umount of the mount that is mounted on this dentry?

"umount <directory>" _absolutely_ makes sense, whether "directory" is "." 
or something else. People do it all the time.

Now, if it doesn't unmount the last thing mounted on top of ".", then 
that's a misfeature. It might be a misfeature in the mount program (it 
might scan /etc/mounts top-to-bottom rather than the other way), but the 
kernel should also support it.

> no. I said application _should_not_ depend on it, because it is a
> undefined semantics.

It's definitely neither unusual nor undefined. I do all my umounts by 
directory (in fact, doing it by anything else really _is_ badly defined, 
since a block device can be mounted in many places), and the only sane 
semantics would be to peel off the last mount on that directory.

Now, that doesn't necessarily mean that "list_add_tail()" is wrong. But 
if we add new mounts to the end, then umount remove them from the end too, 
no?

		Linus
