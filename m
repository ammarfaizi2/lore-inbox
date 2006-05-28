Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWE1REN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWE1REN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 13:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWE1REN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 13:04:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:18977 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750805AbWE1REN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 13:04:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=DuhBz8RiTn0XUbGLJU5+d6JhQK7n9nfHD90aMnXaKxQdgyo0gNV8LnXecGEcvadPJoVOjPwNAlfBTtGD4rpNs0/goj2iEgrIJzUKAWsGe9wkPpPd2+hnMKsaQgp98og/729sJao0Nuixvxg/Qc5Gll5WLppsY889tTmH5khqCwM=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][trivial] Clean up 'inline is not at beginning' warnings for usb storage
Date: Sun, 28 May 2006 19:05:14 +0200
User-Agent: KMail/1.9.1
Cc: mdharm-usb@one-eyed-alien.net, usb-storage@lists.one-eyed-alien.net,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605281905.14765.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Usually we don't care much about 'gcc -W' warnings, but some of us do build
kernels that way to look for problems, and then the fewer warnings we have 
to wade through the better. Especially when they are very easy and 
non-intrusive to clean up. Which is the case for the following warnings 
spewed by drivers/usb/storage/usb.h :

  drivers/usb/storage/usb.h:163: warning: `inline' is not at beginning of declaration
  drivers/usb/storage/usb.h:166: warning: `inline' is not at beginning of declaration

There's also some precedence for cleaning up these warnings. I've had 
a few patches merged in the past that remove exactly this class of 
warnings.

Please consider merging.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/usb/storage/usb.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.17-rc5-git3-orig/drivers/usb/storage/usb.h	2006-05-27 13:59:08.000000000 +0200
+++ linux-2.6.17-rc5-git3/drivers/usb/storage/usb.h	2006-05-28 18:43:26.000000000 +0200
@@ -160,10 +160,10 @@
 };
 
 /* Convert between us_data and the corresponding Scsi_Host */
-static struct Scsi_Host inline *us_to_host(struct us_data *us) {
+static inline struct Scsi_Host *us_to_host(struct us_data *us) {
 	return container_of((void *) us, struct Scsi_Host, hostdata);
 }
-static struct us_data inline *host_to_us(struct Scsi_Host *host) {
+static inline struct us_data *host_to_us(struct Scsi_Host *host) {
 	return (struct us_data *) host->hostdata;
 }
 


