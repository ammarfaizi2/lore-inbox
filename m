Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129880AbQKHVJA>; Wed, 8 Nov 2000 16:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129915AbQKHVIv>; Wed, 8 Nov 2000 16:08:51 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:64528 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129880AbQKHVIi>;
	Wed, 8 Nov 2000 16:08:38 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Timur Tabi <ttabi@interactivesi.com>
cc: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>
Subject: Re: multiple definition of `__module_kernel_version' 
In-Reply-To: Your message of "Wed, 08 Nov 2000 14:09:43 MDT."
             <20001108200949Z129150-31179+2040@vger.kernel.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 Nov 2000 08:08:31 +1100
Message-ID: <13202.973717711@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2000 14:09:43 -0600, 
Timur Tabi <ttabi@interactivesi.com> wrote:
>I'm trying to port my driver from 2.4 to 2.2.  When I try to compile it, I get
>several "multiple definition of `__module_kernel_version'" errors:

include/linux/module.h was changed in the 2.3 kernels to define
__module_kernel_version and __module_using_checksums as static.
Without that change you get multiple definitions of the variables when
you link multiple objects into a single module.  In 2.2 you have to
#define __NO_VERSION__ before including module.h in all of the module
objects except one.  Search 2.2 drivers for __NO_VERSION__ to see
examples of this.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
