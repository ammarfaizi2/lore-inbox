Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263406AbTHXDji (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 23:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbTHXDji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 23:39:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:14278 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263414AbTHXDjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 23:39:36 -0400
Date: Sat, 23 Aug 2003 20:42:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: dan@merillat.org
Cc: linux-kernel@vger.kernel.org, harik@chaos.ao.net,
       Oleg Drokin <green@namesys.com>
Subject: Re: Reiserfs kernel-crashing bug in 2.4.20 (and UML)
Message-Id: <20030823204201.06c706c1.akpm@osdl.org>
In-Reply-To: <4878.24.165.250.16.1061688482.squirrel@mail.merillat.org>
References: <4878.24.165.250.16.1061688482.squirrel@mail.merillat.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dan@merillat.org wrote:
>
>  Let's get this out of the way first: I KNOW IT'S A HARDWARE BUG.  My
>  system wrote corrupted data to the drive.  I've already recovered the
>  partition but I have a dd'd copy around to figure this out.
> 
>  With that out of the way:
> 
>  I can reliably insta-reboot my kernel or cause user-mode-linux to crash
>  out when doing a directory lookup in one corrupted directory.
> 
>  The catch is, (and there's always a catch) neither oopses.  real kernel on
>  real hardware just flashes the screen and reboots, user-mode-linux just
>  drops back to the host's shell prompt.
> 
>  Here's what I've found using UML on it:
> 
>  The directory is one block, but we're reading data 100+k into it.  Perhaps
>  a sanity check that we're actually within the buffer we want to be?

You're absolutely right.  Filesystem drivers should try hard to not crash
the box when fed random crap.

> +		if (d_reclen < 0)
> +			return -EIO;

It needs to be checked for some upper bound as well.


