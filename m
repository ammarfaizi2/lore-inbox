Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268199AbUIAWFP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268199AbUIAWFP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 18:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268072AbUIAWCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 18:02:54 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:49945 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S268224AbUIAV4v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:56:51 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: EHCI errors in 2.6.8 (could be a patch mistake)
Date: Wed, 1 Sep 2004 14:56:46 -0700
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B30162E5E6@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: EHCI errors in 2.6.8 (could be a patch mistake)
Thread-Index: AcSQZgdaq/6FvX19Sb+YwWeFukNhSQABTCfg
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Gaetano Sferra" <gaesferr@libero.it>, <linux-kernel@vger.kernel.org>
Cc: <zaitcev@redhat.com>, <dbrownell@users.sourceforge.net>, <greg@kroah.com>
X-OriginalArrivalTime: 01 Sep 2004 21:56:46.0273 (UTC) FILETIME=[93258B10:01C4906E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've patched my fully working 2.6.7 kernel to the 2.6.8 and I 
>got these errors 
>at boot time (no errors during patch and compilation using the 
>same config of 
>the 2.6.7 kernel):
>
>ehci_hcd 0000:00:1d.7: BIOS handoff failed (104, 1010001)
>ehci_hcd 0000:00:1d.7: can't reset
>ehci_hcd 0000:00:1d.7: init 0000:00:1d.7 fail, -95
>ehci_hcd: probe of 0000:00:1d.7 failed with error -95
>
>In this condition the hotplugging of USB devices doesn't work at all!
>The host controller is an Intel Corp. 82801DB (ICH4) USB2 EHCI 
>and it fully 
>work with the 2.6.7. Looking into the patched and original code of the 
>ehci-hcd driver I've noticed that some changes has been maded 
>but the only 
>one that can influence the BIOS handoff is the following:
>
>kernel 2.6.7 - line 296: cap &= 1 << 24;
>kernel 2.6.8 - line 296: cap |= 1 << 24;
                          ^^^^^^^^^^^^^^
This is correct in accordance with EHCI spec.
Could you please try the following patch and see how it goes ?
http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg270
89.html
Make sure you specify 'usb-handoff' as a kernel parameter.

Pete,
  BTW is this one a 'no go' or just got lost ?

Aleks.
