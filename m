Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTJ1WGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 17:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbTJ1WGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 17:06:23 -0500
Received: from smtp.hccnet.nl ([62.251.0.13]:64919 "EHLO smtp.hccnet.nl")
	by vger.kernel.org with ESMTP id S261332AbTJ1WGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 17:06:22 -0500
Message-ID: <3F9EE85D.9060903@hccnet.nl>
Date: Tue, 28 Oct 2003 23:06:21 +0100
From: Klaas de Waal <klaas.de.waal@hccnet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: klaas.de.waal@philips.com
Subject: Bug in linux-2.0.6-test9/fs/direct-io.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bug in parameter of ZERO_PAGE macro in line 679 of fb/direct-io.c
Parameter dio->cur_user_address has to be dio->curr_user_address.
This bug shows when compling for MIPS little endian as target, not when 
compiling for X86.


Context diff (direct-io.c.sav is original file, direct-io.c is fixed file):

*** direct-io.c 2003-10-28 22:59:00.000000000 +0100
--- direct-io.c.sav     2003-09-28 02:50:29.000000000 +0200
***************
*** 676,682 ****

        this_chunk_bytes = this_chunk_blocks << dio->blkbits;

!       page = ZERO_PAGE(dio->curr_user_address);
        if (submit_page_section(dio, page, 0, this_chunk_bytes,
                                dio->next_block_for_io))
                return;
--- 676,682 ----

        this_chunk_bytes = this_chunk_blocks << dio->blkbits;

!       page = ZERO_PAGE(dio->cur_user_address);
        if (submit_page_section(dio, page, 0, this_chunk_bytes,
                                dio->next_block_for_io))
                return;
[

