Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265928AbUACGc5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 01:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265929AbUACGc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 01:32:57 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:8878 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S265928AbUACGc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 01:32:56 -0500
Date: Sat, 3 Jan 2004 01:32:56 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: File change notification
Message-ID: <20040103063255.GC23540@delft.aura.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3FF2FC85.5070906@lambda-computing.de> <20040101104717.GA1373@pegasys.ws> <3FF41611.90109@lambda-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF41611.90109@lambda-computing.de>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 01:44:01PM +0100, R?diger Klaehn wrote:
> I think that it is much cleaner and faster to report the inode numbers 
> of the changed files since inode numbers are unique per filesystem and 
> they are immediately available. The complicated mapping of inodes to 

Inode number are not necessarily unique per filesystem. Any filesystem
that uses iget4 can have several objects that have the same inode
number. For instance, Coda uses 128-bit file-identifiers and the i_ino
number is a simple hash that is 'typically' unique. There are also
filesystems that invent inode numbers whenever inodes are brought into
the cache, but which have no persistency when the inode_cache is pruned.
So the next time you see the same object, it could have a different
(unique) inode number.

Returning paths is probably also not quite that easy when you only have
the inode. Because of hardlinks we can have several paths (aliases) that
lead to the same object, but the kernel does not necessarily have all of
those paths available in the dcache.

Jan
