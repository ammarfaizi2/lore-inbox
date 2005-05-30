Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVE3LMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVE3LMG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 07:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVE3LJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 07:09:33 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:36871 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261434AbVE3LHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 07:07:25 -0400
Message-ID: <429AF53B.3080805@aitel.hist.no>
Date: Mon, 30 May 2005 13:12:59 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, Dave Airlie <airlied@linux.ie>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] DRM depends on ???
References: <Pine.LNX.4.62.0505282333210.5800@anakin> <20050528215005.GA5990@redhat.com> <1FA58BE7-0EE6-432B-9383-F489F9854DBE@mac.com> <Pine.LNX.4.58.0505290809180.9971@skynet> <Pine.LNX.4.62.0505292157130.12948@numbat.sonytel.be> <64148E06-2DFA-41A5-9D86-5F34DCAAF9F4@mac.com>
In-Reply-To: <64148E06-2DFA-41A5-9D86-5F34DCAAF9F4@mac.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:

> On May 29, 2005, at 15:58:10, Geert Uytterhoeven wrote:
>
>>> What Kyle said is the correct answer... we either keep this lovely
>>> construct (I'll add a comment for 2.6.13) or we go back to the old
>>> intermodule or module_get stuff... DRM built-in with modular AGP  is 
>>> always
>>> wrong... or at least I'll get a hundred e-mails less every month if I
>>> say it is ..
>>
>>
>> And what if we don't have AGP at all? Or no PCI?
>
>
> Then DRM detects that at configure time and excludes the code that  
> requires
> AGP.  Basically, the following are valid configurations:
>
> DRM=y AGP=y  # DRM will use AGP
> DRM=y AGP=n  # DRM will not use AGP
>
> DRM=m AGP=y  # DRM will use AGP
> DRM=m AGP=m  # DRM will use AGP (DRM module depends on AGP module)
> DRM=m AGP=n  # DRM will not use AGP
>
> DRM=n AGP=*  # DRM isn't compiled and therefore doesn't care about AGP
>
> The only invalid configuration is DRM=y AGP=m, which seems silly,  
> although
> theoretically in that case DRM should exclude AGP support.

Why is that case invalid?  I may have DRM=y so I get DRM on my
PCI graphichs card.  Then I might load an agp module in order
to use agp on *some other* agp card. 

I have no problem with DRM=y,AGP=m being invalid for the common
single-card setup, but there are multi-card setups too.  Not that
I need this special case personally - I have two cards but don't use 
modules.

Helge Hafting

