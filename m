Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267688AbTBLVUz>; Wed, 12 Feb 2003 16:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267692AbTBLVUz>; Wed, 12 Feb 2003 16:20:55 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:57231 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267688AbTBLVUx> convert rfc822-to-8bit; Wed, 12 Feb 2003 16:20:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: "Eric Chen" <echen@ateonix.com>, <linux-kernel@vger.kernel.org>
Subject: Re: changing file copy to support extended attributes
Date: Wed, 12 Feb 2003 15:30:30 -0600
User-Agent: KMail/1.4.1
References: <NFBBIGILIDAABCBKKGMLAECOCCAA.echen@ateonix.com>
In-Reply-To: <NFBBIGILIDAABCBKKGMLAECOCCAA.echen@ateonix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302121530.30427.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 February 2003 01:35 pm, Eric Chen wrote:
> Hi,
>
> I wanted to modify file copy so it supports extended attributes. I am using
> extended attributes provided by the XFS filesystem, and right now when I
> copy a file with an extended attribute bit set on, the copy of the file
> does not preserve the extended attribute. I could use some help in this
> area because I am not sure where to start. If anyone has some suggestions
> or can offer me some help or resources to go to, please let me know.

You have to modify "cp" and "mv" (since a "mv" that crosses mount points
is equivalent to a "cp original destination/copy; rm original".

Now you also need to realize that you might NOT be able to copy all of the 
extended attributes (XFS supports system and user attributes, and only the
user attributes can be copied). This is the usual reason extended attributes
are not copied at all.

Another is what about applications that may copy files too: cat, tar, cpio, 
dd, vi, ed, ... and sh (remember the old "shcat" script:
	while[read v]; do; echo $v; done <original >copy)

And what do you do if the destination is not XFS?

And what about when the user is not the owner of the file, but does have read 
access?

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
