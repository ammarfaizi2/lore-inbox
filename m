Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbTJ3MQi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 07:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTJ3MQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 07:16:38 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:31397 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S262395AbTJ3MQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 07:16:37 -0500
Message-ID: <3FA10121.9010608@softhome.net>
Date: Thu, 30 Oct 2003 13:16:33 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Things that Longhorn seems to be doing right
References: <LUlv.31e.5@gated-at.bofh.it> <M7iG.41B.7@gated-at.bofh.it> <MagC.82U.7@gated-at.bofh.it> <Mg2B.7wf.9@gated-at.bofh.it> <Mh8n.BT.9@gated-at.bofh.it> <MhLf.1pF.9@gated-at.bofh.it>
In-Reply-To: <MhLf.1pF.9@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> 
> All that said, the indexes themselves should just be feature enhanced 
> directories accessed via the kernel.  Feature enhancements might include 
> such things as better space efficiency, ordering plugins, etc.
> 

   I still see no point in putting this into kernel space.

   As a proof of concept - if someone wants to try - one can implement 
this system on top of any other fs. in user space.

   open("/aaa.txt") ->
     inode ->
      underlaying_fs.open(itoa(inode)+".meta")
      underlaying_fs.open(itoa(inode)+".data")

   write(fd) -> fd<->inode -> updateindex(inode) + write(inode). [1]

   and so on and so forth. LD_PRELOAD=libcoolfs.so my_cool_app

   in other words file system can be used as smart storage.
   hard links can be 'mis'used to implement search indeces.

[1]  mmap() is the notable problem.

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--
   "... and for $64000 question, could you get yourself vaguely
      familiar with the notion of on-topic posting?"
				-- Al Viro @ LKML

