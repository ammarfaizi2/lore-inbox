Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbVEPPuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbVEPPuP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 11:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVEPPt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 11:49:26 -0400
Received: from [80.247.74.3] ([80.247.74.3]:42181 "EHLO tavolara.isolaweb.it")
	by vger.kernel.org with ESMTP id S261717AbVEPPrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 11:47:37 -0400
Message-Id: <6.2.1.2.2.20050516174053.07185270@mail.tekno-soft.it>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.1.2
Date: Mon, 16 May 2005 17:47:31 +0200
To: William Lee Irwin III <wli@holomorphy.com>
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: How to use memory over 4GB
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org
In-Reply-To: <20050516151023.GK9304@holomorphy.com>
References: <6.2.1.2.2.20050516142516.0313e860@mail.tekno-soft.it>
 <42889890.8090505@tls.msk.ru>
 <6.2.1.2.2.20050516150628.06682cd0@mail.tekno-soft.it>
 <20050516151023.GK9304@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-IsolaWeb-MailScanner-Information: Please contact the ISP for more information
X-IsolaWeb-MailScanner: Found to be clean
X-MailScanner-From: kernel@tekno-soft.it
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 17.10 16/05/2005, William Lee Irwin III wrote:

>On Mon, May 16, 2005 at 03:16:28PM +0200, Roberto Fichera wrote:
> > I was thinking to create as many object I need by the usual shm_open(),
> > than mmap() it on a process until I get ENOMEM. So, when I get a
> > ENOMEM I start to munmap() objects in order to free some user space
> > memory and create the needed space to complete mmap() for the
> > requested object.
>
>This approach has already been used in production by various major
>applications and is even obsolete, now replaced by remap_file_pages()
>(in Linux), where it and its counterparts in other operating systems
>have been in use in production by various major applications for some time.
>
>remap_file_pages() allows virtual pages in an mmap() area to correspond
>in an unrestricted fashion to the pages of the underlying file, and to
>alter this correspondence at will.
>
>In particular, Oracle's "vlm" option does this.

So, you are suggesting to create one big tmpfs area, 6GB for example, than 
mmap() it
to the user process and use the remap_file_pages() for all the objects I 
want make
"addressable" on the user process taking care the return value of -1 which 
implies
to munmap() something to free vm space?



>-- wli

Roberto Fichera. 

