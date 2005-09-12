Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbVILJuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVILJuh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 05:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbVILJuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 05:50:37 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:52713 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1751270AbVILJuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 05:50:37 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Michael Clark <michael@metaparadigm.com>
Subject: Re: Universal method to start a script at boot
Date: Mon, 12 Sep 2005 12:49:40 +0300
User-Agent: KMail/1.8.2
Cc: Brad Tilley <rtilley@vt.edu>, linux-kernel@vger.kernel.org
References: <1126462329.4324737923c2d@wmtest.cc.vt.edu> <1126462467.43247403c2e1c@wmtest.cc.vt.edu> <43250150.20308@metaparadigm.com>
In-Reply-To: <43250150.20308@metaparadigm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509121249.40467.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 September 2005 07:17, Michael Clark wrote:
> >>Is there a standard way to start a script or program at boot that will work
> >>on any Linux kernel/distro no matter which init system is being used or how it
> >>has been configured? Probably not, but I thought someone here could possibly
> >>answer this.
> 
> You could use the LSB conforming method of writing and installing
> an init script:
> 
> http://refspecs.freestandards.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/iniscrptact.html
> http://refspecs.freestandards.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/iniscrptfunc.html
> http://refspecs.freestandards.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/initscrcomconv.html
> http://refspecs.freestandards.org/LSB_3.0.0/LSB-Core-generic/LSB-Core-generic/initsrcinstrm.html

Awful. This codifies ages-old Unix traditional SysV-like init
and its derivatives, which should be get rid of instead.

daemontools are absolutely wonderful way of controlling daemons.

This is how sane system may look instead:

# ps -AH e
  PID TTY      STAT   TIME COMMAND
    1 ?        S      0:01 /bin/sh /init
  539 ?        S<     0:00   udevd UDEV_LOG=debug
  593 ?        S      0:00   rpc.portmap
  702 ?        S      0:00   svscan /var/service PATH=/bin:/usr/bin
  720 ?        S      0:00     supervise fw PATH=/bin:/usr/bin
  721 ?        S      0:00     supervise gpm PATH=/bin:/usr/bin
 1597 ?        S      0:00       gpm -D -2 -m /dev/psaux -t ps2
  722 ?        S      0:00     supervise nfs PATH=/bin:/usr/bin
  743 ?        S      0:00       /bin/sh ./run PATH=/bin:/usr/bin
 1097 ?        S      0:00         sleep 32000
  723 ?        S      0:00     supervise ntp PATH=/bin:/usr/bin
  736 ?        SL     0:00       ntpd -D 0 -c conf -f drift -s stat -l /proc/self/fd/2 -p /dev/null -k /dev/null -g -d -n
  724 ?        S      0:00     supervise log PATH=/bin:/usr/bin
  737 ?        S      0:00       multilog t /var/log/service/ntp
  725 ?        S      0:00     supervise smb PATH=/bin:/usr/bin
  726 ?        S      0:00     supervise log PATH=/bin:/usr/bin
  730 ?        S      0:00       multilog t /var/log/service/smb
  727 ?        S      0:00     supervise top PATH=/bin:/usr/bin
  760 ?        S      1:00       top c s TERM=linux
  728 ?        S      0:00     supervise dhcp PATH=/bin:/usr/bin
  729 ?        S      0:00     supervise log PATH=/bin:/usr/bin
  755 ?        S      0:00       multilog t /var/log/service/dhcp
  744 ?        S      0:00     supervise klog PATH=/bin:/usr/bin
  784 ?        S      0:00       socklog ucspi
  745 ?        S      0:00     supervise log PATH=/bin:/usr/bin
  780 ?        S      0:00       svlogd -tt /var/log/service/klog
  746 ?        S      0:00     supervise once PATH=/bin:/usr/bin
  747 ?        S      0:00     supervise sshd PATH=/bin:/usr/bin
  748 ?        S      0:00       /usr/bin/sshd -D -e -p22 -u0
  775 ?        S      0:00     supervise r_zebra PATH=/bin:/usr/bin
  776 ?        S      0:00     supervise log PATH=/bin:/usr/bin
  797 ?        S      0:00       multilog t /var/log/service/r_zebra
  777 ?        S      0:00     supervise httpd PATH=/bin:/usr/bin
  792 ?        S      0:00       tcpserver -v -R -H -l 0 -c 40 0.0.0.0 www setuidgid root httpd -X -f /.local/var/service/httpd/httpd.conf
  778 ?        S      0:00     supervise log PATH=/bin:/usr/bin
  788 ?        S      0:00       multilog t /var/log/service/httpd
  786 ?        S      0:00     supervise pgsql PATH=/bin:/usr/bin
  787 ?        S      0:00     supervise log PATH=/bin:/usr/bin
  832 ?        S      0:00       multilog t /var/log/service/pgsql
  815 ?        S      0:00     supervise smb_s PATH=/bin:/usr/bin
  816 ?        S      0:00     supervise log PATH=/bin:/usr/bin
  840 ?        S      0:00       multilog t /var/log/service/smb_s
  817 ?        S      0:00     supervise nfs_mountd PATH=/bin:/usr/bin
  846 ?        S      0:00       rpc.mountd --foreground --debug all
  827 ?        S      0:00     supervise log PATH=/bin:/usr/bin
  857 ?        S      0:00       multilog t /var/log/service/nfs_mountd
  828 ?        S      0:00     supervise getty_ttyM0 PATH=/bin:/usr/bin
  829 ?        S      0:00     supervise getty_ttyS0 PATH=/bin:/usr/bin
  830 ?        S      0:00     supervise nmeter PATH=/bin:/usr/bin
 1011 ?        S      0:00       nmeter t c i x p b nif
  881 ?        S      0:00     supervise ovpn-1 PATH=/bin:/usr/bin
  882 ?        S      0:00     supervise log PATH=/bin:/usr/bin
  954 ?        S      0:00       multilog /var/log/service/ovpn-1
  884 ?        S      0:00     supervise r_ospf PATH=/bin:/usr/bin
  885 ?        S      0:00     supervise log PATH=/bin:/usr/bin
  886 ?        S      0:00       multilog /var/log/service/r_ospf
  889 ?        S      0:00     supervise getty_tty1 PATH=/bin:/usr/bin
  890 ?        S      0:00     supervise getty_tty2 PATH=/bin:/usr/bin
  970 ?        S      0:00       login -- vda               
 1676 tty2     S      0:00         -bash HOME=/home/vda PATH=/sbin:/bin:/usr/sbin:/usr/bin SHELL=/bin/bash TERM=linux MAIL=/var/mail/vda LOGNAME=vda
  891 ?        S      0:00     supervise getty_tty3 PATH=/bin:/usr/bin
  975 tty3     S      0:00       agetty 38400 /dev/tty3 linux TERM=linux
  892 ?        S      0:00     supervise getty_tty4 PATH=/bin:/usr/bin
  969 tty4     S      0:00       agetty 38400 /dev/tty4 linux TERM=linux
  893 ?        S      0:00     supervise getty_tty5 PATH=/bin:/usr/bin
  964 tty5     S      0:00       agetty 38400 /dev/tty5 linux TERM=linux
  894 ?        S      0:00     supervise getty_tty6 PATH=/bin:/usr/bin
  960 tty6     S      0:00       agetty 38400 /dev/tty6 linux TERM=linux
  895 ?        S      0:00     supervise getty_tty7 PATH=/bin:/usr/bin
  912 tty7     S      0:00       agetty 38400 /dev/tty7 linux TERM=linux
  896 ?        S      0:00     supervise getty_tty8 PATH=/bin:/usr/bin
  915 tty8     S      0:00       agetty 38400 /dev/tty8 linux TERM=linux
  897 ?        S      0:00     supervise syslog PATH=/bin:/usr/bin
  898 ?        S      0:00       socklog unix /dev/log PATH=/bin:/usr/bin PWD=/.local/var/service/syslog SHLVL=0 GID=50 UID=58
  899 ?        S      0:00     supervise log PATH=/bin:/usr/bin
  903 ?        S      0:00       svlogd /var/log/service/syslog
  900 ?        S      0:00     supervise nfs_statd PATH=/bin:/usr/bin
  934 ?        S      0:00       rpc.statd -F -d
  910 ?        S      0:00     supervise log PATH=/bin:/usr/bin
  911 ?        S      0:00       multilog t /var/log/service/nfs_statd
  924 ?        S      0:00     supervise automount PATH=/bin:/usr/bin
  951 ?        S      0:00       automount -f -s -v -d --timeout 15 /.local/mnt/auto program /root/bin/mapper.sh
  925 ?        S      0:00     supervise log PATH=/bin:/usr/bin
  926 ?        S      0:02       multilog t n5 /var/log/service/automount
  928 ?        S      0:00     supervise watcher PATH=/bin:/usr/bin
  929 ?        S      0:00     supervise udhcpd_eth0 PATH=/bin:/usr/bin
  719 ?        S      0:00   sleep 32000

And /init is:

#!/bin/sh

# Clean up env
unset HOSTNAME
unset devfs
unset MACHTYPE
unset SHLVL
unset SHELL
unset HOSTTYPE
unset OSTYPE
unset HOME
unset TERM
PATH=/bin:/usr/bin

exec >/dev/console
exec 2>&1
exec </dev/null
env - PATH="$PATH" /etc/some_startup_script_which_also_starts_svscan

# Close all descriptors
exec >&-
exec 2>&-
exec <&-
while true; do env - sleep 32000; done
--
vda
