Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTDYBhg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 21:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbTDYBhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 21:37:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22967 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262423AbTDYBhf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 21:37:35 -0400
Message-ID: <3EA8942D.4050201@pobox.com>
Date: Thu, 24 Apr 2003 21:49:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Roland McGrath <roland@redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] i386 vsyscall DSO implementation
References: <200304250110.h3P1Aoo02525@magilla.sf.frob.com>
In-Reply-To: <200304250110.h3P1Aoo02525@magilla.sf.frob.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Two DSOs are built (a int $0x80 one and a sysenter one), using normal
> assembly code and ld -shared with a special linker script.  Both images
> (stripped ELF .so files) are embedded in __initdata space; sysenter_setup
> copies one or the other whole image into the vsyscall page.  Each image is
> a little under 2k (1884 and 1924) now, and could be trimmed a little bit
> with some specialized ELF stripping that ld and strip don't do.  Adding
> additional entry points should not have much additional overhead beyond the
> code itself and the string size of new symbol names.

We already embed a cpio archive into __initdata space.  What about 
putting the images in there, and either copying the data out of 
initramfs, or, directly referencing the pages that store each image?

	Jeff


