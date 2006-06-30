Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWF3QGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWF3QGw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 12:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWF3QGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 12:06:51 -0400
Received: from outbound-mail-07.bluehost.com ([67.138.240.207]:11139 "HELO
	outbound-mail-07.bluehost.com") by vger.kernel.org with SMTP
	id S1751270AbWF3QGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 12:06:51 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "Robert Nagy" <robert.nagy@gmail.com>
Subject: Re: Intel RAID Controller SRCU42X in SGI Altix 350
Date: Fri, 30 Jun 2006 09:06:46 -0700
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <39f633820606290818g1978866ap@mail.gmail.com> <200606291342.38580.jbarnes@virtuousgeek.org> <39f633820606300507h68333a66xb6750e7d6cd652b1@mail.gmail.com>
In-Reply-To: <39f633820606300507h68333a66xb6750e7d6cd652b1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606300906.47077.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 71.198.43.183 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, June 30, 2006 5:07 am, Robert Nagy wrote:
> I've tried that with two different cards. Now the error is different.
> Even the firmware boots on the controller but then the machine resets.
> Same thing happens if I load the EFI driver but that drops me to the
> debugger. More info can be found at http://pastebin.ca/75652
>
> megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
> megaraid: 2.20.4.8 (Release Date: Mon Apr 11 12:27:22 EST 2006)
> megaraid: probe new device 0x1000:0x0407:0x8086:0x0532: bus 2:slot
> 0:func 0 ACPI: PCI Interrupt 0002:02:00.0[A]: no GSI
> megaraid mailbox: wait for FW to boot [ok]
> Entered OS MCA handler. PSP=20000000fff21120 cpu=0 monarch=1
> All OS MCA slaves have reached rendezvous

This is what happens when you have PCI card in the bus next to your RAID 
card and run without my patch?  Hm...  this might be a regular driver 
bug.  Interesting that this driver might do an msleep right after the 
[ok] is printed.  Do you have kdb builtin to your kernel?  If so, maybe 
you could get a backtrace.  Otherwise you could put in some printk 
statements to see if we can figure out where the MCA is occuring...

Jesse
