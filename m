Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbUDIOFR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 10:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUDIOFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 10:05:16 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:10446 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261322AbUDIOFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 10:05:05 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Grzegorz Kulewski <kangur@polcom.net>,
       Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Subject: Re: 2.6.5: keyboard lockup on a Toshiba laptop
Date: Fri, 9 Apr 2004 16:12:22 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200404071222.21397.rjwysocki@sisk.pl> <20040407110608.GR20293@charite.de> <Pine.LNX.4.58.0404071324050.10871@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.58.0404071324050.10871@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404091612.23032.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 of April 2004 13:31, Grzegorz Kulewski wrote:
> Ok, that should be easy to debug... I hope :-)
>
> Try to apply this patch to check what kernel part call connect function
> too many times. (Maybe it is some power management stuff?)
>
> WARNING
> It is my first "public" patch and I even not compiled it so maybe some
> headers should be declared. But if it will compile and run, it should
> display nice callstack in log for you for each call to this function.

I've applied this and I've got something like this in the log after a (recent) 
lockup:

Apr  9 10:47:03 albercik kernel: Uniform CD-ROM driver Revision: 3.20
Apr  9 10:47:03 albercik kernel: inserting floppy driver for 2.6.5
Apr  9 10:47:03 albercik kernel: Floppy drive(s): fd0 is 1.44M
Apr  9 10:47:03 albercik kernel: FDC 0 is a post-1991 82077
Apr  9 10:47:03 albercik kernel: SCSI subsystem initialized
Apr  9 10:51:11 albercik kernel: spurious 8259A interrupt: IRQ7.
Apr  9 15:00:24 albercik kernel: Call Trace:
Apr  9 15:00:24 albercik kernel:  [<c0277b29>] atkbd_connect+0x19/0x420
Apr  9 15:00:24 albercik kernel:  [<c027adca>] serio_find_dev+0x6a/0x70
Apr  9 15:00:24 albercik kernel:  [<c027aee9>] serio_handle_events+0xc9/0x120
Apr  9 15:00:24 albercik kernel:  [<c027af85>] serio_thread+0x45/0x140
Apr  9 15:00:24 albercik kernel:  [<c0117a40>] default_wake_function+0x0/0x20
Apr  9 15:00:24 albercik kernel:  [<c027af40>] serio_thread+0x0/0x140
Apr  9 15:00:24 albercik kernel:  [<c0105285>] kernel_thread_helper+0x5/0x10
Apr  9 15:00:24 albercik kernel: 
Apr  9 15:00:24 albercik kernel: input: AT Translated Set 2 keyboard on 
isa0060/serio0
Apr  9 15:42:19 albercik kernel: Call Trace:
Apr  9 15:42:19 albercik kernel:  [<c0277b29>] atkbd_connect+0x19/0x420
Apr  9 15:42:19 albercik kernel:  [<c027adca>] serio_find_dev+0x6a/0x70
Apr  9 15:42:19 albercik kernel:  [<c027aee9>] serio_handle_events+0xc9/0x120
Apr  9 15:42:19 albercik kernel:  [<c027af85>] serio_thread+0x45/0x140
Apr  9 15:42:19 albercik kernel:  [<c0117a40>] default_wake_function+0x0/0x20
Apr  9 15:42:19 albercik kernel:  [<c027af40>] serio_thread+0x0/0x140
Apr  9 15:42:19 albercik kernel:  [<c0105285>] kernel_thread_helper+0x5/0x10
Apr  9 15:42:19 albercik kernel: 
Apr  9 15:42:19 albercik kernel: input: AT Translated Set 2 keyboard on 
isa0060/serio0
Apr  9 15:58:36 albercik kernel: Call Trace:
Apr  9 15:58:36 albercik kernel:  [<c0277b29>] atkbd_connect+0x19/0x420
Apr  9 15:58:36 albercik kernel:  [<c027adca>] serio_find_dev+0x6a/0x70
Apr  9 15:58:36 albercik kernel:  [<c027aee9>] serio_handle_events+0xc9/0x120
Apr  9 15:58:36 albercik kernel:  [<c027af85>] serio_thread+0x45/0x140
Apr  9 15:58:36 albercik kernel:  [<c0117a40>] default_wake_function+0x0/0x20
Apr  9 15:58:36 albercik kernel:  [<c027af40>] serio_thread+0x0/0x140
Apr  9 15:58:36 albercik kernel:  [<c0105285>] kernel_thread_helper+0x5/0x10
Apr  9 15:58:36 albercik kernel: 

Here I had to reboot the machine.

-- 
Rafael J. Wysocki,
SiSK
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
