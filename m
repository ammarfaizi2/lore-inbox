Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316217AbSHIWdz>; Fri, 9 Aug 2002 18:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316223AbSHIWdz>; Fri, 9 Aug 2002 18:33:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:23300 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316217AbSHIWdz>; Fri, 9 Aug 2002 18:33:55 -0400
Message-ID: <3D544412.5020307@zytor.com>
Date: Fri, 09 Aug 2002 15:37:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Matti Aarnio <matti.aarnio@zmailer.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: klibc development release
References: <aivdi8$r2i$1@cesium.transmeta.com> <200208090934.g799YVZe116824@d12relay01.de.ibm.com> <200208091754.g79HsJkN058572@d06relay02.portsmouth.uk.ibm.com> <3D541018.4050004@zytor.com> <15700.4689.876752.886309@napali.hpl.hp.com> <3D541478.40808@zytor.com> <20020809222736.GJ32427@mea-ext.zmailer.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
> 
>   History...   Initially I thought you are describing something
>   different from Linux model (after all, different platforms have
>   different ABIs for syscalls, leading to different call-vector
>   tables, etc.)  but no, I see no difference from this description.
> 
>   How NetBSD handles the issue, I don't know.   One interpretation
>   of what you say is that when a new architecture is added to NetBSD,
>   it will instantly inherit the entire historical set of syscalls,
>   including the obsolete ones.
> 

What NetBSD does is that they treat the system call mechanism as a
special kind of function call... like an RPC stub kind of thing.  Just
like it's not visible to the C programmer how a particular architecture
is implementing a function call, on NetBSD all one really needs to know
is the system call number (which is architecture independent!) and its
prototype, and you can generate both user-side and kernel-side stubs for
this system call, ending up with it calling a function in the generic
kernel code (sys_mmap(), or whatever.)

It seems to me that the big losers of the Linux model are the smaller
architectures, since most people aren't going to be able to know when
they're breaking something on, for example, alpha, cris or s390, and
they're certainly not going to know how to add something to them.

	-hpa

