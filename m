Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291806AbSB0IAx>; Wed, 27 Feb 2002 03:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292005AbSB0IAo>; Wed, 27 Feb 2002 03:00:44 -0500
Received: from kraid.nerim.net ([62.4.16.95]:54287 "HELO kraid.nerim.net")
	by vger.kernel.org with SMTP id <S291806AbSB0IA2>;
	Wed, 27 Feb 2002 03:00:28 -0500
Date: Wed, 27 Feb 2002 09:00:25 +0100
To: linux-kernel@vger.kernel.org
Subject: [2.4.18] OOPS in smbfs 
Message-ID: <20020227080024.GA16232@calixo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Face: "99`N"mZV/:<T->OLp[>#d3R;u.!ivtwAEpIQDL8rD#;L3Wm)~^)Uv=#;S!LZf1y8oRY7J#JR\Lr{*4Cn*32C89ln>0~5~tm--}j%hvhj+vtW><xbwA=@G8M||zPV0-r`:6zhMqq+_OC_0W*-:Wxzm3%|A5EE}VFnIgRU=+,L-hGdM"j&l'_^zK+%MBOsdmi#e3(3fGg^SGM
From: Cyrille Chepelov <cyrille@chepelov.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greetings,

  here's a oops I received while using smbfs; the server was mounted from
the following fstab entry:

//nt_server/misc /mnt/g smbfs username=HIDDEN,password=CENSORED,uid=0,gid=40,fmask=664,dmask=775,rw,user,noauto 0 0

I did nothing special at the time; I had just mounted the device, and was
tab-completing into a directory using zsh (there are no specially named files 
at all in that directory: everything matches [0-9a-zA-Z._]). The server is a 
fairly storyless NT4.0 x86 server (I'm not quite sure what service pack, and 
wouldn't be surprised if it was  still at SP0).

Kernel version is 2.4.18-rc4

Without further ado, here's the oops:

Unable to handle kernel paging request at virtual address d0000000
d12c48f7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d12c48f7>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: db138f13   ebx: d0000000   ecx: f5fef3fd   edx: 2bd0b637
esi: e1f7d45d   edi: ce2efe34   ebp: ce2efecc   esp: ce2efde4
ds: 0018   es: 0018   ss: 0018
Process zsh (pid: 20207, stackpage=ce2ef000)
Stack: c013c4a0 ce2efe9c d12d6730 00000000 00000000 00000000 00000000 cf4780a0 
       c292d8c0 20202020 00d3efd2 34333533 00000000 00000000 c80af000 0000000f 
       00000000 00000000 00000001 00000011 d12c3215 c635a6c0 ce2effb0 c013c4a0 
Call Trace: [<c013c4a0>] [<d12c3215>] [<c013c4a0>] [<c013c4a0>] [<d12c32a4>] 
   [<c013c4a0>] [<d12c415b>] [<c013c4a0>] [<c013c11b>] [<c013c4a0>] [<c013c603>] 
   [<c013c4a0>] [<c013bb0b>] [<c0106d2b>] 
Code: 0f b6 03 43 89 c2 c1 e2 04 01 f2 c1 e8 04 01 c2 8d 04 92 8d 

>>EIP; d12c48f6 <[smbfs]smb_fill_cache+52/2dc>   <=====
Trace; c013c4a0 <filldir64+0/114>
Trace; d12c3214 <[smbfs]smb_proc_readdir_long+3d0/434>
Trace; c013c4a0 <filldir64+0/114>
Trace; c013c4a0 <filldir64+0/114>
Trace; d12c32a4 <[smbfs]smb_proc_readdir+2c/40>
Trace; c013c4a0 <filldir64+0/114>
Trace; d12c415a <[smbfs]smb_readdir+37a/41c>
Trace; c013c4a0 <filldir64+0/114>
Trace; c013c11a <vfs_readdir+5a/7c>
Trace; c013c4a0 <filldir64+0/114>
Trace; c013c602 <sys_getdents64+4e/b2>
Trace; c013c4a0 <filldir64+0/114>
Trace; c013bb0a <sys_fcntl64+7e/88>
Trace; c0106d2a <system_call+32/38>
Code;  d12c48f6 <[smbfs]smb_fill_cache+52/2dc>
00000000 <_EIP>:
Code;  d12c48f6 <[smbfs]smb_fill_cache+52/2dc>   <=====
   0:   0f b6 03                  movzbl (%ebx),%eax   <=====
Code;  d12c48f8 <[smbfs]smb_fill_cache+54/2dc>
   3:   43                        inc    %ebx
Code;  d12c48fa <[smbfs]smb_fill_cache+56/2dc>
   4:   89 c2                     mov    %eax,%edx
Code;  d12c48fc <[smbfs]smb_fill_cache+58/2dc>
   6:   c1 e2 04                  shl    $0x4,%edx
Code;  d12c48fe <[smbfs]smb_fill_cache+5a/2dc>
   9:   01 f2                     add    %esi,%edx
Code;  d12c4900 <[smbfs]smb_fill_cache+5c/2dc>
   b:   c1 e8 04                  shr    $0x4,%eax
Code;  d12c4904 <[smbfs]smb_fill_cache+60/2dc>
   e:   01 c2                     add    %eax,%edx
Code;  d12c4906 <[smbfs]smb_fill_cache+62/2dc>
  10:   8d 04 92                  lea    (%edx,%edx,4),%eax
Code;  d12c4908 <[smbfs]smb_fill_cache+64/2dc>
  13:   8d 00                     lea    (%eax),%eax


% grep SMB /boot/config-2.4.18-rc4
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="utf8"
CONFIG_SMB_NLS=y

I hope this helps...

	-- Cyrille

-- 
Grumpf.

