Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262801AbVF3D3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbVF3D3t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 23:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVF3D3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 23:29:25 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:63629 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S262801AbVF3D3T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 23:29:19 -0400
Message-ID: <42C36711.6020306@man-made.de>
Date: Thu, 30 Jun 2005 05:29:21 +0200
From: Frank Schruefer <kernel@man-made.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: No dentry alias for page host in writepage.
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hy,

There is some rare case which hits me aprox. once in a million writepage calls
where for the page handed over there can not be get a connected dentry of its
inode host (via i_dentry).

Unluckily I'm absolutely depending on at least one alias at that point and I'm
not able to implement the export filesystem functions because for implementing
the get_name etc... functions I'd already need the dentry to contain the valid
name. Hence reconnecting is out of the question.

It seems not to be possible to circumvent that situation by just making the
d_delete dentry operations function returning 0 if the inode is dirty or has
dirty pages (mapping_tagged ... PAGECACHE_TAG_DIRTY).

I programmed a really ugly workaround dget'ing an alias as soon as I dirty an
inode and dput it as soon as the last page is writepage'd - that works for now -
but I really hate it and it seems to be memory leak prone (why I'd still have
to find out) and having possible side effects with rename and unlink ...

My question is why are the dentries/aliases dropped/disconnected if the inode is
still dirty or it's pages are under writeout and why am I not asked via d_delete
or have any other option to deny dropping/disconnecting the dentry/aliases?
Is this a bug?
What could I do?

Until now I just have that ugly workaround - please make my day, someone, please ;-)

-- 

Thanks,
    Frank Schruefer
    SITEFORUM Software Europe GmbH
    Germany (Thuringia)

