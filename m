Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270659AbTHOSOs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 14:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270671AbTHOSOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 14:14:48 -0400
Received: from [69.15.40.52] ([69.15.40.52]:28314 "EHLO
	crown.reflexsecurity.com") by vger.kernel.org with ESMTP
	id S270659AbTHOSOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 14:14:46 -0400
Date: Fri, 15 Aug 2003 14:14:19 -0400
From: Jason Lunz <lunz@gtf.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jbaron@redhat.com, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: pivot_root solved by patch to 2.4.22-pre7
Message-ID: <20030815181418.GA9978@reflexsecurity.com>
References: <Pine.LNX.4.44.0308071120210.894-100000@dhcp64-178.boston.redhat.com> <1060271448.3123.75.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060271448.3123.75.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In gmane.linux.kernel, you wrote:
>> the unshare_files change causes init to no longer share the same fd table
>> with the other kernel threads. thus, when init closes or opens fds it does
> 
> Ah yes.. because of do_basic_setup. Having /sbin/init sharing with
> kernel threads doesn't actually strike me as too clever anyway although
> none of them should be using fd stuff.
> 
> In which case I guess we should call unshare_files directly before we
> open /dev/console in init/main.c.

Is this going to be fixed for 2.4.22? In -rc2, I still get this after
pivot_root (I'm using pivot_root, but not initrd):

	halfoat:0:~ # umount /mnt
	umount: /mnt: device is busy
	halfoat:1:~ # lsof /mnt
	COMMAND   PID USER   FD   TYPE DEVICE SIZE NODE NAME
	keventd     2 root    0u   CHR    5,1        21 /mnt/dev/console
	keventd     2 root    1u   CHR    5,1        21 /mnt/dev/console
	keventd     2 root    2u   CHR    5,1        21 /mnt/dev/console
	ksoftirqd   3 root    0u   CHR    5,1        21 /mnt/dev/console
	ksoftirqd   3 root    1u   CHR    5,1        21 /mnt/dev/console
	ksoftirqd   3 root    2u   CHR    5,1        21 /mnt/dev/console
	ksoftirqd   4 root    0u   CHR    5,1        21 /mnt/dev/console
	ksoftirqd   4 root    1u   CHR    5,1        21 /mnt/dev/console
	ksoftirqd   4 root    2u   CHR    5,1        21 /mnt/dev/console
	kswapd      5 root    0u   CHR    5,1        21 /mnt/dev/console
	kswapd      5 root    1u   CHR    5,1        21 /mnt/dev/console
	kswapd      5 root    2u   CHR    5,1        21 /mnt/dev/console
	bdflush     6 root    0u   CHR    5,1        21 /mnt/dev/console
	bdflush     6 root    1u   CHR    5,1        21 /mnt/dev/console
	bdflush     6 root    2u   CHR    5,1        21 /mnt/dev/console
	kupdated    7 root    0u   CHR    5,1        21 /mnt/dev/console
	kupdated    7 root    1u   CHR    5,1        21 /mnt/dev/console
	kupdated    7 root    2u   CHR    5,1        21 /mnt/dev/console
	kjournald  64 root    0u   CHR    5,1        21 /mnt/dev/console
	kjournald  64 root    1u   CHR    5,1        21 /mnt/dev/console
	kjournald  64 root    2u   CHR    5,1        21 /mnt/dev/console

Jason
