Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268349AbUIGTez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268349AbUIGTez (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 15:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268594AbUIGTdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 15:33:54 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:40974 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S268506AbUIGTdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 15:33:01 -0400
Date: Tue, 7 Sep 2004 21:32:29 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unneeded #include <version.h> in many places ?
Message-ID: <20040907193229.GD2454@fs.tum.de>
References: <m3d60yxdce.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3d60yxdce.fsf@defiant.pm.waw.pl>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 06:17:53PM +0200, Krzysztof Halasa wrote:

> Hi,

Hi Krzysztof,

> I noticed some kernel .c files #include <version.h> which typically
> contains something like:
> 
> #define UTS_RELEASE "2.6.9-rc1"
> #define LINUX_VERSION_CODE 132617
> #define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))
> 
> However, those files don't reference the macros.
> 
> The question is: are these includes completely unneeded, so I can
> remove them, or do they serve some special purpose?

they don't serve any special purpose.

But please doublecheck that they are really not needed.

> Another one: there are drivers using constructs like:
> 
> #if LINUX_VERSION_CODE > 0x20115
> ...
> #endif
> 
> I understand they can be somehow useful for authors supporting many
> kernel versions with a single set of files, however the gain isn't
> clear to me. Should such conditional code be a) removed, b) left
> in place, c) dealt with each case individually?

c)

Many driver authors share their code this way between different major 
kernel versions, which makes it easier for them to maintain their code.

#ifdef's for kernel 2.4 are often still actively maitained.

#ifdef's for kernel 2.2 are only very rarely actively maitained.

#ifdef's for kernel 2.0 (as in your example) are most likely completely 
obsolete.

> Krzysztof Halasa

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

