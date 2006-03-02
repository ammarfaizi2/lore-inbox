Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWCBBgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWCBBgI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 20:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWCBBgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 20:36:08 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:9897 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1750981AbWCBBgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 20:36:06 -0500
Message-ID: <44064BF7.9040605@vilain.net>
Date: Thu, 02 Mar 2006 14:35:51 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Herbert Poetzl <herbert@13thfloor.at>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] vfs: cleanup of permission()
References: <20060228052606.GA6494@MAIL.13thfloor.at>	 <1141202744.11585.20.camel@lade.trondhjem.org>	 <20060301131149.GD26837@MAIL.13thfloor.at> <1141256563.26382.8.camel@netapplinux-10.connectathon.org>
In-Reply-To: <1141256563.26382.8.camel@netapplinux-10.connectathon.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
>>the second part is actually a hack to help nfs and fuse
>>to get the 'required' information until there is a proper
>>interface (at the vfs not inode level) to pass relevant
>>information (probably dentry/vfsmount/flags)
> The nameidata _IS_ the vfs structure for storing path context
> information. You seem to be suggesting we need yet another one. Why?

Because you can't make a nameidata without a lookup, and file based 
operations don't do a lookup.  However you still have the vfsmnt and 
inode hanging off the file struct.

Either that or we make a dummy nameidata structure for this situation, 
possibly a filehandle relative lookup as used by openat() et al.

>>>Secondly, an intent is _not_ a permissions mask by any stretch of the
>>>imagination.
>>see above
>>>IOW: at the very least make that intent flag a separate parameter.
>>IMHO it would be good to remove them completely form the
>>current permission() checks.
> Vetoed!
> Redundant RPC calls have performance costs to the client, the server and
> the network. That intent information is there in order to allow the
> filesystem to figure out whether or not it needs to do the permissions
> check, or if that check is already being done by other operations.
> Removing the intents are therefore not an option.

OK, so we either make it an extra parameter or 'properly' stack them 
into a single word.  Do you have any preferences either way there?

Sam.
