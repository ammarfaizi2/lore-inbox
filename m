Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030598AbWAGVor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030598AbWAGVor (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030599AbWAGVor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:44:47 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:20196 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030598AbWAGVoq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:44:46 -0500
Date: Sat, 7 Jan 2006 13:44:39 -0800
From: "Kurtis D. Rader" <kdrader@us.ibm.com>
To: Dave Jones <davej@redhat.com>, Bernd Eckenfels <be-news06@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: oops pauser. / boot_delayer
Message-ID: <20060107214439.GA13433@us.ibm.com>
References: <20060104221023.10249eb3.rdunlap@xenotime.net> <E1EuPZg-0008Kw-00@calista.inka.de> <20060105111105.GK20809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105111105.GK20809@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 06:11:05, Dave Jones wrote:
> On Thu, Jan 05, 2006 at 08:30:16AM +0100, Bernd Eckenfels wrote:
>  > Randy.Dunlap <rdunlap@xenotime.net> wrote:
>  > > This one delays each printk() during boot by a variable time
>  > > (from kernel command line), while system_state == SYSTEM_BOOTING.
>  >
>  > This sounds a bit like a aprils fool joke, what it is meant to do? You can
>  > read the messages in the bootlog and use the scrollback keys, no?
> 
> could be handy for those 'I see a few messages that scroll, and the
> box instantly reboots' bugs.  Quite rare, but they do happen.

Another very common situation is a system which fails to boot due to
failures to find the root filesystem. This can happen because of device name
slippage, root disk not being found, the proper HBA driver isn't present in
the initrd image, etc. The customer calls us and reports the last thing they
see on the screen:

    Mounting root filesystem
    Kmod : failed to exec /sbin/modprobe -s -k block-major-8 , error = 2
    mount : error 6 mounting ext3
    pivotroot : pivot_root(/sysroot,.sysroot/initrd) failed : 2
    Freeing unused memory
    Kernel panic : No init found . Try passing init= option to kernel

Great! Only problem is the info we really need has already scrolled of the
screen. An option to pause briefly after each boot time printk would be very
useful.
