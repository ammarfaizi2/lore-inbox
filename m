Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRLZTMW>; Wed, 26 Dec 2001 14:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280126AbRLZTMN>; Wed, 26 Dec 2001 14:12:13 -0500
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:7177 "EHLO
	gandalf.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id <S274862AbRLZTME>; Wed, 26 Dec 2001 14:12:04 -0500
Date: Wed, 26 Dec 2001 20:10:44 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17]: oops in usbcore during suspend
Message-ID: <20011226201044.A30712@galadriel.physik.uni-konstanz.de>
In-Reply-To: <20011223230723.GA1483@bogon.ms20.nix> <20011223184243.D5941@kroah.com> <20011226180021.A30644@galadriel.physik.uni-konstanz.de> <20011226100353.D3460@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011226100353.D3460@kroah.com>; from greg@kroah.com on Wed, Dec 26, 2001 at 10:03:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2001 at 10:03:53AM -0800, Greg KH wrote:
> On Wed, Dec 26, 2001 at 06:00:21PM +0100, Guido Guenther wrote:
> > Call Trace: [usbcore:usb_devfs_handle_Re9c5f87f+174345/197882743] [usbcore:usb_devfs_handle_Re9c5f87f+174855/197882233] [pci_pm_suspend_device+32/36] [pci_pm_suspend_bus+82/104] [pci_pm_suspend+35/68] 
> 
> These aren't valid symbols :)
> It looks like something is messing with your oops output before you run
> it through ksymoops.  Can you take the raw values from 'dmesg'?

This explains why the ksymoops output made no sense to me. The problem seems
to be alsa related now.  I'll move this over to the alsa list then.   
Thanks a lot for your time,
 -- Guido

ksymoops 2.4.3 on i686 2.4.17-bogon.  Options used
     -V (default)
     -k /proc/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-bogon/ (default)
     -m /boot/System.map-2.4.17-bogon (default)

Unable to handle kernel paging request at virtual address 006f7317
c8c6d876
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c8c6d876>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013246
eax: 00000000   ebx: c0f92000   ecx: c1210000   edx: c8c7978c
esi: 00000000   edi: 006f7267   ebp: 00000000   esp: c0f93ed0
ds: 0018   es: 0018   ss: 0018
Process kapm-idled (pid: 46, stackpage=c0f93000)
Stack: c0f92000 00000000 c0d2d600 c8c7959d 006f7267 c1210008 c1213ab4 c1213aa0 
       00000003 00000000 c8c7979b c0d2d600 00000000 c019f7cc c1210000 00000003 
       c019f8ae c1210000 00000003 c1213aa0 00000003 00000003 c0225d80 c019f997 
Call Trace: [<c8c7959d>] [<c8c7979b>] [<c019f7cc>] [<c019f8ae>] [<c019f997>] 
   [<c019fa26>] [<c011ea36>] [<c011eae9>] [<c8c3f6e0>] [<c8c3f937>] [<c8c3fa51>] 
   [<c8c3fad3>] [<c8c40e1c>] [<c8c41314>] [<c8c40488>] [<c010546f>] [<c0105478>] 
Code: 8b 9c 38 b0 00 00 00 85 db 74 28 8b 43 50 85 c0 74 1a 8b 80 

>>EIP; c8c6d876 <[snd-pcm]snd_pcm_suspend_all+e/50>   <=====
Trace; c8c7959c <[snd-card-maestro3]m3_suspend+54/114>
Trace; c8c7979a <[snd-card-maestro3]snd_m3_suspend+e/18>
Trace; c019f7cc <pci_pm_suspend_device+20/24>
Trace; c019f8ae <pci_pm_suspend_bus+52/68>
Trace; c019f996 <pci_pm_suspend+22/44>
Trace; c019fa26 <pci_pm_callback+2e/40>
Trace; c011ea36 <pm_send+3e/70>
Trace; c011eae8 <pm_send_all+44/90>
Trace; c8c3f6e0 <[apm]send_event+20/74>
Trace; c8c3f936 <[apm]check_events+f6/198>
Trace; c8c3fa50 <[apm]apm_event_handler+78/7c>
Trace; c8c3fad2 <[apm]apm_mainloop+7e/11c>
Trace; c8c40e1c <[apm]error_table+4fc/87e>
Trace; c8c41314 <[apm]apm_waitqueue+4/c>
Trace; c8c40488 <[apm]apm+298/2b4>
Trace; c010546e <kernel_thread+1e/38>
Trace; c0105478 <kernel_thread+28/38>
Code;  c8c6d876 <[snd-pcm]snd_pcm_suspend_all+e/50>
00000000 <_EIP>:
Code;  c8c6d876 <[snd-pcm]snd_pcm_suspend_all+e/50>   <=====
   0:   8b 9c 38 b0 00 00 00      mov    0xb0(%eax,%edi,1),%ebx   <=====
Code;  c8c6d87c <[snd-pcm]snd_pcm_suspend_all+14/50>
   7:   85 db                     test   %ebx,%ebx
Code;  c8c6d87e <[snd-pcm]snd_pcm_suspend_all+16/50>
   9:   74 28                     je     33 <_EIP+0x33> c8c6d8a8 <[snd-pcm]snd_pcm_suspend_all+40/50>
Code;  c8c6d880 <[snd-pcm]snd_pcm_suspend_all+18/50>
   b:   8b 43 50                  mov    0x50(%ebx),%eax
Code;  c8c6d884 <[snd-pcm]snd_pcm_suspend_all+1c/50>
   e:   85 c0                     test   %eax,%eax
Code;  c8c6d886 <[snd-pcm]snd_pcm_suspend_all+1e/50>
  10:   74 1a                     je     2c <_EIP+0x2c> c8c6d8a2 <[snd-pcm]snd_pcm_suspend_all+3a/50>
Code;  c8c6d888 <[snd-pcm]snd_pcm_suspend_all+20/50>
  12:   8b 80 00 00 00 00         mov    0x0(%eax),%eax

