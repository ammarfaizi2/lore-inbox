Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262456AbUK3XaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262456AbUK3XaF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbUK3X0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:26:53 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:15196 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id S262394AbUK3XY6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:24:58 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Walking all the physical memory in an x86 system
Date: Tue, 30 Nov 2004 16:24:52 -0700
Message-ID: <C863B68032DED14E8EBA9F71EB8FE4C205805A9F@azsmsx406>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Walking all the physical memory in an x86 system
Thread-Index: AcTXI3+uzPbOQJnvROKMZe0B4m8APwAAJd8gAAOpkPA=
From: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
To: <jengelh@linux01.gwdg.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Nov 2004 23:24:53.0954 (UTC) FILETIME=[CC072220:01C4D733]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-----Original Message-----
From: Jan Engelhardt [mailto:jengelh@linux01.gwdg.de] 
Sent: Tuesday, November 30, 2004 2:28 PM
To: Hanson, Jonathan M
Cc: linux-kernel@vger.kernel.org
Subject: RE: Walking all the physical memory in an x86 system

>[Jon M. Hanson] I can read /dev/mem from a userspace application as
root
>with no problems and print out what it sees. However, things are not so
>simple from a kernel module as I just can't call open() and read() on
>/dev/mem because no such functions are exported from the kernel. Is
>there a way to read the contents of /dev/mem from a kernel module?

You can use filp_open().


Jan Engelhardt
-- 
ENOSPC

[Jon M. Hanson] I tried the filp_open() approach like this:

struct file *mem_fd;

mem_fd = filp_open("/dev/mem", O_RDONLY | O_LARGEFILE, 0);

I then have a check if IS_ERR(mem_fd) is true immediately afterwards
along with a printk saying it failed. This condition is true when I ran
it. It seems to fail with -EACCES (permission denied) as the error code.

I can see the exact code that's causing the -EACCES in open_namei(). It
makes a check if the thing being opened is a character device and
returns the -EACCES, so obviously filp_open() can't do this.

I can run a program as root and open /dev/mem and read it without any
problems. Surely there is a way to do the same thing within a kernel
module.



