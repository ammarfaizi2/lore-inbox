Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266606AbTGFFo7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 01:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbTGFFo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 01:44:59 -0400
Received: from mail03.mel.vnet.net.au ([203.89.200.43]:49869 "EHLO
	mail03.mel.vnet.net.au") by vger.kernel.org with ESMTP
	id S266606AbTGFFo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 01:44:58 -0400
Message-ID: <3F07B957.4010206@vtown.com.au>
Date: Sun, 06 Jul 2003 15:53:27 +1000
From: Daniel Cavanagh <nofsk@vtown.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: linux kernel problem (disklabel and swap)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

i recently had the problem with a bsd disklabel and swap and as someone 
suggested, the swap slice did not have SWAPSPACE in it and that running 
mkswap would fix this. sure enough it did, but then i wondered why 
swapon allowed /dev/hda3 as a valid swap. so i had a look and SWAPSPACE2 
was there, right at the start of the openbsd partition, inside the 
disklabel. so i have come to the conclusion that openbsd tells the world 
via the disklabel that a partition/slice is swap rather than at the 
start of the swap slice. the linux kernel does not know this and wants 
SWAPSPACE2 at the start of the partition/slice. to test this i booted up 
openbsd and forced it to swap. it wrote over the SWAPSPACE2 in the 
slice. so i think that the linux kernel needs to be fix so that if an 
openbsd partition exists, the kernel expects SWAPSPACE2 in the disklabel 
rather than the actual swap slice. i don't know if this is true for 
other *BSD though.

i hope this helps.

thanks, daniel.

