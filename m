Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261669AbREOWcI>; Tue, 15 May 2001 18:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbREOWbs>; Tue, 15 May 2001 18:31:48 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:12816 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S261665AbREOWbg>;
	Tue, 15 May 2001 18:31:36 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200105152231.f4FMVSC246046@saturn.cs.uml.edu>
Subject: Re: Getting FS access events
To: hpa@zytor.com (H. Peter Anvin)
Date: Tue, 15 May 2001 18:31:28 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9ds01m$7q9$1@cesium.transmeta.com> from "H. Peter Anvin" at May 15, 2001 12:28:54 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:

> This would leave no way (without introducing new interfaces) to write,
> for example, the boot block on an ext2 filesystem.  Note that the
> bootblock (defined as the first 1024 bytes) is not actually used by
> the filesystem, although depending on the block size it may share a
> block with the superblock (if blocksize > 1024).

The lack of coherency would screw this up anyway, doesn't it?
You have a block device, soon to be in the page cache, and
a superblock, also soon to be in the page cache. LILO writes to
the block device, while the ext2 driver updates the superblock.
Whatever gets written out last wins, and the other is lost.

