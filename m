Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266002AbUGZS3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266002AbUGZS3n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 14:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266021AbUGZS3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 14:29:40 -0400
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:2491 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S266291AbUGZQcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 12:32:43 -0400
To: linux-kernel@vger.kernel.org
Subject: bug with multiple mounts of filesystems in 2.6
From: John S J Anderson <jacobs@genehack.org>
Organization: genehack
X-URL: http://genehack.org
X-Attribution: john
Date: Mon, 26 Jul 2004 12:29:15 -0400
Message-ID: <86oem2hgv8.fsf@mendel.genehack.org>
User-Agent: Gnus/5.090024 (Oort Gnus v0.24) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hi --

  We're working on migrating to the 2.6 kernel series, and one big
  problem has popped up: we have a number of NFS mounts that are
  mounted read-only in one location and read-write in a distinct
  location (on the same machine). With 2.4 series kernels, this worked
  without issue, but with 2.6, it doesn't: it's not possible to mount
  the same filesystem twice with different options for each mount; the
  two mount points have to share the same mount options.

  Furthermore, if you do mount one filesystem at two different places,
  changing the mount options on one mount point ('mount -o remount,rw
  $MOUNT1', for example) also results in the mount options on the
  other mount point being changed. Finally, the information returned
  by 'mount' about the mount points is wrong -- 'mount' will show (for
  example) one mount point being 'rw' and the other being 'ro', when
  in fact attempting to use the 'rw' mount point will show it to be
  read-only. /proc/mounts correctly indicates that both mounts are
  read-only. 

  Further experimentation has shown: 

  * the NFS layer is not involved; it is possible to reproduce this
    problem using just locally-attached filesystems.
  * this affects at least 2.6.3, 2.6.5, and 2.6.7.
  * it happens with mount version 2.11r and 2.12.

  Because the options of the first mount point "wins" (i.e., mounting a
  filesystem once read-write, and then a second time as read-only,
  leaves both mounts in a read-write state), it seems like there's
  some sort of caching optimization going on -- but I haven't looked
  into the code to find out if that guess is correct.
  
  Any pointers towards restoring the 2.4 behavior welcomed. 

thanks,
john.
-- 
Perhaps you have forgotten that this is an engineering discipline, not
some sort of black magic.
  Mark Jason Dominus's Good Advice #11946
