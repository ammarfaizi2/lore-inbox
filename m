Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbUEFNiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbUEFNiQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUEFNhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:37:45 -0400
Received: from hera.cwi.nl ([192.16.191.8]:34776 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262311AbUEFNgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:36:44 -0400
Date: Thu, 6 May 2004 15:36:39 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andries.Brouwer@cwi.nl, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] report size of printk buffer
Message-ID: <20040506133639.GB14714@apps.cwi.nl>
References: <UTC200405041609.i44G9CH29412.aeb@smtp.cwi.nl> <Pine.LNX.4.44.0405052236110.766-100000@serv.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405052236110.766-100000@serv.local>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 10:42:10PM +0200, Roman Zippel wrote:

> On Tue, 4 May 2004 Andries.Brouwer@cwi.nl wrote:
> 
> > In the old days the printk log buffer had a constant size,
> > and dmesg asked for the 4096, later 8192, later 16384 bytes in there.
> > These days the printk log buffer has variable size, and it is not
> > easy for dmesg to do the right thing, especially when doing a
> > "read and clear".
> 
> Why don't you simply change it into "read and clear read data"?
> E.g. something like below.
> 
> bye, Roman
> 
> Index: kernel/printk.c
> ===================================================================
> RCS file: /usr/src/cvsroot/linux-2.6/kernel/printk.c,v
> retrieving revision 1.1.1.6
> diff -u -p -r1.1.1.6 printk.c
> --- a/kernel/printk.c	11 Mar 2004 18:34:55 -0000	1.1.1.6
> +++ b/kernel/printk.c	5 May 2004 20:39:05 -0000
> @@ -305,7 +305,7 @@ int do_syslog(int type, char __user * bu
>  		if (count > logged_chars)
>  			count = logged_chars;
>  		if (do_clear)
> -			logged_chars = 0;
> +			logged_chars -= count;
>  		limit = log_end;
>  		/*

No, that is buggy.

If one asks for count bytes, one gets the last count bytes of output,
not the first.

Andries
