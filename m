Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266306AbUGUAHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266306AbUGUAHM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 20:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUGUAHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 20:07:12 -0400
Received: from berrymount.xs4all.nl ([82.92.47.16]:26975 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S266306AbUGUAHI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 20:07:08 -0400
Date: Wed, 21 Jul 2004 02:05:20 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
To: Shesha Sreenivasamurthy <shesha@inostor.com>
Cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: O_DIRECT
Message-Id: <20040721020520.4d171db7.robn@verdi.et.tudelft.nl>
In-Reply-To: <40FD561D.1010404@inostor.com>
References: <40FD561D.1010404@inostor.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jul 2004 10:27:57 -0700
Shesha Sreenivasamurthy <shesha@inostor.com> wrote:

Hi Shesha,

> I am having trouble with O_DIRECT. Trying to read or write from a block 
> device partition.
> 
> 1. Can O_DIRECT be used on a plain block device partition say 
> "/dev/sda11" without having a filesystem on it.

yes.

> 2. If no file system is created then what should be the softblock size. 
> I am using the IOCTL "BLKBSZGET". Is this correct?

yes.

> 3. Can we use SEEK_END with O_DIRECT on a partition without filesystem.

yes.

I'm using these exact things in an application.

Note that with 2.4 kernels the "granularity" you can use for offset
and r/w size is the softblock size (*).  For 2.6 the requirements are
much more relaxed: it's the device blocksize (typically 512 byte).

(*): actually one of offset or r/w size has a smaller minimum if
I remember correctly.  Don't remember which one.  But if you assume
the softblock size as a minimum for both you're allways safe.

	greetings,
	Rob van Nieuwkerk
