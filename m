Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVK1Od1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVK1Od1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 09:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbVK1Od1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 09:33:27 -0500
Received: from m10s25.vlinux.de ([83.151.28.59]:55447 "EHLO m10s25")
	by vger.kernel.org with ESMTP id S1751268AbVK1Od1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 09:33:27 -0500
Subject: [PATCH] nfsroot.c, kernel 2.6.14.3, do not silently stop parsing
	on an unknown option
From: "=?ISO-8859-1?Q?J=F6rn?= Dreyer" <j.dreyer@butonic.de>
Reply-To: j.dreyer@butonic.de
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-ZjBrRlujGVnQSw6r3dOO"
Date: Mon, 28 Nov 2005 15:32:04 +0100
Message-Id: <1133188324.9663.28.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZjBrRlujGVnQSw6r3dOO
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,


I think it would be helpful if the kernel did not silently stop parsing
nfs options, but instead warned about any he does not recognize. The
attached patch adds one printk to do just that.
It took me a couple of hours to find my configuration mistake - it is a
trivial patch, nevertheless, I would like to see the patch included to
save others the time ...

Sincerely

Jörn Dreyer


--=-ZjBrRlujGVnQSw6r3dOO
Content-Disposition: attachment; filename=nfswarning.patch
Content-Type: text/x-patch; name=nfswarning.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.14.3/fs/nfs/nfsroot.c     2005-11-24 23:10:21.000000000 +0100
+++ linux/fs/nfs/nfsroot.c      2005-11-28 14:50:59.223111632 +0100
@@ -276,6 +277,7 @@
                                nfs_data.flags |= NFS_MOUNT_NOACL;
                                break;
                        default :
+                               printk(KERN_WARNING "Root-NFS: unknown option: %s\n", p);
                                return 0;
                }
        }

--=-ZjBrRlujGVnQSw6r3dOO--

