Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265789AbUFINYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265789AbUFINYt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 09:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263663AbUFINW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:22:57 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:45840 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S265795AbUFINVT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 09:21:19 -0400
Subject: Breaking Ext3/VFS file size limit
Reply-To: goldwyn_r@myrealbox.com
From: "Goldwyn Rodrigues" <goldwyn_r@myrealbox.com>
To: linux-kernel@vger.kernel.org
Date: Wed, 09 Jun 2004 18:51:20 +0530
X-Mailer: NetMail ModWeb Module
MIME-Version: 1.0
Message-ID: <1086787280.98272bfcgoldwyn_r@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am building a custom kernel which could break the max file size limit from 2TB. I found the dependancy on number of 512-byte blocks, as i_blocks.

i_blocks is a 32 bit unsigned long in structures struct inode and struct ext3_inode. I changed it to unsigned long long in struct inode (in fs.h) and used a reserved field in ext3_inode to carry the higher order bits.

Also changed a checking function which returns the maximun possible size as 2TB.

My question is:
Would changing the data type of i_blocks in struct inode (in fs.h) result in any breakdowns. It could happen if the inode structure is directly mapped to some other structure.

I tested at my end with a low end PC and it seems to work fine, for the past 6 hours.

Thanks,

-- 
Goldwyn :o)

PS: I am posting for the first time, so please forgive me (but do tell me, personally if possible) if I commit a mistake.

