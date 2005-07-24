Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbVGXNQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbVGXNQJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 09:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVGXNQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 09:16:09 -0400
Received: from web33308.mail.mud.yahoo.com ([68.142.206.123]:42894 "HELO
	web33308.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261201AbVGXNQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 09:16:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=BeVXmkzPNSfdK+Nh8+p1OSigwM4irsKvwWX1Cuwkicr0ZaEdjX1/qtitPZ9KRQYf4kFhKAEqFP4UnmnNG7A9ZRZDJpU/5zD5hZuCAQ769vZP7sKnW2q4L7Y5AlmtT6VVu6RhLI3TNPCMTkjhWyiymI21rLaRqqCxxsx1pv8MMsM=  ;
Message-ID: <20050724131604.89173.qmail@web33308.mail.mud.yahoo.com>
Date: Sun, 24 Jul 2005 06:16:04 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: ext2: buffer_head usage with and without O_DIRECT
To: linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is with respect to 2.4.28 on
http://lxr.linux.no/source/?v=2.4.18 

When i do read/write on ext2 without opening files
with O_DIRECT, i can see buffer_head constantly
increasing in /proc/slabinfo.

But when I open files with O_DIRECT, the i/o is done
without using buffer_head, /proc/slabinfo shows this
as constant throughout the i/o.
There is no other i/o activity on the box.

Stacks below show that both of them creates
buffer_head's. Any idea why this is happening ?

As per the code, Without O_DIRECT, stack is:
(See fs/buffer.c)
submit_bh_rsector
submit_bh
block_read_full_page (This calls create_buffers to
create buffer_head's)
ext2_readpage
do_generic_file_read
generic_file_new_read
generic_file_read

With O_DIRECT:
brw_kiovec (This creates buffer_head's)
generic_direct_sector_IO (cals
prepare_direct_IO_iobuf)
ext2_direct_IO
generic_file_direct_IO 
generic_file_new_read
generic_file_read

-Thanks.


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
