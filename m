Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266604AbUHQTDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266604AbUHQTDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 15:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUHQTDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 15:03:23 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:32781 "EHLO
	scl-ims.phoenix.com") by vger.kernel.org with ESMTP id S266604AbUHQTBg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 15:01:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH][linux-usb-devel] Early USB handoff
Date: Tue, 17 Aug 2004 12:01:36 -0700
Message-ID: <5F106036E3D97448B673ED7AA8B2B6B3015B6A39@scl-exch2k.phoenix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][linux-usb-devel] Early USB handoff
Thread-Index: AcSEY71XHVwLbbniQvutwIa4sXVRngAJcN2w
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Alan Stern" <stern@rowland.harvard.edu>
Cc: "Pete Zaitcev" <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>, <alan@lxorguk.ukuu.org.uk>
X-OriginalArrivalTime: 17 Aug 2004 19:01:36.0031 (UTC) FILETIME=[9E5BA2F0:01C4848C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>You could reorder and simplify slightly the code for handing off a UHCI
>controller.  It's safer to disable PIRQD, SMI#, and legacy 
>support first
>and then turn off the interrupt enable bits, all before stopping the
>controller.  You could even reset the controller rather than 
>just stopping
>it (although you might also want to avoid the 60ms delay this 
>requires).  
>Take a look at reset_hc() in drivers/usb/host/uhci-hcd.c and 
>see what you
>think.

Reset would simplify the code, but also make boot time longer :( I'd
rather sacrifice the code in this case. Actually, it was reset that had
been done in original patch for UHCI and I think was taken from
reset_hc(). Moreover, if one can detect that UHCI has been initialized
in the BIOS already, and just halt it - 60ms reset delay can be avoided
at boot time in the driver as well. 
Not sure about reoder though.

Aleks.
