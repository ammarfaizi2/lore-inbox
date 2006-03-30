Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWC3Utr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWC3Utr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 15:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWC3Utr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 15:49:47 -0500
Received: from mail.gmx.de ([213.165.64.20]:23766 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750858AbWC3Utr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 15:49:47 -0500
X-Authenticated: #31060655
Message-ID: <442C4469.1040408@gmx.net>
Date: Thu, 30 Mar 2006 22:49:45 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.12) Gecko/20050921
X-Accept-Language: de, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Spurious rebuilds of raid6 and drivers/media/video in 2.6.16
References: <442BC74B.7060305@gmx.net> <20060330202208.GA14016@mars.ravnborg.org>
In-Reply-To: <20060330202208.GA14016@mars.ravnborg.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg schrieb:
> On Thu, Mar 30, 2006 at 01:55:55PM +0200, Carl-Daniel Hailfinger wrote:
> 
>>Hi,
>>
>>if I copy a compiled kernel tree to another location and run
>>make again in the new directory, a few files always get rebuilt.
>>These files only are rebuilt if the tree is a copy of another
>>tree and they are rebuilt only once.
>>Any ideas why this is the case?
> 
> The reason why the predictive rebuild happens is that in some parts
> of the kbuild files it has been necessary to use absolute paths.
> One example is the oiu2c shell script where we use the full path
> to locate the shell script.
> The reason why a full path is used is that this shall also work when
> compiling the kernel using make O=...

Thanks for the information.

> So the rebuild will happen. It would be possible to minimize the places
> where a rebuild is triggered when moving the source tree, but I have not
> seen any benefit doing so lately.

Well, it would cause less confusion. It seems that ~90% of rebuilt files
are due to the following makefiles where full paths to includes are
specified:
./drivers/media/video/cx88/Makefile
./drivers/media/video/Makefile
./drivers/media/video/cx25840/Makefile
./drivers/media/video/saa7134/Makefile
./drivers/media/video/em28xx/Makefile

Any objections to fix these?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
