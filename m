Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932766AbWKGRxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932766AbWKGRxK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 12:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932769AbWKGRxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 12:53:09 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:31710 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932766AbWKGRxH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 12:53:07 -0500
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels
	that offer x86 compatability
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Jeff Layton <jlayton@redhat.com>, Eric Sandeen <sandeen@redhat.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061107174217.GA29746@wohnheim.fh-wedel.de>
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com>
	 <20061106182222.GO27140@parisc-linux.org>
	 <1162838843.12129.8.camel@dantu.rdu.redhat.com>
	 <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com>
	 <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com>
	 <1162914966.28425.24.camel@dantu.rdu.redhat.com>
	 <20061107172835.GB15629@wohnheim.fh-wedel.de>
	 <20061107174217.GA29746@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 07 Nov 2006 11:53:03 -0600
Message-Id: <1162921983.8123.22.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 18:42 +0100, Jörn Engel wrote:
> On Tue, 7 November 2006 18:28:35 +0100, Jörn Engel wrote:
> > 
> > Anyway, here is a first patch converting some callers that looked
> > obvious.
> 
> Next patch with the not-so-obvious ones.  I believe this patch is
> correct, but someone should double-check it.
> 
> Jfs really surprised me.  It appears as if it just takes the number
> returned from new_inode in some cases - unbelievable.

jfs set it in diInitInode() (pardon the uglyMixedCaps), which is called
in several places under diAlloc().  diAlloc() is called after
new_inode() for most inodes.  The exceptions are for special inodes,
which also initialize i_ino in some manner.

Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

