Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVLUUuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVLUUuo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 15:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVLUUuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 15:50:44 -0500
Received: from tarjoilu.luukku.com ([194.215.205.232]:26603 "EHLO
	tarjoilu.luukku.com") by vger.kernel.org with ESMTP
	id S1751169AbVLUUun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 15:50:43 -0500
Date: Wed, 21 Dec 2005 22:50:15 +0200
From: Mika Kukkonen <mikukkon@iki.fi>
To: vlan@candelatech.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] VLAN: Add two missing checks to vlan_ioctl_handler()
Message-ID: <20051221205015.GC24213@localhost.localdomain>
Reply-To: mikukkon@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In vlan_ioctl_handler() the code misses couple checks for
error return values.

Signed-of-by: Mika Kukkonen <mikukkon@iki.fi>

---

 net/8021q/vlan.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 91e412b..67465b6 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -753,6 +753,8 @@ static int vlan_ioctl_handler(void __use
 		break;
 	case GET_VLAN_REALDEV_NAME_CMD:
 		err = vlan_dev_get_realdev_name(args.device1, args.u.device2);
+		if (err)
+			goto out;
 		if (copy_to_user(arg, &args,
 				 sizeof(struct vlan_ioctl_args))) {
 			err = -EFAULT;
@@ -761,6 +763,8 @@ static int vlan_ioctl_handler(void __use
 
 	case GET_VLAN_VID_CMD:
 		err = vlan_dev_get_vid(args.device1, &vid);
+		if (err)
+			goto out;
 		args.u.VID = vid;
 		if (copy_to_user(arg, &args,
 				 sizeof(struct vlan_ioctl_args))) {
@@ -774,7 +778,7 @@ static int vlan_ioctl_handler(void __use
 			__FUNCTION__, args.cmd);
 		return -EINVAL;
 	};
-
+out:
 	return err;
 }
 

