Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751098AbVKNMIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbVKNMIM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 07:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751099AbVKNMIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 07:08:12 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:36558 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751098AbVKNMIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 07:08:11 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] implement generic rtc compat ioctl handling
Date: Mon, 14 Nov 2005 13:09:36 +0100
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, ak@suse.de, linux-kernel@vger.kernel.org
References: <20051111092021.GA26750@lst.de>
In-Reply-To: <20051111092021.GA26750@lst.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511141309.37180.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Freedag 11 November 2005 10:20, Christoph Hellwig wrote:
> +static int rtc_ioctl(unsigned fd, unsigned cmd, unsigned long arg)
> +{
> +       compat_ulong_t __user *val = compat_alloc_user_space(sizeof(*val));
> +       compat_ulong_t __user *uval = (compat_ulong_t __user *)arg;
> +       int ret;
> +
> 
This one should really be 

compat_ulong_t __user *uval = compat_ptr(arg);

It's not really a problem since the only architecture where compat_ptr()
makes a difference (64 bit s390) doesn't have an RTC driver, but it
should be changed nevertheless.

Also, I suppose the declaration of val is wrong, since the ioctl methods
expect a pointer to an unsigned long, not a compat_ulong_t. If you
change that, the copy_in_user() won't work either.

	Arnd <><
