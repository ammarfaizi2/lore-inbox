Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751530AbWFPWiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbWFPWiM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 18:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWFPWiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 18:38:12 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:21187 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751529AbWFPWiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 18:38:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AhHT0L4DdZR+qgYxHXz4N0WaTlsNKsZGPgF7KgXHqR1X3IvNsf90P+9pPF8ejz61h7xkSyArahl2GZNwMJZwRPI+rITNCA7aLBKA3y9P9RTU8nEujHtJNvHRmP8Nb0mFemcg2OjV6xnlD44tLuKCZdN2XLVvoqkPF2q/P1FDppU=
Message-ID: <6bffcb0e0606161538w41036b4ajdb394ef5a36eebd2@mail.gmail.com>
Date: Sat, 17 Jun 2006 00:38:10 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Grant Coady" <gcoady.lk@gmail.com>
Subject: Re: Linux 2.4.33-rc1
Cc: "Marcelo Tosatti" <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       "Willy Tarreau" <willy@w.ods.org>
In-Reply-To: <hka6925bl0in1f3jm7m4vh975a64lcbi7g@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060616181419.GA15734@dmt>
	 <hka6925bl0in1f3jm7m4vh975a64lcbi7g@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grant,

On 17/06/06, Grant Coady <gcoady.lk@gmail.com> wrote:
> On Fri, 16 Jun 2006 15:14:19 -0300, Marcelo Tosatti <marcelo@kvack.org> wrote:
>
> >Here is 2.4.33-rc1.
>
> I provoked a network related oops as user 'grant', with this CLI input
> boo-boo on an ssh terminal:
>
> grant@sempro:~$ rm /home/share/config-2.6.17-rc6-mm1a dmesg-2.6.17-rc6-mm1a
>
> /home/share is an NFS mounted directory
>
> Was able to login direct as root and copy the oops info with mouse (gpm)
> copy/paste, but console locked up on localnet access, here's the guff:
>
> ksymoops 2.4.11 on i686 2.4.33-rc1.  Options used
>      -v /home/grant/linux/linux-2.4.33-rc1/vmlinux (specified)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.33-rc1/ (default)
>      -m /boot/System.map-2.4.33-rc1 (specified)
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000088
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c013eeb4>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010282
> eax: 00000000   ebx: 00000000   ecx: 00000088   edx: 00000088
> esi: f6e2fd08   edi: f5839ac0   ebp: f6e2fc80   esp: f5889f6c
> ds: 0018   es: 0018   ss: 0018
> Process rm (pid: 243, stackpage=f5889000)
> Stack: f6e2fc80 f5839ac0 f5839ac0 f7bdd000 f5889f90 f5839ac0 c013f066 f6e2fc80
>        f5839ac0 f6e36440 c19ac440 f7bdd00c 00000016 be8f2661 00000010 00000000
>        00000004 f5888000 bffff96b 08051050 bffff758 c0106eff bffff96b 00000002
> Call Trace:    [<c013f066>] [<c0106eff>]
> Code: ff 80 88 00 00 00 0f 8e 2e 16 00 00 85 db 74 16 89 d8 8b 5c
>
>
> >>EIP; c013eeb4 <vfs_unlink+a4/1a0>   <=====
>
> >>esi; f6e2fd08 <_end+36a9405c/386be3d4>
> >>edi; f5839ac0 <_end+3549de14/386be3d4>
> >>ebp; f6e2fc80 <_end+36a93fd4/386be3d4>
> >>esp; f5889f6c <_end+354ee2c0/386be3d4>
>
> Trace; c013f066 <sys_unlink+b6/120>
> Trace; c0106eff <system_call+33/38>
>
> Code;  c013eeb4 <vfs_unlink+a4/1a0>
> 00000000 <_EIP>:
> Code;  c013eeb4 <vfs_unlink+a4/1a0>   <=====
>    0:   ff 80 88 00 00 00         incl   0x88(%eax)   <=====
> Code;  c013eeba <vfs_unlink+aa/1a0>
>    6:   0f 8e 2e 16 00 00         jle    163a <_EIP+0x163a>
> Code;  c013eec0 <vfs_unlink+b0/1a0>
>    c:   85 db                     test   %ebx,%ebx
> Code;  c013eec2 <vfs_unlink+b2/1a0>
>    e:   74 16                     je     26 <_EIP+0x26>
> Code;  c013eec4 <vfs_unlink+b4/1a0>
>   10:   89 d8                     mov    %ebx,%eax
> Code;  c013eec6 <vfs_unlink+b6/1a0>
>   12:   8b 5c 00 00               mov    0x0(%eax,%eax,1),%ebx
>
>
> Just done it again, not my finger trouble at all, again via ssh terminal,
> deleting a file from an NFS mounted directory:
>
> grant@sempro:~$ rm /home/share/dmesg-2.6.17-rc6-mm1a
> Segmentation fault
>
> Note: the file was successfully deleted.  No reboot for this one:
>
> root@sempro:~# ksymoops -v /home/grant/linux/linux-2.4.33-rc1/vmlinux -m /boot/System.map-2.4.33-rc1 oops2
> ksymoops 2.4.11 on i686 2.4.33-rc1.  Options used
>      -v /home/grant/linux/linux-2.4.33-rc1/vmlinux (specified)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.33-rc1/ (default)
>      -m /boot/System.map-2.4.33-rc1 (specified)
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000088
> *pde = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0010:[<c013eeb4>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010282
> eax: 00000000   ebx: 00000000   ecx: 00000088   edx: 00000088
> esi: f6e2cd08   edi: f56cf640   ebp: f6e2cc80   esp: f5715f6c
> ds: 0018   es: 0018   ss: 0018
> Process rm (pid: 311, stackpage=f5715000)
> Stack: f6e2cc80 f56cf640 f56cf640 f5d18000 f5715f90 f56cf640 c013f066 f6e2cc80
>        f56cf640 f6fdf440 c19ac440 f5d1800c 00000015 eab76344 00000010 00000000
>        00000004 f5714000 bffff982 08051050 bffff768 c0106eff bffff982 00000002
> Call Trace:    [<c013f066>] [<c0106eff>]
> Code: ff 80 88 00 00 00 0f 8e 2e 16 00 00 85 db 74 16 89 d8 8b 5c
>
>
> >>EIP; c013eeb4 <vfs_unlink+a4/1a0>   <=====
>
> >>esi; f6e2cd08 <_end+36a9105c/386be3d4>
> >>edi; f56cf640 <_end+35333994/386be3d4>
> >>ebp; f6e2cc80 <_end+36a90fd4/386be3d4>
> >>esp; f5715f6c <_end+3537a2c0/386be3d4>
>
> Trace; c013f066 <sys_unlink+b6/120>
> Trace; c0106eff <system_call+33/38>
>
> Code;  c013eeb4 <vfs_unlink+a4/1a0>
> 00000000 <_EIP>:
> Code;  c013eeb4 <vfs_unlink+a4/1a0>   <=====
>    0:   ff 80 88 00 00 00         incl   0x88(%eax)   <=====
> Code;  c013eeba <vfs_unlink+aa/1a0>
>    6:   0f 8e 2e 16 00 00         jle    163a <_EIP+0x163a>
> Code;  c013eec0 <vfs_unlink+b0/1a0>
>    c:   85 db                     test   %ebx,%ebx
> Code;  c013eec2 <vfs_unlink+b2/1a0>
>    e:   74 16                     je     26 <_EIP+0x26>
> Code;  c013eec4 <vfs_unlink+b4/1a0>
>   10:   89 d8                     mov    %ebx,%eax
> Code;  c013eec6 <vfs_unlink+b6/1a0>
>   12:   8b 5c 00 00               mov    0x0(%eax,%eax,1),%ebx
>
>
> Since I use NFS here, no further testing 33-rc1 on the other boxen.
> More info, testing on request.  The server exporting the NFS share is
> running 2.4.32-hf-latest:
>
> Now running:    2.4.32-hf32.6
> Uptime: 08:19:43 up 16 days, 14:27, 1 user, load average: 0.00, 0.00, 0.00
>
> <http://bugsplatter.mine.nu/test/boxen/deltree/>
>
> Grant.

Can you revert 42cce987d63d3048595b8b00d74be786707d5e5d commit?

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
