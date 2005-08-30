Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbVH3KwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbVH3KwB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 06:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVH3KwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 06:52:01 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:12189 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751359AbVH3KwA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 06:52:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NNigmbxE/ZnndathJL9m1xIUib4ZSZnBlSDJrXjcy17ZO+2vOXBA9OWig3LxscE0Sy8whD5OI+jgo1+oMRKrwgoErab9oOvpHuU2SBB3gzAI/V3IZxF2DjI66/3FirxY+fSjM02VUvrmuELLTZozQqxcE8duZ+tFxFMaLGbXg3o=
Message-ID: <21d7e997050830035154ea2f88@mail.gmail.com>
Date: Tue, 30 Aug 2005 20:51:57 +1000
From: Dave Airlie <airlied@gmail.com>
To: Michael Marineau <marineam@engr.orst.edu>
Subject: Re: [PATCH 1/3] Generic acpi vgapost
Cc: Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <43111313.8000800@engr.orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43111298.80507@engr.orst.edu> <43111313.8000800@engr.orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/05, Michael Marineau <marineam@engr.orst.edu> wrote:
> Generic function to post the video bios.
> 
> Based directly on the original patch by Ole Rohne.
> 
> Signed-off-by: Michael Marineau <marineam@engr.orst.edu>

The wakeup.S code is missing a small piece of code.

For a  lot of BIOSes you need to set ax to a PCI ID, I have code in my
tree at the moment that does this:

in do_vgapost_lowlevel:
acpi_video_devnum = (pci_dev->bus->number<<8) | (pci_dev->devfn);

and then in the wakeup code
movl video_devnum-wakeup_code, %eax

The code is all in the patch at
http://www.skynet.ie/~airlied/patches/lk/my_pm_diffs
This is just a drop of my current tree from when I was hacking on
suspend/resume at OLS.

Dave.
