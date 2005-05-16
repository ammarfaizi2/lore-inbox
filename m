Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261704AbVEPPMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbVEPPMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVEPPLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:11:22 -0400
Received: from holomorphy.com ([66.93.40.71]:50650 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261697AbVEPPKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 11:10:46 -0400
Date: Mon, 16 May 2005 08:10:23 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org
Subject: Re: How to use memory over 4GB
Message-ID: <20050516151023.GK9304@holomorphy.com>
References: <6.2.1.2.2.20050516142516.0313e860@mail.tekno-soft.it> <42889890.8090505@tls.msk.ru> <6.2.1.2.2.20050516150628.06682cd0@mail.tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6.2.1.2.2.20050516150628.06682cd0@mail.tekno-soft.it>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2005 at 03:16:28PM +0200, Roberto Fichera wrote:
> I was thinking to create as many object I need by the usual shm_open(), 
> than mmap() it on a process until I get ENOMEM. So, when I get a
> ENOMEM I start to munmap() objects in order to free some user space
> memory and create the needed space to complete mmap() for the
> requested object.

This approach has already been used in production by various major
applications and is even obsolete, now replaced by remap_file_pages()
(in Linux), where it and its counterparts in other operating systems
have been in use in production by various major applications for some time.

remap_file_pages() allows virtual pages in an mmap() area to correspond
in an unrestricted fashion to the pages of the underlying file, and to
alter this correspondence at will.

In particular, Oracle's "vlm" option does this.


-- wli
