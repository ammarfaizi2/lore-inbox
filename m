Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268751AbUIXN6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268751AbUIXN6M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 09:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268753AbUIXN6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 09:58:12 -0400
Received: from asplinux.ru ([195.133.213.194]:59403 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S268751AbUIXN6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 09:58:11 -0400
Message-ID: <41542ADF.5070202@sw.ru>
Date: Fri, 24 Sep 2004 18:10:39 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Q] possible proc inode numbers overflow?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/proc/generic.c:

#define PROC_DYNAMIC_FIRST 0xF0000000UL
static unsigned int get_inode_number(void)
{
	...
         inum = (i & MAX_ID_MASK) + PROC_DYNAMIC_FIRST;

         /* inum will never be more than 0xf0ffffff, so no check
          * for overflow.
          */
	...
}

is it really correct? Looks like MAX_ID_MASK = 0x7FFFFFFF and 
PROC_DYNAMIC_FIRST is 0xF0000000.

So at least the comment is wrong?

Kirill

