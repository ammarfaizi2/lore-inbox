Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264918AbTL1CEx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 21:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbTL1CEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 21:04:53 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:36559 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S264918AbTL1CEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 21:04:51 -0500
Date: Sun, 28 Dec 2003 03:04:49 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 011 release
Message-ID: <20031228020449.GA26527@werewolf.able.es>
References: <20031225005614.GA18568@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20031225005614.GA18568@kroah.com> (from greg@kroah.com on Thu, Dec 25, 2003 at 01:56:14 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12.25, Greg KH wrote:
> I've released the 011 version of udev.  It can be found at:
>  	kernel.org/pub/linux/utils/kernel/hotplug/udev-011.tar.gz
> 

udev rc script reads:

# chkconfig: 2345 20 80

If it is supposed to create device nodes on an empty /dev, I think it should
be run at runlevel 1, or even run apart from normal initscripts, from rc or
the like ?
For example, on a Mandrake cooker box, rc2.d looks like


K05portsentry@  K35dhcpd@       K80gmond@                   S12syslog@
K08lircmd@      K35lircd@       K80nscd@                    S15gpm@
K09dm@          K44rawdevices@  K81ganglia-monitor-script@  S18sound@
K09smb@         K45named@       K86nfslock@                 S20random@
K10devfsd@      K50xinetd@      K89portmap@                 S20udev@
K10ntpd@        K54pxe@         K89upsmon@                  S60cups@
K10xfs@         K60atd@         K90upsd@                    S60nfs@
K15proftpd@     K60saslauthd@   K95harddrake@               S75keytable@
K20bootparamd@  K65identd@      S01hotplug@                 S80postfix@
K20partmon@     K70acpi@        S03iptables@                S90crond@
K21bpmaster@    K70alsa@        S05lm_sensors@              S95kheader@
K25sshd@        K75netfs@       S05sensors@                 S95microcode_ctl@
K35atalk@       K80gmetad@      S10network@                 S99local@

This means that it will try to run, for example, gpm before the device for
the mouse is created (as I said, if you booted with an empty /dev you want
to populate with device nodes).

And a couple questions.
a) Should not ordering be reversed here:

  start)
    if [ ! -d $udev_dir ]; then
        mkdir $udev_dir
    fi
    if [ ! -d $sysfs_dir ]; then
        exit 1
    fi
  If we have not /sys, there's no sense on creating /udev, so I would check first
  for /sys.

b) What is the sense of removing devices when udev is stopped ? As I understand
  it, udev is not 'running', it is just a command to create device nodes, called 
  by hotplug. What is more logical, chkconfig --level 12345 or --level 1 ?
  One more reason to split it from normal init scripts. 

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.0-jam1 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-3mdk))
