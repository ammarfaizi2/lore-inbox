Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSFGBz0>; Thu, 6 Jun 2002 21:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316595AbSFGBzZ>; Thu, 6 Jun 2002 21:55:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48648 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316342AbSFGBzY>;
	Thu, 6 Jun 2002 21:55:24 -0400
Message-ID: <3D001363.BDEBD682@zip.com.au>
Date: Thu, 06 Jun 2002 18:58:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa1
In-Reply-To: <20020607003413.GH1004@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> Only in 2.4.19pre10aa1: 90_ext3-commit-interval-1
> 
>         Avoid laptops to waste energy despite kupdate interval is set
>         to 2 hours with ext3. kjournald has no right to choose
>         "how frequently" we should look for old transactions, that's
>         an user problem. journaling doesn't enforce how much old data
>         we can lose after a 'reboot -f', it only enforces that the
>         metadata or even the data will be coherent after an hard reboot.

Yes, that'll work OK.   It's a wild implementation though.  Why not
just add

int bdflush_min(void)
{
	return bdf_prm.b_un.interval;
}
EXPORT_SYMBOL(bdflush_min);

to fs/buffer.c?

(You forgot to export bdf_prm, btw).

-
