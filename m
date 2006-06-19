Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWFSEHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWFSEHT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 00:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751112AbWFSEHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 00:07:19 -0400
Received: from oracle.bridgewayconsulting.com.au ([203.56.14.38]:26265 "EHLO
	oracle.bridgewayconsulting.com.au") by vger.kernel.org with ESMTP
	id S1751073AbWFSEHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 00:07:17 -0400
Subject: Re: Suspending and resuming a single task
From: Bernard Blackham <bernard@blackham.com.au>
To: Wojciech Moczulski <wmoczulski@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4495F8B1.7020304@gmail.com>
References: <4495F344.8080705@gmail.com>
	 <E1Fs7vj-0003Rm-00@chiark.greenend.org.uk>  <4495F8B1.7020304@gmail.com>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Jun 2006 12:07:07 +0800
Message-Id: <1150690028.2207.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-19 at 03:06 +0200, Wojciech Moczulski wrote:
> Matthew Garrett napisał(a):
> > http://cryopid.berlios.de/ ?
> 
> OK, and if I want to parse the path to a file, where process state is saved,
> to the kernel and let the kernel module restart the process? Is it possible to
> do it this way (without building self-executable binary)?

One of the earlier incarnations of CryoPID did more or less this - it
generated an ELF file with segments as laid out in the original image,
so that the kernel ELF loaded did all the dirty work. It still required
an extra portion of code to be injected into the binary in order to
restore registers, file descriptors, etc. I recall the main reason I
switched away from it was to be able to compress the images.

If you're going to be modifying the kernel in order to resume processes,
then implementing it as an binary format handler (fs/binfmt_*) may be
what you're looking for.

Regards,

Bernard.

