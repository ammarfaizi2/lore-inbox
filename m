Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288291AbSACUBY>; Thu, 3 Jan 2002 15:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288293AbSACUBO>; Thu, 3 Jan 2002 15:01:14 -0500
Received: from thufir.bluecom.no ([217.118.32.12]:65286 "EHLO
	thufir.bluecom.no") by vger.kernel.org with ESMTP
	id <S288291AbSACUBJ>; Thu, 3 Jan 2002 15:01:09 -0500
Subject: bug in IBM ServeRAID driver?
From: petter wahlman <petter@bluezone.no>
To: linux-kernel@vger.kernel.org
Cc: ipslinux@us.ibm.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 03 Jan 2002 20:51:11 +0100
Message-Id: <1010087472.9561.0.camel@BadEip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While looking through linux-2.4.18pre1/drivers/scsi/ips.c I noticed that
a spin_lock_irq is held while doing a possibly blocking operation.
Can't this code livelock on SMP if datasize is set?

linux-2.4.18pre1/drivers/scsi/ips.c

   1778       /* reobtain the lock */
   1779       spin_lock_irq(&io_request_lock);
   1780
   1781       /* command finished -- copy back */
   1782       user_area = *((char **) &SC->cmnd[4]);
   1783       kern_area = ha->ioctl_data;
   1784       datasize = *((u_int32_t *) &SC->cmnd[8]);
   1785
   1786       if (datasize) {
   1787          if (copy_to_user(user_area, kern_area, datasize) > 0) {
   1788             DEBUG_VAR(1, "(%s%d) passthru failed - unable to
copy out user data",
   1789                       ips_name, ha->host_num);


I am not subscribed to this list, so please CC me.


Petter Wahlman

