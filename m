Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbUEAMKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbUEAMKI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 08:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbUEAMKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 08:10:04 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:64982 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261907AbUEAMIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 08:08:36 -0400
To: "Jose R. Santos" <jrsantos@austin.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, anton@samba.org,
       dheger@us.ibm.com, slpratt@us.ibm.com
Subject: Re: [PATCH] dentry and inode cache hash algorithm performance
 changes.
References: <20040430195504.GE14271@rx8.ibm.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sat, 01 May 2004 14:08:26 +0200
In-Reply-To: <20040430195504.GE14271@rx8.ibm.com> (Jose R. Santos's message
 of "Fri, 30 Apr 2004 14:55:04 -0500")
Message-ID: <8765bg4af9.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jose R. Santos" <jrsantos@austin.ibm.com> writes:

> Anton was nice enough to provide some graphs that show the distribution 
> before and after the patch at http://samba.org/~anton/linux/sfs/1/

Judging from the graphs (!), I don't see a real difference for
dcache. There's just one outlier (depth 11) for the old hash function,
which seems to be translated to multiple depth 9 entries. The
histograms seem to confirm, that there's at most a minimal difference,
if they'd be equally scaled.

Maybe this is due to qstr hashes, which were used by both approaches
as input?

The inode hash seems to be distributed more evenly with the new hash
function. Although the inode histogram suggests, that most buckets are
in the 0-2 depth range, with the old hash function leading slightly in
the zero depth range.

Regards, Olaf.
