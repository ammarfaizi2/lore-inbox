Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289581AbSAJSS7>; Thu, 10 Jan 2002 13:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289589AbSAJSSu>; Thu, 10 Jan 2002 13:18:50 -0500
Received: from quark.didntduck.org ([216.43.55.190]:28165 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S289581AbSAJSSn>; Thu, 10 Jan 2002 13:18:43 -0500
Message-ID: <3C3DDAFB.E1DC0EFB@didntduck.org>
Date: Thu, 10 Jan 2002 13:18:35 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: f.jimenez@bigfoot.com
CC: linux-kernel@vger.kernel.org
Subject: Re: array size limit in module?
In-Reply-To: <20020110181054Z289122-13997+3040@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Jimenez wrote:
> 
> Hi
> 
> I am trying to code a simple kernel module and I have found a problem I don't
> quite understand.
> 
> Here is the offending part of code:
> 
> char *sectors_array = NULL;
> ........
> secs_size=131072;
> sectors_array = kmalloc(secs_size*sizeof(char), GFP_KERNEL);
> for(i=0; i<secs_size; i++) {
>         sectors_array[i]=0;
> }
> 
> This bit of code, as it is, works fine. However, if I increment secs_size by
> one, ie, I do 'secs_size=131073;' instead of 131072, I get the following:

Use vmalloc for allocations that large, unless you must have the memory
physically contiguous.  128k is the largest amount of memory you can
allocate with kmalloc.

--

				Brian Gerst
