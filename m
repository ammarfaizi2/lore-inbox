Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbUDMTQa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 15:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263693AbUDMTQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 15:16:29 -0400
Received: from mail.kroah.org ([65.200.24.183]:3043 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263692AbUDMTQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 15:16:23 -0400
Date: Tue, 13 Apr 2004 09:32:07 -0700
From: Greg KH <greg@kroah.com>
To: Jim Gifford <maillist@jg555.com>
Cc: Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with uhci_usb
Message-ID: <20040413163207.GA7198@kroah.com>
References: <26e601c420e5$4087ae90$d100a8c0@W2RZ8L4S02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26e601c420e5$4087ae90$d100a8c0@W2RZ8L4S02>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 04:24:07PM -0700, Jim Gifford wrote:
> cat /proc/interrrupts - output
> 
>            CPU0       CPU1
>   0:  139683637         37    IO-APIC-edge  timer
>   1:        510          1    IO-APIC-edge  i8042
>   2:          0          0          XT-PIC  cascade
>   3:      94944          1    IO-APIC-edge  serial
>   4:        168          1    IO-APIC-edge  serial
>   7:          0          0    IO-APIC-edge  parport0
>   8:          0          1    IO-APIC-edge  rtc
>   9:     466512          0   IO-APIC-level  megaraid
>  11:    1163951          1   IO-APIC-level  eth0, eth1, eth2, eth3
>  15:      24533          1   IO-APIC-level  aic7xxx, aic7xxx

Hm, no usb driver there...

> 00:13.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])

Looks like a OHCI controller...

> Modules Loaded         uhci_hcd usbcore videodev hfs vfat fat isofs
> zlib_inflate floppy ext2 nfsd exportfs lockd sunrpc parport_pc lp parport
> ipt_TOS ipt_TCPMSS ipt_state ipt_REJECT ipt_LOG ipt_limit iptable_mangle
> iptable_nat ip_conntrack_irc ip_conntrack_ftp ip_conntrack iptable_filter
> ip_tables af_packet bonding 8250 serial_core tulip crc32 rtc supermount unix
> aic7xxx megaraid sd_mod scsi_mod

Yup, no ohci module either.  How about building the usb ohci module
(ohci-hcd) and trying that?  It should fix your problem.

Hope this helps,

greg k-h
