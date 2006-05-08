Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWEHVXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWEHVXs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 17:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWEHVXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 17:23:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:13498 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751090AbWEHVXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 17:23:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=A7Re09nPJidsrvH6lFbbDkw4Wqn3BvJC7rkcP9cEkQjB0yNMrCA36lkTQeNrBouqSOuMeqZbVknCkVta1QLUFC6v5P0YsxWvl/Ja7zUR7lqsiuNSJlu5scWp+6vXthmxmCHYQH3u+tMO5FaXW6xkTa49dLjDjthZQKPeux+yNKo=
Date: Tue, 9 May 2006 01:22:15 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@osdl.org
Cc: bjdouma@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: + two-additions-to-linux-documentation-ioctl-numbertxt.patch added to -mm tree
Message-ID: <20060508212215.GD7235@mipter.zuzino.mipt.ru>
References: <200605081751.k48HpCfT016898@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605081751.k48HpCfT016898@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 10:48:40AM -0700, akpm@osdl.org wrote:
>      two additions to ./linux/Documentation/ioctl-number.txt

> --- devel/Documentation/ioctl-number.txt~two-additions-to-linux-documentation-ioctl-numbertxt
> +++ devel-akpm/Documentation/ioctl-number.txt
> @@ -85,7 +85,9 @@ Code	Seq#	Include File		Comments

>  'C'	all	linux/soundcard.h
>  'D'	all	asm-s390/dasd.h
> +'E'	all	linux/input.h

This one is good.

>  'F'	all	linux/fb.h
> +'H'	all	linux/hiddev.h

Quick grep shows 'H' namespace is kinda-sorta divided between some bluetooth
headers, hiddev.h (as was correctly noted) and sound SNDRV_*. Of course,
it's worse because ALSA and hiddev.h ioctls conflict pretty often.

Was second column "Seq#" meant to be central registration point of new
ioctls? If it's, boundaries are not obeyed and comments like

	/*
	 * IOCTLS (0x00 - 0x7f)
	 */

should be removed probably from everywhere to not give false sense of
ownership TOGETHER with rejecting every new conflicting ioctl.

