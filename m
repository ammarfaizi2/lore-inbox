Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270480AbTHQS3X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 14:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270484AbTHQS3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 14:29:22 -0400
Received: from main.gmane.org ([80.91.224.249]:711 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S270480AbTHQS3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 14:29:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Rob North <tzwvgwv2001@sneakemail.com>
Subject: Re: [RFC] ioctl vs xattr for the filesystem specific attributes
Date: Sun, 17 Aug 2003 19:14:28 +0100
Message-ID: <bhogm4$2gb$1@sea.gmane.org>
References: <8765l67rvc.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en, en-us
In-Reply-To: <8765l67rvc.fsf@devron.myhome.or.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi wrote:
> Hi,
> 
> Bastien Roucaries <roucariesbastien@yahoo.fr> writes:
> 
> 
>>This patch implement an "extended attributes" (XATTR) hook in aim to read or
>>modify specific  fatfs flags' like ARCHIVE or SYSTEM.
>>
>>I believe it's a good idea  because :
>>	- PAX ( GNU replacement of tar) save and restore XATTRs, so you can make more
>>exact save of FATfs without use of specific programs.
>>	- It's an elegant means to avoid use of mattrib.
>>	- Samba can use this .
>>but CONS :
>>	- use 2 Kb of kernel memory.
> 
> 
> Bastien Roucaries <roucariesbastien@yahoo.fr> writes:
> 
> 
>>Indeed some flags are shared by many namespace for instance immutable is 
>>shared by xfs,ext2/3,jfs and by the fat ( with a special mount option). 
>>Compress also is a very common flag
>>This flags are in the "common" sub-namespace.
>>
>>But some are fs specifics for instance notail attr of reiserfs,shortname of 
>>fat.They are in the the "spec"sub-namespace
> 
> 
> I received the above email.
> 
> This read/modify the file attributes of filesystem specific via xattr
> interface (in this case, ARCHIVE, SYSTEM, HIDDEN flags of fatfs).
> 
> Yes, also we can provide it via ioctl like ext2/ext3 does now.
> 
> But if those flags provides by xattr interfaces and via one namespace
> prefix, I guess the app can save/restore easy without dependency of
> one fs.
> 
> Which interface would we use for attributes of filesystem specific?
> Also if we use xattr, what namepace prefix should be used?
> 
> Any idea?
> 
> Thanks.
> 


I like the ideas that the patch seems to propose.
Infact I'd like to see the use of xattr used for non-standard attributes
applied to all fs.
Specifically, I want to backup all partitions, and attribs from one OS:
Linux. I do not want to loose fat attributes during backup.
This would also be useful for the Wine developers.


If you haven't got a response to your questions, maybe make your own 
decisions and submit a patch anyway.


One question:
How does the patch deal with the fact that only some named xattrs are
permitted?

I see 2 options:
1. all files/dirs in fat mount posess fat-specific xattrs. These xattrs 
are initialised at file/dir create. No further attribs can be added, 
none can be deleted. the fat attribute's Boolean value is defined by 
extended attribute's value.
2. all fat-specific attribs are optional, absence/presence defines
boolean value. All operations are permitted, but can only add the
fat-specific attributes.

I prefer option 1, as it makes clear what attributes are available.


