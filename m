Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267770AbUIFLzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267770AbUIFLzM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 07:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267773AbUIFLzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 07:55:12 -0400
Received: from asplinux.ru ([195.133.213.194]:65285 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S267770AbUIFLzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 07:55:07 -0400
Message-ID: <413C52E2.10809@sw.ru>
Date: Mon, 06 Sep 2004 16:06:58 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Q: bugs in generic_forget_inode()?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

1. I found that generic_forget_inode() calls write_inode_now() dropping 
inode_lock and destroys inode after that. The problem is that 
write_inode_now() can sleep and during this sleep someone can find inode 
in the hash, w/o I_FREEING state and with i_count = 0.

If such inode will be iget'ed, then it will be iput'ed once more later 
messing with the current iput(). So the inode can be cleared and 
destroyed twice.

2. Why there is no wake_up_inode() in generic_forget_inode() like in 
generic_delete_inode()? Looks like it is missing...

is it bugs in generic_forget_inode()?

Kirill

