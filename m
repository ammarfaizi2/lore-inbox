Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318369AbSIBTM3>; Mon, 2 Sep 2002 15:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318376AbSIBTM3>; Mon, 2 Sep 2002 15:12:29 -0400
Received: from alpham.uni-mb.si ([164.8.1.101]:30919 "EHLO alpham.uni-mb.si")
	by vger.kernel.org with ESMTP id <S318369AbSIBTM2>;
	Mon, 2 Sep 2002 15:12:28 -0400
Date: Mon, 02 Sep 2002 21:16:48 +0200
From: CAMTP guest <camtp.guest@uni-mb.si>
Subject: Re: aic7xxx sets CDR offline, how to reset?
In-reply-to: <20020902140509.A10976@redhat.com>
To: Doug Ledford <dledford@redhat.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <15731.47392.215325.798396@proizd.camtp.uni-mb.si>
MIME-version: 1.0
X-Mailer: VM 6.97 under Emacs 20.7.2
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
References: <15731.22574.493121.798425@proizd.camtp.uni-mb.si>
 <1231170000.1030981811@aslan.scsiguy.com> <20020902140509.A10976@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford writes:

 > took the device off line.  So, in short, the mid layer isn't waiting long 
 > enough, or when it gets sense indicated not ready it needs to implement a 
 > waiting queue with a timeout to try rekicking things a few times and don't 
 > actually mark the device off line until a longer period of time has 
 > elasped without the device coming back.

There is a kernel config CONFIG_AIC7XXX_RESET_DELAY_MS (default 15s).
Would increasing it help?

 > As for getting it to be not off line without rebooting, just do a this:
 > 
 > echo "scsi-remove-single-device 0 0 6 0" > /proc/scsi/scsi
 > echo "scsi-add-single-device 0 0 6 0" > /proc/scsi/scsi
 > 
 > That'll remove the device and then rescan it.  Assuming it's had enough 
 > time to complete the reset by the time you do this and it's once again 
 > ready to accept commands, this should get your CD back working.

This works fine, thanks a lot.

-Igor Mozetic
