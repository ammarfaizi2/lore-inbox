Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVACWmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVACWmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 17:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVACWi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 17:38:56 -0500
Received: from terminus.zytor.com ([209.128.68.124]:19614 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261928AbVACWZr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 17:25:47 -0500
Message-ID: <41D9C64E.7080508@zytor.com>
Date: Mon, 03 Jan 2005 14:25:18 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicholas Miell <nmiell@comcast.net>
CC: hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] get/set FAT filesystem attribute bits
References: <41D9B1C4.5050507@zytor.com>	 <1104787447.3604.9.camel@localhost.localdomain>	 <41D9BA8B.2000108@zytor.com>	 <1104788816.3604.17.camel@localhost.localdomain>	 <41D9C111.2090504@zytor.com> <1104790243.3604.23.camel@localhost.localdomain>
In-Reply-To: <1104790243.3604.23.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Miell wrote:
> 
> Yeah, I contemplated adding system.fattattrs, system.ntfsattrs, and
> system.linuxattrs (for the ext2 attrs that have popped up in several
> other filesystems) a while ago, but xattrs seem to be the red-headed
> left-handed stepchild of the Linux VFS and I lost interest in the
> project.
> 
> Nice to see someone else interested in it, though.
 >

I'm honestly not sure that using an ASCII string in an xattr is the sane 
way of doing this.  Even a binary byte in an xattr would make more sense 
in some ways.

I think the xattr mechanism is ignored largely because it's painfully 
complex.

A plus with using xattr is that in theory (but of course not in 
practice!) it would let one store a copy of a DOS filesystem on an ext3 
(or xfs, or...) filesystem and have it restored, all using standard (but 
by necessity, xattr-aware) tools.  However, the splitting of xattr into 
namespaces may very well make that impossible, since what's a "system" 
attribute to one filesystem is a "user" attribute to another.  Classic 
design flaw, by the way.

Anyway, I'm going to send out something to the various maintainers of 
DOS-based filesystems (FAT, CIFS, NTFS) and see what they think.

	-hpa
