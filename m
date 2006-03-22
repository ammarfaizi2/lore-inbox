Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWCVPO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWCVPO5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWCVPO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:14:56 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:31962 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751270AbWCVPOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:14:55 -0500
Date: Wed, 22 Mar 2006 16:15:22 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cornelia.huck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 2/24] s390: cio documentation update.
Message-ID: <20060322151522.GB5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[patch 2/24] s390: cio documentation update.

Update documentation of the common I/O layer:
- Add MSS-specific example.
- Add more information on ccwgroup devices.
- Add channel path type attribute.
- Fix typo.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/driver-model.txt |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/Documentation/s390/driver-model.txt linux-2.6-patched/Documentation/s390/driver-model.txt
--- linux-2.6/Documentation/s390/driver-model.txt	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/Documentation/s390/driver-model.txt	2006-03-22 14:36:10.000000000 +0100
@@ -16,10 +16,12 @@ devices/
            - 0.0.0000/0.0.0815/
 	   - 0.0.0001/0.0.4711/
 	   - 0.0.0002/
+	   - 0.1.0000/0.1.1234/
 	   ...
 
-In this example, device 0815 is accessed via subchannel 0, device 4711 via 
-subchannel 1, and subchannel 2 is a non-I/O subchannel.
+In this example, device 0815 is accessed via subchannel 0 in subchannel set 0,
+device 4711 via subchannel 1 in subchannel set 0, and subchannel 2 is a non-I/O
+subchannel. Device 1234 is accessed via subchannel 0 in subchannel set 1.
 
 You should address a ccw device via its bus id (e.g. 0.0.4711); the device can
 be found under bus/ccw/devices/.
@@ -97,7 +99,7 @@ is not available to the device driver.
 
 Each driver should declare in a MODULE_DEVICE_TABLE into which CU types/models
 and/or device types/models it is interested. This information can later be found
-found in the struct ccw_device_id fields:
+in the struct ccw_device_id fields:
 
 struct ccw_device_id {
 	__u16	match_flags;	
@@ -208,6 +210,11 @@ Each ccwgroup device also provides an 'u
 again (only when offline). This is a generic ccwgroup mechanism (the driver does
 not need to implement anything beyond normal removal routines).
 
+A ccw device which is a member of a ccwgroup device carries a pointer to the
+ccwgroup device in the driver_data of its device struct. This field must not be
+touched by the driver - it should use the ccwgroup device's driver_data for its
+private data.
+
 To implement a ccwgroup driver, please refer to include/asm/ccwgroup.h. Keep in
 mind that most drivers will need to implement both a ccwgroup and a ccw driver
 (unless you have a meta ccw driver, like cu3088 for lcs and ctc).
@@ -230,6 +237,8 @@ status - Can be 'online' or 'offline'.
 	 a channel path the user knows to be online, but the machine hasn't
 	 created a machine check for.
 
+type - The physical type of the channel path.
+
 
 3. System devices
 -----------------
