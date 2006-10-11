Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbWJKSjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbWJKSjZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 14:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbWJKSjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 14:39:25 -0400
Received: from terminus.zytor.com ([192.83.249.54]:5298 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S965078AbWJKSjY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 14:39:24 -0400
Message-ID: <452D3A11.5020100@zytor.com>
Date: Wed, 11 Oct 2006 11:38:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alexander van Heukelum <heukelum@mailshack.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Linus Torvalds <torvalds@osdl.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       John Coffman <johninsd@san.rr.com>
Subject: Re: [PATCH] Remove lilo-loads-only-five-sectors-of-zImage-fixup from
 setup.S
References: <20061011163356.GA2022@mailshack.com>
In-Reply-To: <20061011163356.GA2022@mailshack.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander van Heukelum wrote:
> Hi!
> 
> The real-mode kernel (on i386 and x86_64) checks if the bootloader
> loaded it correctly. Apparantly, very old versions of LILO disregarded
> the setupsects field in the bootsector and always just loaded the first
> five sectors. If the kernel is compiled as a zImage, the real-mode
> kernel is able to rectify the situation. At least it was, until the code
> to do so was moved to the eighth sector in order to make space for more
> E820 entries (commit: f9ba70535dc12d9eb57d466a2ecd749e16eca866). This
> occured on 1 May 2005 and as far as I know, noone has complained yet.
> This patch removes the checks for the signature and the fixup code
> completely.
> 
> Comments? Which bootloaders are still in use? Kill zImage?
> 

Andrew asked me to comment on this...

This removes support for boot loaders that did not understand boot 
loader protocol version 2.00 or later.  This probably includes very 
early versions of LILO as well as the long-since obsolete Bootlin and 
Shoelace.  Those loaders were unable to load bzImages as well.

I have been urging that we kill zImage for a long time.  It is virtually 
impossible to build a kernel today that will fit inside the zImage 512K 
compressed limitation.

It would be useful for setup.S to halt with a message if such an early 
bootloader is detected, however.  This would have to be parked in the 
first 2K of the setup area, and can simply be detected by looking for 
zero in type_of_loader.

	-hpa

