Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261985AbVEKQfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbVEKQfo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 12:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVEKQfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 12:35:44 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:15817 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261978AbVEKQfe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 12:35:34 -0400
Message-ID: <42823450.8030007@freenet.de>
Date: Wed, 11 May 2005 18:35:28 +0200
From: Carsten Otte <cotte@freenet.de>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       schwidefsky@de.ibm.com, akpm@osdl.org
Subject: Re: [RFC/PATCH 0/5] add execute in place support
References: <428216DF.8070205@de.ibm.com> <1115828389.16187.544.camel@hades.cambridge.redhat.com>
In-Reply-To: <1115828389.16187.544.camel@hades.cambridge.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

>On Wed, 2005-05-11 at 16:29 +0200, Carsten Otte wrote:
>  
>
>>. This is also useful on embedded systems where the block device is
>>located on a flash chip.
>>    
>>
>
>On Wed, 2005-05-11 at 17:33 +0200, Carsten Otte wrote:
>  
>
>>Indeed that seems reasonable. There is no exact reason to have
>>this built into a kernel on a platform that does not have a bdev
>>for this.
>>    
>>
>
>The sanest way to use flash chips is not to pretend that they're a block
>device at all; rather to use a file system directly on top of them. 
>
>But although you _talk_ about block devices, your code does look like it
>should be usable even by flash file systems. I'll try to come up with a
>test case using it on flash.
>
>  
>
Yes and no. For execute in place to work proper, you need an
allignment of data to page boundaries "on disk" (or on flash)
just like you have when mmap()ing to userland.
Before choosing second extended, I also looked at some
flash/rom filesystems. But I was unable to identify one that
alligns the data proper (and does not compress things or
such). The ext family with block size == PAGE_SIZE does
fullfill that requirement once the "block device" starts on page
boundary.
On the other hand I believe that a filesystem specificaly
designed for flash can provide less metadata overhead then
second extended. Would also be interresting in our use-case
on s390.

