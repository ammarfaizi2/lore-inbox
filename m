Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUDIQat (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 12:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUDIQas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 12:30:48 -0400
Received: from [80.72.36.106] ([80.72.36.106]:56448 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261187AbUDIQao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 12:30:44 -0400
Date: Fri, 9 Apr 2004 18:30:38 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.5: keyboard lockup on a Toshiba laptop
In-Reply-To: <200404091612.23032.rjwysocki@sisk.pl>
Message-ID: <Pine.LNX.4.58.0404091734240.18073@alpha.polcom.net>
References: <200404071222.21397.rjwysocki@sisk.pl> <20040407110608.GR20293@charite.de>
 <Pine.LNX.4.58.0404071324050.10871@alpha.polcom.net> <200404091612.23032.rjwysocki@sisk.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1213229604-1023644374-1081528238=:18073"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1213229604-1023644374-1081528238=:18073
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 9 Apr 2004, R. J. Wysocki wrote:

> On Wednesday 07 of April 2004 13:31, Grzegorz Kulewski wrote:
> > Ok, that should be easy to debug... I hope :-)
> >
> > Try to apply this patch to check what kernel part call connect function
> > too many times. (Maybe it is some power management stuff?)
> 
> I've applied this and I've got something like this in the log after a (recent) 
> lockup:
> 
> Apr  9 10:47:03 albercik kernel: Uniform CD-ROM driver Revision: 3.20
> Apr  9 10:47:03 albercik kernel: inserting floppy driver for 2.6.5
> Apr  9 10:47:03 albercik kernel: Floppy drive(s): fd0 is 1.44M
> Apr  9 10:47:03 albercik kernel: FDC 0 is a post-1991 82077
> Apr  9 10:47:03 albercik kernel: SCSI subsystem initialized
> Apr  9 10:51:11 albercik kernel: spurious 8259A interrupt: IRQ7.
> Apr  9 15:00:24 albercik kernel: Call Trace:
> Apr  9 15:00:24 albercik kernel:  [<c0277b29>] atkbd_connect+0x19/0x420
> Apr  9 15:00:24 albercik kernel:  [<c027adca>] serio_find_dev+0x6a/0x70
> Apr  9 15:00:24 albercik kernel:  [<c027aee9>] serio_handle_events+0xc9/0x120
> Apr  9 15:00:24 albercik kernel:  [<c027af85>] serio_thread+0x45/0x140
> Apr  9 15:00:24 albercik kernel:  [<c0117a40>] default_wake_function+0x0/0x20
> Apr  9 15:00:24 albercik kernel:  [<c027af40>] serio_thread+0x0/0x140
> Apr  9 15:00:24 albercik kernel:  [<c0105285>] kernel_thread_helper+0x5/0x10
> Apr  9 15:00:24 albercik kernel: 
> Apr  9 15:00:24 albercik kernel: input: AT Translated Set 2 keyboard on 
> isa0060/serio0
> Apr  9 15:42:19 albercik kernel: Call Trace:
> Apr  9 15:42:19 albercik kernel:  [<c0277b29>] atkbd_connect+0x19/0x420
> Apr  9 15:42:19 albercik kernel:  [<c027adca>] serio_find_dev+0x6a/0x70
> Apr  9 15:42:19 albercik kernel:  [<c027aee9>] serio_handle_events+0xc9/0x120
> Apr  9 15:42:19 albercik kernel:  [<c027af85>] serio_thread+0x45/0x140
> Apr  9 15:42:19 albercik kernel:  [<c0117a40>] default_wake_function+0x0/0x20
> Apr  9 15:42:19 albercik kernel:  [<c027af40>] serio_thread+0x0/0x140
> Apr  9 15:42:19 albercik kernel:  [<c0105285>] kernel_thread_helper+0x5/0x10
> Apr  9 15:42:19 albercik kernel: 
> Apr  9 15:42:19 albercik kernel: input: AT Translated Set 2 keyboard on 
> isa0060/serio0
> Apr  9 15:58:36 albercik kernel: Call Trace:
> Apr  9 15:58:36 albercik kernel:  [<c0277b29>] atkbd_connect+0x19/0x420
> Apr  9 15:58:36 albercik kernel:  [<c027adca>] serio_find_dev+0x6a/0x70
> Apr  9 15:58:36 albercik kernel:  [<c027aee9>] serio_handle_events+0xc9/0x120
> Apr  9 15:58:36 albercik kernel:  [<c027af85>] serio_thread+0x45/0x140
> Apr  9 15:58:36 albercik kernel:  [<c0117a40>] default_wake_function+0x0/0x20
> Apr  9 15:58:36 albercik kernel:  [<c027af40>] serio_thread+0x0/0x140
> Apr  9 15:58:36 albercik kernel:  [<c0105285>] kernel_thread_helper+0x5/0x10
> Apr  9 15:58:36 albercik kernel: 
> 
> Here I had to reboot the machine.

So we can see that atkbd_connect is called several times (and it probably 
should not... - somebody correct me if I am wrong).

Apply attached patch to see what causes reconnection.

Grzegorz Kulewski

--1213229604-1023644374-1081528238=:18073
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="serio.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0404091830380.18073@alpha.polcom.net>
Content-Description: 
Content-Disposition: attachment; filename="serio.patch"

LS0tIC91c3Ivc3JjL2xpbnV4LTIuNi41L2RyaXZlcnMvaW5wdXQvc2VyaW8v
c2VyaW8uYy5vcmlnCTIwMDQtMDQtMDQgMDU6MzY6MTUuMDAwMDAwMDAwICsw
MjAwDQorKysgL3Vzci9zcmMvbGludXgtMi42LjUvZHJpdmVycy9pbnB1dC9z
ZXJpby9zZXJpby5jCTIwMDQtMDQtMDkgMTg6Mjg6NTAuMjY4NTIxOTM2ICsw
MjAwDQpAQCAtMTY2LDYgKzE2NiwxMSBAQCBzdGF0aWMgaW50IHNlcmlvX3Ro
cmVhZCh2b2lkICpub3RoaW5nKQ0KIHN0YXRpYyB2b2lkIHNlcmlvX3F1ZXVl
X2V2ZW50KHN0cnVjdCBzZXJpbyAqc2VyaW8sIGludCBldmVudF90eXBlKQ0K
IHsNCiAJc3RydWN0IHNlcmlvX2V2ZW50ICpldmVudDsNCisJDQorCWlmIChl
dmVudF90eXBlID09IFNFUklPX1JFU0NBTiB8fCBldmVudF90eXBlID09IFNF
UklPX1JFQ09OTkVDVCkgew0KKwkJcHJpbnRrKEtFUk5fV0FSTklORyAic2Vy
aW86IFJFU0NBTiB8fCBSRUNPTk5FQ1QgcmVxdWVzdGVkOiAlZCFcbiIsIGV2
ZW50X3R5cGUpOw0KKwkJZHVtcF9zdGFjaygpOw0KKwl9DQogDQogCWlmICgo
ZXZlbnQgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3Qgc2VyaW9fZXZlbnQpLCBH
RlBfQVRPTUlDKSkpIHsNCiAJCWV2ZW50LT50eXBlID0gZXZlbnRfdHlwZTsN
Cg==

--1213229604-1023644374-1081528238=:18073--
