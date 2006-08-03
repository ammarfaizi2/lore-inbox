Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWHCQ1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWHCQ1G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWHCQ1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:27:06 -0400
Received: from wx-out-0102.google.com ([66.249.82.196]:48756 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964822AbWHCQ1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:27:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LU2lFsrYS2LQCMXYZKpHXnbCSDBAEVcH5Ihx2Q/67hfWLjlYI/0F8wUMrlKHgesH7CoTFs+ilTNoq3uGTmj4IItElj1MLgeAV0Jtw59cnTiUtkNXRnz58joFk2GTl6fdH5BfokHXfJFi/5nUSoLhyBrLBRVihn7IjIzonRErLf0=
Message-ID: <6d4bc9fc0608030927t175f16c0kfef6a21cc521e368@mail.gmail.com>
Date: Thu, 3 Aug 2006 18:27:04 +0200
From: "Maarten Maathuis" <madman2003@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: heavy file i/o on ext3 filesystem leads to huge ext3_inode_cache and dentry_cache that doesn't return to normal for hours
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a kernel specific problem and this seemed like a suitable place to ask.

I would like responces to be CC'ed to me if possible.

I use a 2.6.17-ck1 kernel on an amd64 system. I have observed this
problem on other/older kernels.

Whenever there is serious hard drive activity (such as doing "slocate
-u") ext3_inode_cache and dentry_cache grow to a combined 400-500 MiB.

The amount of objects is more than half a million.

This will slowly decrease to normal, but will take many hours. It does
not result in any OOM, because i have 1 GiB of memory.

As far as i understand hard drive cache should not be in the slab. Are
these just the inode's, because the amount of memory consumption seems
large for that?

I have found a way to clear the memory (and unfortunately most of the cache):

echo 100 > /proc/sys/vm/nr_hugepages
echo 0 > /proc/sys/vm/nr_hugepages

This suggest the kernel can free this memory. It's not the caching
that bothers me, what bothers me is that it seems to reside in the
slab.

I am not a developer, so please keep that in mind when replying.

I hope someone can be of help.

Sincerely,

Maarten Maathuis.
