Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262443AbVADXdJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262443AbVADXdJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 18:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVADXM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 18:12:29 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:29366 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262132AbVADXIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 18:08:54 -0500
Subject: Re: Main CPU- I/O CPU interaction
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Valdis.Kletnieks@vt.edu
Cc: tony osborne <tonyosborne_a@hotmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200501032227.j03MRocl008354@turing-police.cc.vt.edu>
References: <BAY14-F83B94FD7D13C5D19883F795900@phx.gbl>
	 <200501032227.j03MRocl008354@turing-police.cc.vt.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104857088.17176.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 04 Jan 2005 22:03:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-03 at 22:27, Valdis.Kletnieks@vt.edu wrote:
> What sort of I/O device processor is (a) supported by Linux *and* (b) filesystem
> aware?  Unless it meets both criteria, the main CPU(s) will still have to do
> all the work of block allocation, inode creation, and all the rest of that
> stuff.

NetApp 8)

The offloading file system stuff has been proposed and kicked around and
failed repeatedly in different circles. What has had some success is
offloading layout so that the I/O device thinks in terms of

	handle = allocate(blocks, near_this, and_this, ....)
	data = read(handle, offset, len)
	write(handle, offset, len, data)
	free(handle)

type API's, allowing the storage subsystem to do physical
mirror/relocation/HSM in private.

