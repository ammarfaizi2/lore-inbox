Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVE2XA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVE2XA4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 19:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVE2XA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 19:00:56 -0400
Received: from smtpout.mac.com ([17.250.248.86]:63197 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261346AbVE2XAn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 19:00:43 -0400
In-Reply-To: <Pine.LNX.4.62.0505292157130.12948@numbat.sonytel.be>
References: <Pine.LNX.4.62.0505282333210.5800@anakin> <20050528215005.GA5990@redhat.com> <1FA58BE7-0EE6-432B-9383-F489F9854DBE@mac.com> <Pine.LNX.4.58.0505290809180.9971@skynet> <Pine.LNX.4.62.0505292157130.12948@numbat.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <64148E06-2DFA-41A5-9D86-5F34DCAAF9F4@mac.com>
Cc: Dave Airlie <airlied@linux.ie>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] DRM depends on ???
Date: Sun, 29 May 2005 19:00:28 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 29, 2005, at 15:58:10, Geert Uytterhoeven wrote:
>> What Kyle said is the correct answer... we either keep this lovely
>> construct (I'll add a comment for 2.6.13) or we go back to the old
>> intermodule or module_get stuff... DRM built-in with modular AGP  
>> is always
>> wrong... or at least I'll get a hundred e-mails less every month if I
>> say it is ..
>
> And what if we don't have AGP at all? Or no PCI?

Then DRM detects that at configure time and excludes the code that  
requires
AGP.  Basically, the following are valid configurations:

DRM=y AGP=y  # DRM will use AGP
DRM=y AGP=n  # DRM will not use AGP

DRM=m AGP=y  # DRM will use AGP
DRM=m AGP=m  # DRM will use AGP (DRM module depends on AGP module)
DRM=m AGP=n  # DRM will not use AGP

DRM=n AGP=*  # DRM isn't compiled and therefore doesn't care about AGP

The only invalid configuration is DRM=y AGP=m, which seems silly,  
although
theoretically in that case DRM should exclude AGP support.



Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



