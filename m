Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261449AbSKHUXE>; Fri, 8 Nov 2002 15:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262335AbSKHUXE>; Fri, 8 Nov 2002 15:23:04 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:10637 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S261449AbSKHUXE>; Fri, 8 Nov 2002 15:23:04 -0500
Message-ID: <3DCC1EB5.4020303@google.com>
Date: Fri, 08 Nov 2002 12:29:41 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [BUG] Failed writes marked clean?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Perhaps I'm reading the code incorrectly, but in kernel versions 2.4.18 
and 2.5.46 it looks to me like in the case of a write, ll_rw_block 
always clears the dirty bit.  In the event of an error, nothing resets 
the dirty bit and the uptodate flag is cleared.  This means that if the 
same block needs to be read again, the buffer cache will see that the 
buffer is not uptodate and attempt to read the old contents of the 
buffer off of the device.  If the read suceeds the kernel ends up 
corrupting data.

It seems to me that a better solution would be to mark the buffer as 
dirty and uptodate and then attempt to propogate the error as far back 
as possible.  Ideally something can be done to correct the problem at a 
higher level.  Before I dive in and attempt to do something about this, 
I wanted to make sure I was not missing anything important.  So am I 
full of it, or could this really be a problem?

    Ross


