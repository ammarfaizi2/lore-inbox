Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTJFSGk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTJFSGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:06:40 -0400
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:42984
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP id S262308AbTJFSGj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:06:39 -0400
Message-ID: <20031006180636.16530.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-0.27
To: linux-kernel@vger.kernel.org
cc: dag@newtech.fi
Subject: Bug in the sg driver
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Mon, 06 Oct 2003 21:06:36 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

just got back from a customer with major problems
with a LTO-drive and an Adaptec 19160.

The problems was ones that HP claimed a firmware
upgrade would fix and even gave a tool for doing this:
hp_ltt.

Running this the first time would always segfault and trying
a second time would consistently panic the system.

We traced the segfault to sg_ioctl trying to do something.
After finding a vague hint with google I tried to boot with
mem=512M (The machine has 2GB of memory) and voila:
The update worked without any crashes.
We don't know yet if the firmware update fixed the original problem,
but the conclusion is:

sg_ioctl seems to address illegal parts of memory when used with
kernels where highmem is enabled.

Any sg-driver maintainers out there?

Best Regards

-- 
Dag Nygren                               email: dag@newtech.fi
Oy Espoon NewTech Ab                     phone: +358 9 8024910
Träsktorpet 3                              fax: +358 9 8024916
02360 ESBO                              Mobile: +358 400 426312
FINLAND


