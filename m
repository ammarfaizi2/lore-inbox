Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293433AbSCKAms>; Sun, 10 Mar 2002 19:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293422AbSCKAmi>; Sun, 10 Mar 2002 19:42:38 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:49328 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S293411AbSCKAmZ>; Sun, 10 Mar 2002 19:42:25 -0500
Date: Sun, 10 Mar 2002 17:42:17 -0700
Message-Id: <200203110042.g2B0gHV24308@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Blowing away devfs-created /dev/root
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi, Al. Looking 2.4.19-pre2 I came across this in init/do_mounts.c:
	sys_chdir("/dev");
	sys_unlink("root");
	sys_mknod("root", S_IFBLK|0600, kdev_t_to_nr(ROOT_DEV));

(line 354 onwards). This will have the effect of blowing away the
/dev/root symlink that is carefully created a few lines above. Is
there a reason you did this, rather than something like:
	sys_chdir("/dev");
	if (do_devfs)
		sys_mount("devfs", ".", "devfs", 0, NULL);
	else {
		sys_unlink("root");
		sys_mknod("root", S_IFBLK|0600, kdev_t_to_nr(ROOT_DEV));
	}

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
