Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293205AbSCJTzq>; Sun, 10 Mar 2002 14:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293206AbSCJTzh>; Sun, 10 Mar 2002 14:55:37 -0500
Received: from stingr.net ([212.193.33.37]:46761 "HELO hq.stingr.net")
	by vger.kernel.org with SMTP id <S293205AbSCJTzT>;
	Sun, 10 Mar 2002 14:55:19 -0500
Date: Sun, 10 Mar 2002 22:31:52 +0300
From: Paul P Komkoff Jr <i@stingr.net>
To: linux-kernel@vger.kernel.org
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Bug in do_mounts.c/namespace.c/devfs ?
Message-ID: <20020310193152.GJ28744@stingr.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Richard Gooch <rgooch@ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Agent Tanya
X-Mailer: Roxio Easy CD Creator 5.0
X-RealName: Stingray Greatest Jr
Organization: Bedleham International
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is clearly reproducible here.
Let's have 2.4.19-pre2-ac{2,3,maybe 4}.
Let compile in devfs support but dont enable mount on boot etc.

After boot we will have in /proc/mounts the following line
devfs /dev devfs
(other mounts)

Digging into do_mounts.c brought me to following code fragments:


                        do_devfs = 1;
                }
        }
        sys_chdir("/dev");
        sys_unlink("root");
        sys_mknod("root", S_IFBLK|0600, kdev_t_to_nr(ROOT_DEV));
        if (do_devfs)
                sys_mount("devfs", ".", "devfs", 0, NULL);

followed then by ...

done:
        putname(fs_names);
        if (do_devfs)
                sys_umount(".", 0);

I am unfamiliar with devfs and vfs code so my bug-hunting go very slowly.
Maybe somebody will point into right direction ?

The only thing I can add that in 2.4.17 all was fine.

-- 
Paul P 'Stingray' Komkoff 'Greatest' Jr // (icq)23200764 // (irc)Spacebar
  PPKJ1-RIPE // (smtp)i@stingr.net // (http)stingr.net // (pgp)0xA4B4ECA4
