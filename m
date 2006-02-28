Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbWB1UJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbWB1UJu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 15:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbWB1UJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 15:09:50 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:35240 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S932546AbWB1UJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 15:09:49 -0500
Message-ID: <4404ADFB.7080204@vilain.net>
Date: Wed, 01 Mar 2006 09:09:31 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Joshua Hudson <joshudson@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/27] allow hard links to directories, opt-in for any
 filesystem
References: <bda6d13a0602272204l494e8fe7q67c2509d4e7aa0f7@mail.gmail.com> <44043973.4070202@yahoo.com.au>
In-Reply-To: <44043973.4070202@yahoo.com.au>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
>>Patch seems to work, might want more testing.
>>It probably should not be applied without a discussion, especially
>>as no filesystem in kernel tree wants this. I am working on a fs that does.
> This is backwards I think. This is not disallowed because there are
> no filesystems that want it. Linux doesn't want it so it is disallowed
> by the vfs.
 > You have to put forward a case for why we want it, rather than show us
 > your filesystem that "wants" it. Right?

Agreed.  Mostly this is because the design of unix directory semantics 
preclude it from being possible.  You have exactly one ".." entry.  More 
than one ".." would mean confusion (which does ".." refer to?).  A 
different name would confuse more programs.

The VFS is presenting collections of arbitrary filesystems as unix 
filesystem, it is not a generic abstraction for any kind of storage 
system that is extended to encompass novel approaches to filesystem 
structure.

So if you wanted to access such a filesystem via Linux you would need to 
present this non-unix idea of directory hard links through some kind of 
ioctl etc.

Besides, we already have bind mounts, which are in many ways like a 
directory hard link (and, in many other ways, unlike one).

Sam.
