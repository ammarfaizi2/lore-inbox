Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVDOTie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVDOTie (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 15:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVDOTie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 15:38:34 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:33721 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261938AbVDOTi2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 15:38:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P5qAkhkx8LYRBKM0taCtHHu+RkGbaYxQfH6gtrc0dfB55/Sf3+OpT3+bdTMce7Id+iBHkao0+cChNRozBUdFCu8fOIVWT3XFwXRIW4Uh2uAzAaBJMSEQYQ35OSi6xtTVaM/8wOAkJMF5XvoxeAJzfzegwKZPV92MBA4D8f2W4+Q=
Message-ID: <e1e1d5f4050415123842c96ec5@mail.gmail.com>
Date: Fri, 15 Apr 2005 12:38:27 -0700
From: Daniel Souza <thehazard@gmail.com>
Reply-To: Daniel Souza <thehazard@gmail.com>
To: Allison <fireflyblue@gmail.com>
Subject: Re: Kernel Rootkits
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17d7988050415121537c8fac1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <17d7988050415121537c8fac1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/05, Allison <fireflyblue@gmail.com> wrote:
> Isn't the kernel code segment marked read-only ? How can the module
> write into the function text in the kernel ? Shouldn't this cause some
> kind of protection fault ?

The kernel code segment is totally unacessible to userspace programs,
and to kernel itself, is marked read-write. A module runs at kernel
level, so, it has +rw to kernel memory. Each process has a task
structure that defines the top of memory that the user process can
access (current->fs). In normal processes, this is 0xbfffff (the last
adressable memory in user mode). After that, 0xc00000, starts the
kernel code. If, by using any method, a user process receives a
(current->fs = KERNEL_DS), it will be able to fully access the kernel
memory. As mentioned, this is unsual.

-- 
# (perl -e "while (1) { print "\x90"; }") | dd of=/dev/evil
