Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266296AbUGPGOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbUGPGOj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 02:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266488AbUGPGOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 02:14:38 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:53694 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S266296AbUGPGOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 02:14:23 -0400
Date: Fri, 16 Jul 2004 08:14:15 +0200
From: David Weinehall <tao@debian.org>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: ACPI Hibernate and Suspend Strange behavior 2.6.7/-mm1
Message-ID: <20040716061415.GM22472@khan.acc.umu.se>
Mail-Followup-To: Florian Weimer <fw@deneb.enyo.de>,
	linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
References: <A6974D8E5F98D511BB910002A50A6647615FEF48@hdsmsx403.hd.intel.com> <1089054013.15671.48.camel@dhcppc4> <pan.2004.07.06.14.14.47.995955@physik.hu-berlin.de> <slrncfb55n.dkv.jgoerzen@christoph.complete.org> <87oemhot7l.fsf@deneb.enyo.de> <20040715213711.GJ22472@khan.acc.umu.se> <87acy1osk1.fsf@deneb.enyo.de> <20040715214646.GK22472@khan.acc.umu.se> <87smbtndba.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87smbtndba.fsf@deneb.enyo.de>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2004 at 11:57:45PM +0200, Florian Weimer wrote:
> * David Weinehall:
> 
> > Strange.  suspend works for me (T40 though, not T40p), latest
> > BIOS-version, ACPI enabled, APM disabled.
> 
> Thanks for your /proc/interrupts file.  You have a lot less IRQ
> sharing than me:
> 
>            CPU0       
>   0:    5484369          XT-PIC  timer
>   1:      13698          XT-PIC  i8042
>   2:          0          XT-PIC  cascade
>  11:     301909          XT-PIC  uhci_hcd, uhci_hcd, uhci_hcd, Intel 82801DB-ICH4, eth0, yenta, yenta, radeon@PCI:1:0:0
>  12:      14446          XT-PIC  i8042
>  14:      63403          XT-PIC  ide0
>  15:         21          XT-PIC  ide1
> NMI:          0 
> ERR:          0
> 
> I wonder why the system has got such a high affinity to IRQ 11.  I've
> never seen so much IRQ sharing before. 8-/

The BIOS default setting is to have all PCI interrupts on 11.
Try spreading them out manually.

> I'm going to give it a try without the radeon DRM module.
> 
> By the way, here's a log message from the system when it tries to come
> back from suspend:

Ohhh.  I recognize that one, I had problems with that one too.  I solved
it by adding hci_usb to the hotplug blacklist.  However, after
upgrading to 2.6.8-rc1-bk2 (from 2.6.6, so the fix might have been
somewhere in between), I could safely remove that from the blacklist
again.  YMMV.


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
