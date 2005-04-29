Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbVD2NPJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbVD2NPJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 09:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVD2NPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 09:15:09 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:62356 "HELO
	server5.heliogroup.fr") by vger.kernel.org with SMTP
	id S262551AbVD2NPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 09:15:04 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3 mmap lack of consistency among runs
Date: Fri, 29 Apr 2005 12:44:45 GMT
Message-ID: <0563I2L12@server5.heliogroup.fr>
X-Mailer: Pliant 93
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>
> Maybe you're being bitten by the address space randomisation.
> 
> Try
> 	echo 0 > /proc/sys/kernel/randomize_va_space

Ok, it solves my issue, but:

. desabling it through 'echo 0 > /proc/sys/kernel/randomize_va_space' is not
  a solution because only the application knows that it wants it to be desabled,
  and the application is not root so cannot write to /proc; morever the
  application can only speak for itself so desabling should be on a per process
  bias.

  I can hardly imagine to publish a warning in the README such as:
  This software only works if your Linux kernel is configured so that
  /proc/sys/kernel/randomize_va_space = 0

. second, my process restart succeeding roughly in 50% cases means that the
  randomisation performed is just a toy. A virus assuming fixed memory layout
  will still succeed 50% of times to install.

All in all, I'm not concerned about Linux kernel to randomise or not,
but I need to have a reliable way to request a memory region and be granted
that I can request the same one in a futur run.
What is the proper way to get such a memory area ?
