Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbTEYPh7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 11:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbTEYPh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 11:37:59 -0400
Received: from waste.org ([209.173.204.2]:46497 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263295AbTEYPh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 11:37:58 -0400
Date: Sun, 25 May 2003 10:51:02 -0500
From: Matt Mackall <mpm@selenic.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ben Collins <bcollins@debian.org>, Patrick Mochel <mochel@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Resend [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Message-ID: <20030525155102.GN23715@waste.org>
References: <20030525000701.GG504@phunnypharm.org> <Pine.LNX.4.44.0305242045050.1666-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305242045050.1666-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 24, 2003 at 08:52:53PM -0700, Linus Torvalds wrote:
> 
> How about just adding a sane
> 
> 	int copy_string(char *dest, const char *src, int len)
> 	{
> 		int size;
> 
> 		if (!len)
> 			return 0;
> 		size = strlen(src);
> 		if (size >= len)
> 			size = len-1;
> 		memcpy(dest, src, size);
> 		dest[size] = '\0';
> 		return size;
> 	}

The return value here isn't particularly useful. The OpenBSD
strlcpy/strlcat variant tell you how big the result should have been
so that you can realloc if need be.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
