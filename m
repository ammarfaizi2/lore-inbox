Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271377AbTGQKLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 06:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271378AbTGQKLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 06:11:15 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:25363 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S271377AbTGQKLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 06:11:11 -0400
Date: Thu, 17 Jul 2003 12:26:00 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030717122600.A2302@pclin040.win.tue.nl>
References: <20030716184609.GA1913@kroah.com> <20030716130915.035a13ca.akpm@osdl.org> <20030716210253.GD2279@kroah.com> <20030716141320.5bd2a8b3.akpm@osdl.org> <20030716213451.GA1964@win.tue.nl> <20030716143902.4b26be70.akpm@osdl.org> <20030716222015.GB1964@win.tue.nl> <20030716152143.6ab7d7d3.akpm@osdl.org> <20030717014410.A2026@pclin040.win.tue.nl> <20030716164917.2a7a46f4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030716164917.2a7a46f4.akpm@osdl.org>; from akpm@osdl.org on Wed, Jul 16, 2003 at 04:49:17PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 04:49:17PM -0700, Andrew Morton wrote:
> Andries Brouwer <aebr@win.tue.nl> wrote:
>
> > > Why would anyone hand the kernel a 32-bit device number?
> > > They're either 16 or 64, are they not?
> > 
> > The kernel has no control over what userspace comes with.
> > And here userspace includes filesystems.
> > Not all filesystems know how to come with 64 bits.
> 
> What does "comes with" mean?
> 
> Please describe a scenario in which a filesystem which works on current
> kernels will, in a 64-bit-dev_t kernel, call init_special_inode() with a
> 16:16 encoded device number.

:-) You change the subject.
There are many filesystems that only have room for 32 bits.
For example, NFSv2 has "unsigned int rdev".
So, the kernel must be able to handle 32-bit device numbers.

Now about the encoding - nobody knows. This NFS filesystem was mounted
from a FreeBSD system. It is encoded 16+8+8 with the middle 8 the major.
Or, no, it was Solaris or Irix. Encoded 14+18. Etc.

In the case of NFSv2 there is an unknown system on the other side.
Internally for Linux we have not yet used larger device numbers
so there are no cases of 16+16 yet. But there will be occasions
where we have to store a device number in 32 bits, and what I am
saying is that life is easiest if we use 16+16 in such cases.

Andries

