Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbWEQHMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbWEQHMT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 03:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbWEQHMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 03:12:19 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:47126 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932461AbWEQHMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 03:12:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mEurIIeqe5rh+OoaTktdFhhn4swqTxNURtICV+g+x7KBXfVNRi+9qMiukR+cP4Fq7IKEKgeJ1CeY+gb/KTf7Uv2Si8zRUZXaD43n1fNT5x18SGvJK5iONk5PiePnwfgpmEmLmQacmzwSK55+brrc5C4f0ld1pmoEcoZ1aInV/BE=
Message-ID: <446ACCCF.1030406@gmail.com>
Date: Wed, 17 May 2006 01:12:15 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Adrian Bunk <bunk@stusta.de>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc4-mm1 nfsroot build err, looks related to klibc
References: <44692CA1.5000903@gmail.com> <446950E3.4060601@zytor.com> <20060516101838.GK6931@stusta.de> <446A2243.6050109@zytor.com>
In-Reply-To: <446A2243.6050109@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Adrian Bunk wrote:
>> On Mon, May 15, 2006 at 09:11:15PM -0700, H. Peter Anvin wrote:
>>> Jim Cromie wrote:
>>>> Im getting nfsroot build error on 2 configs, both carried forward
>>> >from good rc4 and from rc3-mm1 builds.
>>>> turning off nfsroot fixes the err.
>>>>
>>> Could you throw me your configs, so I can try to reproduce it here?
>>
>> The problem is:
>>
>> CONFIG_IP_PNP=y
>> CONFIG_NFS_FS=y
>> CONFIG_ROOT_NFS=y
>>
>> A (compile-only) .config exhibiting this error is attached.
>>
>
> Yeah, OK, problem recovered; total thinko on my part -- I forgot to 
> remove the in-kernel nfsroot code.  Just setting CONFIG_ROOT_NFS=n 
> will work just fine; right now kinit doesn't depend on the 
> configuration (another buglet for my list), so if you set 
> CONFIG_ROOT_NFS=n the kernel will compile *and* nfsroot should still 
> work.
>
>     -hpa
>
Ok, it built clean, but broke on boot.

Running ipconfig
IP-Config: argc == 3
  argv[1]: '-n'
  argv[2]: 
'nfsaddrs=192.168.42.100:192.168.42.1:192.168.42.1:255.255.255.0:soekris:eth0'
IP-Config: parse_device: "nfsaddrs=192.168.4[   58.550017] eth0: DSPCFG 
accepted after 0 usec.
[   58.555452] eth0: link up.
[   58.558221] eth0: Setting full-duplex based on negotiated link 
capability.
2.100:192.168.42.1:192.168.42.1:255.255.255.0:soekris:eth0"
IP-Config: opt #0: '192.168.42.100'
IP-Config: opt #1: '192.168.42.1'
IP-Config: opt #2: '192.168.42.1'
IP-Config: opt #3: '255.255.255.0'
IP-Config: opt #4: 'soekris'
IP-Config: opt #5: 'eth0'
IP-Config: eth0 hardware address 00:00:24:c2:46:c8 mtu 1500
IP-Config: eth0 guessed broadcast address 192.168.42.255
IP-Config: eth0 guessed nameserver address 192.168.42.1
IP-Config: eth0 complete (from 192.168.42.1):
 address: 192.168.42.100   broadcast: 192.168.42.255   netmask: 
255.255.255.0
 gateway: 192.168.42.1    [   58.616298] Kernel panic - not syncing: 
Attempted to kill init!
 dns0     : 192.[   58.622750]  168.42.1     dns<0>Rebooting in 5 
seconds..1   : 0.0.0.0
 host   : soekris
 rootserver: 192.168.42.1 rootpath:
kinit: do_mounts
kinit: name_to_dev_t(/dev/nfs) = dev(0,255)
kinit: root_dev = dev(0,255)
NFS-Root: mounting console=ttyS0,115200n81 on /root with options 'none'
kinit: need a server
Checking for init: /sbin/init
Checking for init: /bin/init
Checking for init: /etc/init
Checking for init: /bin/sh
kinit: init not found!


POST: 0123456789bcefghipajklnopq,,,tvwxy

