Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266952AbTBTVUd>; Thu, 20 Feb 2003 16:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266959AbTBTVUd>; Thu, 20 Feb 2003 16:20:33 -0500
Received: from smtp.rhein-zeitung.DE ([212.7.160.14]:5792 "EHLO
	smtp.rhein-zeitung.DE") by vger.kernel.org with ESMTP
	id <S266952AbTBTVUc>; Thu, 20 Feb 2003 16:20:32 -0500
Date: Thu, 20 Feb 2003 22:30:37 +0100
From: Oliver Graf <ograf@rz-online.net>
To: linux-kernel@vger.kernel.org
Subject: usb-storage fails to detect all luns after 2.4.19
Message-ID: <20030220213037.GA5435@rz-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-PGP-Key: http://wwwkeys.de.pgp.net:11371/pks/lookup?op=get&search=0x0B17417A
X-RIPE-Key-Cert: PGPKEY-0B17417A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've already mentioned this some time ago.

The problem: a multi device usb card reader is correctly detected with
its four subdevices with kernel 2.4.19(-acX). But any patch after this
fails to detect the subdevices.

Verbose output with 2.4.19-ac4 shows:
usb-storage: GetMaxLUN command result is 1, data is 3

2.4.21-pre4 gives:
usb-storage: GetMaxLUN command result is -32, data is 128
usb-storage: clearing endpoint halt for pipe 0x80000880

I tried to find the parts that changed between the version, but it seems
not to be rooted in usb-storage.

The call to usb_control_msg seems to timeout with the newer kernel
(just a wild guess!).

Finally I did a desparate modification: I return 3 from
usb_stor_Bulk_max_lun just before the endpoint is cleared. This got my
card reader up and running again, but it's very very dirty und certainly
breaks other usb storage devices (I don't own).

Anyone out there who knows the usb stuff better?

Regards,
  Oliver.
