Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263995AbUGYPX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263995AbUGYPX7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 11:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbUGYPX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 11:23:59 -0400
Received: from jareth.dreamhost.com ([66.33.198.201]:39350 "EHLO
	jareth.dreamhost.com") by vger.kernel.org with ESMTP
	id S263995AbUGYPX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 11:23:58 -0400
Message-ID: <4103D08A.2040908@iname.com>
Date: Sun, 25 Jul 2004 17:23:54 +0200
From: James Mastros <theorb@iname.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Fwd: fs/sysfs/file.c:fill_read_buffer -- signed/unsigned bug?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, kernel hackers,
   fill_read_buffer (in fs/sysfs/file.c) seems to have a signed/unsigned
bug with the return value of show.  count is a ssize_t here, so I'm not
clear on why, but somehow, returning a negative value causes the
BUG_ON(count > PAGE_SIZE); to trigger.  This means that returning an
error from the show function makes the kernel oops!

I'm amazed that this apparently hasn't been triggered until now.  I'm
working on further sysfsification of ACPI, and I have enough problems
without the core oopsing for me on valid code.  ;)  (And it's even
documented that you can return errors from show functions, and there
seems to be other code in the function explicitly for dealing with error
returns, so I assume I'm not simply off the deep end.)

Unfornatly, my knowledge of C is rather lacking -- I'm not sure how to
fix this, but I'm fairly certian my diagnosis is correct.

	Thanks
	-=- James Mastros
