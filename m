Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWCVHOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWCVHOJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 02:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWCVHOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 02:14:09 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:46788 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750965AbWCVHOI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 02:14:08 -0500
Message-ID: <4420F93C.1050705@garzik.org>
Date: Wed, 22 Mar 2006 02:14:04 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, klibc@zytor.com,
       Al Viro <viro@ftp.linux.org.uk>, hpa@zytor.com, miltonm@bga.com
Subject: Re: [PATCH] initramfs: CPIO unpacking fix
References: <20060216183745.50cc2bf6.mikey@neuling.org>	<20060217160621.99b0ffd4.mikey@neuling.org> <20060322061220.8414067A70@ozlabs.org>
In-Reply-To: <20060322061220.8414067A70@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.5 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.5 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Neuling wrote:
> Unlink files, symlinks, FIFOs, devices etc. (except directories) before
> writing them when extracting CPIOs.  This stops weird behaviour like:
>  1) writing through symlinks created in earlier CPIOs. eg foo->bar in
>     the first CPIO.  Having foo as a non-link in a subsequent CPIO,
>     results in bar being written and foo remaining as a symlink.  
>  2) if the first version of file foo is larger than foo in a
>     subsequent CPIO, we end up with a mix of the two.  ie. neither
>     the first or second version of /foo.
>  3) special files like devices, fifo etc. can't be overwritten in
>     subsequent CPIOS.
> 
> With this, the kernel will more closely replicate
>   for i in *.cpio; do cpio --extract --unconditional < $i ; done
> 
> This is a change but it's regarded as fixing broken functionality.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

For the kernel, I would regard that as needless code...  Coding for a 
chain of CPIO archives overwriting each other seems like overengineering.

	Jeff



