Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268495AbTCFW4e>; Thu, 6 Mar 2003 17:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268496AbTCFW4W>; Thu, 6 Mar 2003 17:56:22 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:46847 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S268495AbTCFW4P>;
	Thu, 6 Mar 2003 17:56:15 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15975.54404.895292.258958@gargle.gargle.HOWL>
Date: Fri, 7 Mar 2003 00:06:44 +0100
To: "sudharsan  vijayaraghavan" <my_goal@rediffmail.com>
Cc: linux-kernel@vger.kernel.org, svijayar@cisco.com,
       narendiran_srinivasan@satyam.com
Subject: Re: fd_install question ??
In-Reply-To: <20030306224608.29991.qmail@webmail17.rediffmail.com>
References: <20030306224608.29991.qmail@webmail17.rediffmail.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sudharsan  vijayaraghavan writes:
 >          // f1->f_vfsmnt = f2->f_vfsmnt = 
 > mntget(mntget(pipe_mnt));
 > -->        f1->f_vfsmnt = f2->f_vfsmnt = f3->f_vfsmnt = 
 > mntget(mntget(pipe_mnt));
 >          // f1->f_dentry = f2->f_dentry = dget(dentry);
 > -->        f1->f_dentry = f2->f_dentry = f3->f_dentry = 
 > dget(dentry);

A unified diff would have been much more readable.

You now have one more reference to ->f_vfsmnt and ->f_dentry, so I
suspect you're missing one mntget() and one dget() above. The usual
impact of a too low ref count is that the object is reassigned while
you're still using it, with memory corruption & oopses as the result.

/Mikael
