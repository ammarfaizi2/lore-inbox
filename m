Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbUCASyl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 13:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbUCASyl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 13:54:41 -0500
Received: from fep05-svc.mail.telepac.pt ([194.65.5.209]:7649 "HELO
	fep05-svc.mail.telepac.pt") by vger.kernel.org with SMTP
	id S261402AbUCASyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 13:54:39 -0500
Date: Mon, 1 Mar 2004 18:45:12 +0000
From: Nuno Monteiro <nuno@itsari.org>
To: linux-kernel@vger.kernel.org
Subject: something funny about tty's on 2.6.4-rc1-mm1
Message-ID: <20040301184512.GA21285@hobbes.itsari.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed	DelSp=Yes
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I just took 2.6.4-rc1-mm1 for a spin, and there's definitely something  
funny about tty's. I left the computer unattended and had visitors over,  
among them small children who, apparently, decided I needed 350 aterm's  
open ;-). So, after they left I issued a 'killall -9 aterm' and fired up  
a new one, and here's something definitely interesting:

nuno@hobbes:~$ w
 18:33:56 up  4:08, 157 users,  load average: 0.03, 0.89, 1.51
USER     TTY        LOGIN@   IDLE   JCPU   PCPU WHAT
nuno     :0        14:26   ?xdm?   3:55   0.95s gnome-session
nuno     pts/358   18:30    0.00s  0.10s  0.00s w


I know for a fact that I don't have 157 logged in users (well, there's  
only 45 processes running right now), and shouldn't pts' be recycled, and  
a lower number be assigned? The last kernel I ran was 2.6.3, and none of  
this happened.

My config is:

CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=512

and this is a plain jane static /dev -- not devfs nor udev. Despite the  
supposedly 157 users logged in, /dev/pts only contains '358', which is  
the one allocated to this instance of aterm right now.

nuno@hobbes:~$ ls -l /dev/pts
total 0
crw--w----    1 nuno     users    136, 102 Mar  1 18:41 358

In the mean time I'll fall back to 2.6.3.


Regards,


		Nuno

