Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265902AbUAKPWd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 10:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265890AbUAKPWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 10:22:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:20390 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265907AbUAKPV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 10:21:56 -0500
X-Authenticated: #7370606
Message-ID: <40016A11.90605@gmx.at>
Date: Sun, 11 Jan 2004 16:21:53 +0100
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>, dm-devel@sistina.com
CC: Arjan van de Ven <arjanv@redhat.com>
Subject: kernel 2.6 biosraid via device mapper - partition support
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

i just started to investigate how biosraid support for the HPT37X 
IDE-chipsets can be implemented in the 2.6 kernel. implementing the 
basic raid levels (0, 1, 0+1, JBOD) seems to be pretty straight forward. 
this can be done by reading the raid signatures of the disks and then 
pipeing the configuration through dmsetup or using the libdevmapper 
library directly. what bothers me is the partition support. the number 
of minor device nodes that are registered per mapped block device is 1. 
this means that there is no way that the kernel does the 
partition-handling by itself. the alternative is to do the partition 
scanning in userspace and to use another device mapper layer to create 
the partition device nodes. it appears that this was already suggested 
by Christophe Varoqui ( http://lwn.net/Articles/13958/ ) but this 
project is now idle. this also has the disadvantage that any changes in 
the partitioning of the raid volume (e.g. by using *fdisk, distribution 
installers, ...) require a manual re-invocation of the biosraid setup 
tool. plus the whole code under linux/fs/partitions/... has to be 
duplicated so that not only the dos partitioning scheme is supported, 
but also BSD slices, x86 solaris, windows dynamic disks, ...

which way to go? is there another solution that i have missed?

regards,
Wilfried
