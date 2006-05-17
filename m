Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750745AbWEQRRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbWEQRRl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 13:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWEQRRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 13:17:41 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:28132 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750743AbWEQRRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 13:17:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=gRw/UZxkrsA7846LlL3nnHvgvACgCanXnGo6WxjwXlxCflhzFXLtTXOuDK+c9hw6o+76jlZl79WFa161Lh7DOVglkbV+KRt4Dt5YMuRQfeIbJn3fmd8BKa3Y7cg3NJZiiHH9vvoK73EAQc7ZSitJAqOqGLbLaUL4XUVvHfnvV6Y=
Message-ID: <446B5AB0.8050703@gmail.com>
Date: Wed, 17 May 2006 11:17:36 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Adrian Bunk <bunk@stusta.de>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc4-mm1 nfsroot build err, looks related to klibc
References: <44692CA1.5000903@gmail.com> <446950E3.4060601@zytor.com> <20060516101838.GK6931@stusta.de> <446A2243.6050109@zytor.com> <446ACCCF.1030406@gmail.com> <446B4BDD.9090208@zytor.com>
In-Reply-To: <446B4BDD.9090208@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Jim Cromie wrote:
>>>
>> Ok, it built clean, but broke on boot.
>>
>
> What does the full command line look like?
>
>     -hpa
>
I presume you mean the kernel boot-line, since last post included the 
'Running ipconfig'

Ive been banging at the kernel with permutations of the following 
pxelinux stanza.

LABEL   I 2.6.17-rc4-mm1-sk
  MENU LABEL    ^i.  2.6.17-rc4-mm1-sk
  KERNEL        vmlinuz-2.6.17-rc4-mm1-sk
  APPEND        console=ttyS0,115200n81 root=/dev/nfs 
nfsroot=/nfshost/truck 
ip=192.168.42.100:192.168.42.1:192.168.42.1:255.255.255.0:soekris:eth0 
panic=5

I think the problem lies with picking up a decent 'rootpath', since that
part of the output is always empty, for all variations tried so far..





[   58.619824] Kernel command line: console=ttyS0,115200n81 
root=/dev/nfs nfsroot=192.168.42.1:/nfshost/truck 
ip=::192.168.42.1:255.255.255.0:soekris:eth0 panic=5  
BOOT_IMAGE=vmlinuz-2.6.17-rc4-mm1-sk



Running ipconfig
IP-Config: argc == 3
  argv[1]: '-n'
  argv[2]: 'ip=::192.168.42.1:255.255.255.0:soekris:eth0'
IP-Config: parse_device: "ip=::192.168.42.1:255.255.255.0:soekris:eth0"
IP-[   63.978181] eth0: DSPCFG accepted after 0 usec.
[   63.983643] eth0: link up.
[   63.986413] eth0: Setting full-duplex based on negotiated link 
capability.
Config: opt #2: '192.168.42.1'
IP-Config: opt #3: '255.255.255.0'
IP-Config: opt #4: 'soekris'
IP-Config: opt #5: 'eth0'
IP-Config: eth0 hardware address 00:00:24:c2:46:c8 mtu 1500 DHCP RARP
eth0: state = 2
timeout
Delta: 10 ms
Delta: 5 ms
eth0: state = 2
Delta: 5 ms
Delta: 7 ms
eth0: state = 2
Delta: 5 ms
Delta: 12 ms
eth0: state = 2
Delta: 5 ms
Delta: 7 ms
eth0: state = 2
Delta: 5 ms
Delta: 6 ms
eth0: state = 2
Delta: 5 ms
Delta: 6 ms
eth0: state = 2
Delta: 5 ms
Delta: 5 ms
eth0: state = 2
[   64.092414] TSC appears to be running slowly. Marking it as unstable
[   20.596000] Time: pit clocksource has been installed.
Delta: 606 ms
Delta: 396 ms
eth0: state = 2
timeout
-> dhcp discover xid 5a2913c7 secs 1
   udp src 68 dst 67
   ip src 0.0.0.0 dst 255.255.255.255
   bytes 283
<- bytes 328
   ip src 192.168.42.1 dst 192.168.42.100
   udp src 67 dst 68
   dhcp xid 5a2913c7
   dhcp offer
-> dhcp request xid 5a2913c7 secs 1
   udp src 68 dst 67
   ip src 0.0.0.0 dst 255.255.255.255
   bytes 295

Delta: 3 ms
Delta: 1004 ms
eth0: state = 3
timeout
-> dhcp request xid 5a2913c7 secs 2
   udp src 68 dst 67
   ip src 0.0.0.0 dst 255.255.255.255
   bytes 295
<- bytes 328
   ip src 192.168.42.1 dst 192.168.42.100
   udp src 67 dst 68
   dhcp xid 5a2913c7
   dhcp ack
IP-Config: eth0 guessed nameserver address 192.168.42.1
IP-Config: eth0 complete (from 192.168.42.1):
 address: 192.168.42.100   broadcast: 192.168.42.255   netmask: 
255.255.255.0
 gateway: 0.0.0.0          dns0     : 192.168.42.1     dns1   : 0.0.0.0
 rootserver: 192.168.42.1 rootpath:
eth0: state = 4
kinit: do_mounts
kinit: name_to_dev_t(/dev/nfs) = dev(0,255)
kinit: root_dev = dev(0,255)
NFS-Root: mounting console=ttyS0,115200n81 on /root with options 'none'

this 'mount' -------------^---------- is clearly broken,
        DEBUG(("NFS-Root: mounting %s on %s with options '%s'\n",
               argv[a - 1], mtpt, opts ? opts : "none"));

though I havent un-wound it back far enough to figure whether this kinit 
function
actually wants to look at the entire kernel boot-line (the IP-Config: 
argc part
shows that this prog/tool/thingy doesnt get the entire boot-line (so it 
will never see the nfsroot= bit)


kinit: ne[   22.664000] Kernel panic - not syncing: Attempted to kill init!
ed a server
Che[   22.668000]  cking for init: <0>Rebooting in 5 seconds../sbin/init
Checking for init: /bin/init
Checking for init: /etc/init
Checking for init: /bin/sh
kinit: init not found!


POST: 0123456789bcefghipajklnopq,,,tvwxy




another run, with some alterations on kernel cmdline

[  114.558035] Kernel command line: 
ip=::192.168.42.1:255.255.255.0:soekris:eth0 panic=5   
console=ttyS0,115200n81 root=/dev/nfs nfsroot=/nfshost/truck  
BOOT_IMAGE=vmlinuz-2.6.17-rc4-mm1-sk

IP-Config: eth0 guessed nameserver address 192.168.42.1
IP-Config: eth0 complete (from 192.168.42.1):
 address: 192.168.42.100   broadcast: 192.168.42.255   netmask: 
255.255.255.0
 gateway: 0.0.0.0          dns0     : 192.168.42.1     dns1   : 0.0.0.0
 rootserver: 192.168.42.1 rootpath:
eth0: state = 4
kinit: do_mounts
kinit: name_to_dev_t(/dev/nfs) = dev(0,255)
kinit: root_dev = dev(0,255)
NFS-Root: mounting ip= on /root with options 'none'
kinit: need a server
Check[   22.664000] Kernel panic - not syncing: Attempted to kill init!
ing for init: /s[   22.668000]  bin/init
Checki<0>Rebooting in 5 seconds..ng for init: /bin/init
Checking for init: /etc/init
Checking for init: /bin/sh
kinit: init not found!


POST: 0123456789bcefghipajklnopq,,,tvwxy



[   19.417201] Kernel command line: ip=::::soekris:eth0 panic=5   
console=ttyS0,115200n81 root=/dev/nfs nfsroot=/nfshost/truck  
BOOT_IMAGE=vmlinuz-2.6.17-rc4-mm1-sk


Running ipconfig
IP-Config: argc == 3
  argv[1]: '-n'
  argv[2]: 'ip=::::soekris:eth0'
IP-Config: parse_device: "ip=::::soekris:eth0"
IP-Config: opt #4: 'soekris'
IP-Config: opt #5: 'eth[   24.771544] eth0: DSPCFG accepted after 0 usec.
[   24.777287] eth0: link up.
[   24.780061] eth0: Setting full-duplex based on negotiated link 
capability.
0'
IP-Config: eth0 hardware address 00:00:24:c2:46:c8 mtu 1500 DHCP RARP
eth0: state = 2

< good dhcp negotiation trimmed>

   ip src 192.168.42.1 dst 192.168.42.100
   udp src 67 dst 68
   dhcp xid 03859cb5
   dhcp ack
IP-Config: eth0 guessed nameserver address 192.168.42.1
IP-Config: eth0 complete (from 192.168.42.1):
 address: 192.168.42.100   broadcast: 192.168.42.255   netmask: 
255.255.255.0
 gateway: 0.0.0.0          dns0     : 192.168.42.1     dns1   : 0.0.0.0
 rootserver: 192.168.42.1 rootpath:
eth0: state = 4
kinit: do_mounts
kinit: name_to_dev_t(/dev/nfs) = dev(0,255)
kinit: root_dev = dev(0,255)
NFS-Root: mounting ip= on /root with options 'none'

                                     ^  again,   argv[a - 1] passed to 
mount_nfs_root() has garbage in it.

kinit: need a server
Checkin[   22.656000] Kernel panic - not syncing: Attempted to kill init!
g for init: /sbi[   22.660000]  n/init
Checking<0>Rebooting in 5 seconds.. for init: /bin/init
Checking for init: /etc/init
Checking for init: /bin/sh
kinit: init not found!



OK - one more run, this time with root-path option given via dhcpd

        host soekris {
                hardware ethernet 00:00:24:C2:46:C8;
                fixed-address 192.168.42.100;
                filename "pxelinux.0";
               option root-path "/nfshost/truck";
        }

IP-Config: eth0 guessed nameserver address 192.168.42.1
IP-Config: eth0 complete (from 192.168.42.1):
 address: 192.168.42.100   broadcast: 192.168.42.255   netmask: 
255.255.255.0
 gateway: 0.0.0.0          dns0     : 192.168.42.1     dns1   : 0.0.0.0
 rootserver: 192.168.42.1 rootpath: /nfshost/truck
eth0: state = 4
kinit: do_mounts
kinit: name_to_dev_t(/dev/nfs) = dev(0,255)
kinit: root_dev = dev(0,255)
nfsroot=/nfshost/truck overrides boot server bootpath /nfshost/truck

^ output shows that the boot-line is being picked up, so apparently its
just not getting passed properly into
int mount_nfs_root(int argc, char *argv[], int flags)
..I think..  FMIIW .. (thats Forgive!)

NFS-Root: mo[   22.656000] Kernel panic - not syncing: Attempted to kill 
init!
unting ip= on /r[   22.664000]  oot with options<0>Rebooting in 5 
seconds.. 'none'
kinit: need a server
Checking for init: /sbin/init
Checking for init: /bin/init
Checking for init: /etc/init
Checking for init: /bin/sh
kinit: init not found!



hth,
thanks for yours,
-jimc

