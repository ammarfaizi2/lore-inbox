Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424856AbWLCC4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424856AbWLCC4h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 21:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424828AbWLCC4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 21:56:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24252 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1424805AbWLCC4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 21:56:36 -0500
Message-ID: <45723CDB.1060304@redhat.com>
Date: Sat, 02 Dec 2006 21:56:27 -0500
From: Jeff Layton <jlayton@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Brad Boyer <flar@allandria.com>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] ensure i_ino uniqueness in filesystems without permanent
 inode numbers (via idr)
References: <457040C4.1000002@redhat.com> <20061201085227.2463b185.randy.dunlap@oracle.com> <20061201172136.GA11669@dantu.rdu.redhat.com> <20061202053013.GC26389@cynthia.pants.nu>
In-Reply-To: <20061202053013.GC26389@cynthia.pants.nu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Boyer wrote:
> On Fri, Dec 01, 2006 at 12:21:36PM -0500, Jeff Layton wrote:
>> Here's an updated (but untested) patch based on your suggestions. I also went
>> ahead and made the exported symbols GPL-only since that seems like it would be
>> appropriate here. Any further thoughts on it?
> 

> This seems like exactly the sort of thing that should be a generic
> service available to all filesystem implementors whether it's GPL or
> not. The usual justification for GPL-only is that it's something
> random modules shouldn't be touching anyway, but it's something that
> some part of the tree which could be a module needs.

My main reasoning for doing this was that the structures involved are 
per-superblock. There is virtually no reason that a filesystem would 
ever need to touch these structures in another filesystem.

So, this is essentially a service to make it easy for filesystems to 
implement i_ino uniqueness. I'm not terribly interested in making things 
easier for proprietary filesystems, so I don't see a real reason to make 
this available to them. They can always implement their own scheme to do 
this.

I'm certainly open to discussion though. Is there a compelling reason to 
open this up to proprietary software authors?

-- Jeff

