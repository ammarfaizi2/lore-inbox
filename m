Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750824AbWDSJWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbWDSJWV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 05:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWDSJWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 05:22:21 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:55991 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750824AbWDSJWU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 05:22:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=knwZifrZxYkkQjAzUWLXskOmft3Mzt6spB4wd6f441e3OeGqWeMIRJtPxdJYB1qn5Zun49r5gsbb/vzdC8t3Y/0AR/gK6v1IpO/ExjZ3ph31XekQ92VzUbty08gUHaWTFy8UvVB6RWxmkwQLSNbQpNHpR+XKH+heCaSVYQemTP0=
Message-ID: <84a104fc0604190222k49e4ebbcn7b807743afcd9fc3@mail.gmail.com>
Date: Wed, 19 Apr 2006 13:22:19 +0400
From: "Belan Kumar" <belkumar@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: VFS && UFS write support: possible on *BSD/Solaris, impossible on Linux?
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

May be better call subject something like: "Shortest way to ufs write support",
but current subject give more chances to recieve answer.

First of all I try explain the current problem:
UFS as other block file systems has notition of "block",
but further to "block" notion it has "fragment" concept.
"fragment" used for preventing waste of space.
Usually fragment==block/8, and if "the rest of file" doesn't occupy
the whole block, it occupy several fragments. If file grows, at some point
"the rest of file"  will be occupy 8 fragments. And HERE IS PROBLEM,
we should allocate block and move 8 fragments to it.

On *BSD/Solaris it is simple: they read analog of buffer_head and
change analog of b_blocknr and that's all.

The current code of fs/ufs/balloc.c does the same:
----------------------
sb_bread
bh->b_blocknr =
mark_buffer_dirty (bh)
brelse (bh)
--------------------------
I suppose you guess: it doesn't work,
latter when you do sb_getblk(old_blocknr) it give to us the same block
and after that kernel hang up.


Hence question: what would be the proper solution in this situation?
Is it possible in current VFS change b_blocknr?
