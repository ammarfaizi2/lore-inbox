Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265972AbUAKUeR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 15:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUAKUeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 15:34:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13984 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265972AbUAKUeP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 15:34:15 -0500
Message-ID: <4001B32B.1030305@pobox.com>
Date: Sun, 11 Jan 2004 15:33:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christophe Saout <christophe@saout.de>
CC: dm-devel@sistina.com, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>, Andries Brouwer <aebr@win.tue.nl>,
       Linus Torvalds <torvalds@osdl.org>
Subject: partition detection in 2.7
References: <40016A11.90605@gmx.at> <1073849697.24036.11.camel@leto.cs.pocnet.net>
In-Reply-To: <1073849697.24036.11.camel@leto.cs.pocnet.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:
> The plan for Linux 2.7 is to rip out partition detection from the kernel
> and do everything in userspace (probably initramfs). So someone could
> start by making the partition detection code a library.


Linus just vehementally stated recently that partition parsing wouldn't 
be leaving the kernel :)

However, I do think we will eventually move to a middle ground, where 
partition parsing code will be in the kernel _source_ tree, but it will 
be in initramfs as you describe.

The reason being is that block device attachment and setup is growing 
more complicated over time, as people move to things like dm+lvm2+md or 
iscsi+dm+evms.  Thus, the support code to make those device combinations 
to be used as a root device will get more and more complex.

RAID and device mapper were actually two big reasons why I am pushing 
for klibc (pushed back to 2.7 now) and initramfs in the kernel source 
tree.  LVM, some EFI bits, dm, and md all have boot components are 
mainly in the kernel because they need to happen (a) early and (b) 
always, not because they actually need to be compiled into the kernel 
image itself.

	Jeff



