Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267615AbUHMWeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267615AbUHMWeP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 18:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267629AbUHMWeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 18:34:15 -0400
Received: from monet.celtelplus.com ([217.113.64.7]:56765 "EHLO
	monet.celtelplus.com") by vger.kernel.org with ESMTP
	id S267615AbUHMWeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 18:34:14 -0400
Message-ID: <411D41DD.1080005@celtelplus.com>
Date: Sat, 14 Aug 2004 00:34:05 +0200
From: Anand Buddhdev <anand@celtelplus.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [solved] binfmt_misc trouble with kernel 2.6.7
References: <411CF503.40202@celtelplus.com>
In-Reply-To: <411CF503.40202@celtelplus.com>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anand Buddhdev wrote:

> Hi,
> 
> A few days ago I upgraded to fedora kernel 2.6.7-1.494.2.2. Before that, 
> I had kernels in which binfmt_misc was compiled as a module. The wine 
> init script modprobe'd the module and then registered /usr/bin/wine as a 
> handler for windows executables. However, in the new 2.6.7 kernel, 
> binfmt_misc is compiled into the kernel, so the modprobe in the wine 
> init script fails. I can fix that, but main problem I am having is that 
> now, the permissions on the /proc/sys/fs/binfmt_misc directory are 0555:
> 
> dr-xr-xr-x  2 root root 0 Aug 13 19:04 /proc/sys/fs/binfmt_misc
> 
> I cannot create a file called register under /proc/sys/fs/binfmt_misc.
> 
> I created a Fedora bugzilla entry for this but I was told that this is a 
> problem in the kernel upstream. Is this indeed a known problem, and is 
> there a fix?

Geoffrey Leach from the Fedora list provided a hint to the solution. 
There's no bug. I just have to add:

none  /proc/sys/fs/binfmt_misc  binfmt_misc  defaults  0 0

to my /etc/fstab, and then the /proc/sys/fs/binfmt_misc directory 
becomes writable, with a register and a status file in it. Sorry to have 
bothered you all.
