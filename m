Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUFZGMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUFZGMJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 02:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266930AbUFZGMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 02:12:09 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:14385 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S266362AbUFZGMG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 02:12:06 -0400
Subject: Re: [PATCH] Breaking ext2 file size limit of 2TB
Reply-To: goldwyn_r@myrealbox.com
From: "Goldwyn Rodrigues" <goldwyn_r@myrealbox.com>
To: jbglaw@lug-owl.de
CC: linux-kernel@vger.kernel.org
Date: Sat, 26 Jun 2004 11:41:58 +0530
X-Mailer: NetMail ModWeb Module
MIME-Version: 1.0
Message-ID: <1088230318.9825981cgoldwyn_r@myrealbox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You're using a reserved field; how do you mean "compatible" in this
> situation? Think of a filesystem with real files > 2TB. How will an
> unpatched ext3fs driver handle those files? You'll only see the <2TB
> content, right?


When I say compatible, I mean the the filesystem need not be formatted. All you need to do patch the kernel, and re-coompile the module/kernel, and remove the old module and insert the new one (if you are using ext3 as a module). 

Currently there is a function in ext3_max_size() which limits the file size to 2TB because of the number of blocks, namely i_blocks. 


> May an unpatched version under any circumstances clear the high-order
> bits of the newly introduced 64bit integer, just because it doesn't know
> to preserve this reserved field's value?

With an unpatched version you would not be able to create a file greater than 2TB at all and considers that all files are below 2TB.


> Being unfamiliar eith ext3's internals, are there other
> reserved/free-for-future-use fields that don't clash with the HURD?

Andreas has proposed a few fields but I want to make sure that those fields as well are not used.


> Are you proposing a patch like this for ext2, too?
> 

Once approved, it can be used for ext2 as well. Converting the current patch for ext2 would be childs play. ext2 and ext3 use almost the same structures (actually from my point of view, exactly the same but am afraid to use the word "exactly").

-- 
Goldwyn :o)


