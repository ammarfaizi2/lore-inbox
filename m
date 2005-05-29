Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbVE2EiC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVE2EiC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 00:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVE2EiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 00:38:01 -0400
Received: from smtpout.mac.com ([17.250.248.84]:41215 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261232AbVE2EZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 00:25:37 -0400
In-Reply-To: <20050528215005.GA5990@redhat.com>
References: <Pine.LNX.4.62.0505282333210.5800@anakin> <20050528215005.GA5990@redhat.com>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1FA58BE7-0EE6-432B-9383-F489F9854DBE@mac.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       David Airlie <airlied@linux.ie>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] DRM depends on ???
Date: Sun, 29 May 2005 00:25:10 -0400
To: Dave Jones <davej@redhat.com>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 28, 2005, at 17:50:05, Dave Jones wrote:
> On Sat, May 28, 2005 at 11:39:00PM +0200, Geert Uytterhoeven wrote:
>>  config DRM
>>      tristate "Direct Rendering Manager (XFree86 4.1.0 and higher  
>> DRI support)"
>> -    depends on AGP || AGP=n
>> +    depends on (AGP || AGP=n) && PCI
>>
>
> The whole dependancy seems like nonsense to me.
> I think
>
>     depends on PCI
>
> is a lot more sensible.

I think the original reasoning was something like this:

If DRM is built-in, then AGP _must_ be built-in or not included at  
all, modular
won't work.  If DRM is modular or not built, then AGP may be built- 
in, modular,
or not built at all.

The "depends on AGP || AGP=n" means that if DRM=y, then AGP=y or  
AGP=n, and if
DRM=m or DRM=n, then AGP=y or AGP=m or AGP=n.

Yes it's unclear and yes it should probably be documented in a  
comment somewhere.



Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



