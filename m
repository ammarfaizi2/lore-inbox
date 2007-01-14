Return-Path: <linux-kernel-owner+w=401wt.eu-S1751263AbXANWZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbXANWZf (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 17:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbXANWZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 17:25:35 -0500
Received: from www.osadl.org ([213.239.205.134]:52594 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751210AbXANWZe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 17:25:34 -0500
Subject: Re: 2.6.20-rc4-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, linux-ide@vger.kernel.org
In-Reply-To: <20070114220515.GG5860@kernel.dk>
References: <20070111222627.66bb75ab.akpm@osdl.org>
	 <1168768104.2941.53.camel@localhost.localdomain>
	 <1168771617.2941.59.camel@localhost.localdomain>
	 <1168785616.2941.67.camel@localhost.localdomain>
	 <20070114220515.GG5860@kernel.dk>
Content-Type: text/plain
Date: Sun, 14 Jan 2007 23:31:41 +0100
Message-Id: <1168813901.2941.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-15 at 09:05 +1100, Jens Axboe wrote:
> raid seems to have severe problems with the plugging change. I'll try
> and find Neil and have a chat with him, hopefully we can work it out.

Some hints:

mount(1899): WRITE block 16424 on md3
call md_write_start
md3_raid1(438): WRITE block 40965504 on sdb6
md3_raid1(438): WRITE block 40965504 on sda6
First Write sector 16424 disks 2

Stuck.

Note, that neither end_buffer_async_write() nor
raid1_end_write_request() are invoked, 

In a previous write invoked by:
fsck.ext3(1896): WRITE block 8552 on sdb1
end_buffer_async_write() is invoked.

sdb1 is not a part of a raid device.

Hope that helps,

	tglx


