Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262712AbRE0CXN>; Sat, 26 May 2001 22:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262714AbRE0CXD>; Sat, 26 May 2001 22:23:03 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:44306 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S262712AbRE0CWq>; Sat, 26 May 2001 22:22:46 -0400
Date: Sun, 27 May 2001 04:21:30 +0200
From: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: new aic7xxx oopses with AHA2940
Message-ID: <20010527042129.A12765@lisa.links2linux.home>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20010526180529.A7595@lisa.links2linux.home> <21164.990925636@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <21164.990925636@ocs3.ocs-net>; from kaos@ocs.com.au on Sun, May 27, 2001 at 11:07:16AM +1000
X-Operating-System: Linux 2.2.18-lisa01 i586
X-Editor: VIM 5.7.8
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Keith Owens schrieb am 27.05.01 um 03:07 Uhr:
> Because you are using a broken version of klogd that stuffs up oops
> traces.  Change klogd to run as klogd -x (probably in
> /etc/rc.d/init.d/syslog) so it keeps its broken fingers off the oops.
> 

done

> Since you are failing during modprobe, creating /var/log/ksymoops is a
> good idea, man insmod, see KSYMOOPS ASSISTANCE.  Reproduce the
> problem to get a clean oops trace then run it through ksymoops, using
> the saved module data in /var/log/ksymoops.
> 

OK. Now I cut out the Oops out of my /var/log/messages, then did

cat aic7xxx.oops | ksymoops -k /var/log/ksymoops/20010527040453.ksyms -l
/var/log/ksymoops/20010527040453.modules > trace1

and another run with default options:

cat aic7xxx.oops | ksymoops > trace2

trace1:
#######################

ksymoops 0.7c on i686 2.4.5.  Options used
     -V (default)
     -k 20010527040453.ksyms (specified)
     -l 20010527040453.modules (specified)
     -o /lib/modules/2.4.5/ (default)
     -m /usr/src/linux/System.map (default)

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
May 27 04:06:08 homer kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
May 27 04:06:08 homer kernel: e0a7b3a7
May 27 04:06:08 homer kernel: *pde = 00000000
May 27 04:06:08 homer kernel: Oops: 0000
May 27 04:06:08 homer kernel: CPU:    0
May 27 04:06:08 homer kernel: EIP:    0010:[<e0a7b3a7>]
Using defaults from ksymoops -t elf32-i386 -a i386
May 27 04:06:08 homer kernel: EFLAGS: 00010096
May 27 04:06:08 homer kernel: eax: 00000041   ebx: 00000000   ecx: dd5bdc00   edx: 00000000
May 27 04:06:08 homer kernel: esi: 00000000   edi: 000000ff   ebp: dd5bdc00   esp: dd065cbc
May 27 04:06:08 homer kernel: ds: 0018   es: 0018   ss: 0018
May 27 04:06:08 homer kernel: Process modprobe (pid: 480, stackpage=dd065000)
May 27 04:06:08 homer kernel: Stack: 00000000 00000000 000000ff dd5bdc00 41000357 e0a7b79d dd5bdc00 00000000 
May 27 04:06:08 homer kernel:        ffffffff 00000041 ffffffff 000000ff 00000000 00000041 00000000 dd5bdc00 
May 27 04:06:08 homer kernel:        dd5bdc00 00000001 00000001 00000001 00000001 00000001 00000000 00000001 
May 27 04:06:08 homer kernel: Call Trace: [<e0a7b79d>] [<e0a7c226>] [<c0234ce3>] [<e0a7c81d>] [<e0a70990>] [<e0a812a9>] [<e0a7dca7>] 
May 27 04:06:08 homer kernel:        [<c0230000>] [<e0a6f93e>] [<e0a78855>] [<e0a6f891>] [<e0a6f8b0>] [<e0a85280>] [<c01d6fdc>] [<e0a85300>] 
May 27 04:06:08 homer kernel:        [<e0a85360>] [<c01d7054>] [<e0a85360>] [<e0a85280>] [<e0a7287a>] [<e0a6f74e>] [<e0a85280>] [<e0a6f068>] 
May 27 04:06:08 homer kernel:        [<c01bf7d9>] [<e0a85280>] [<e0a85280>] [<e0a6f068>] [<e0a6f000>] [<e0a6f068>] [<c01c003d>] [<e0a85280>] 
May 27 04:06:08 homer kernel:        [<e0a6f000>] [<e0a726d6>] [<e0a85280>] [<c011541d>] [<e0a68000>] [<e0a6f060>] [<c0106b9b>] 
May 27 04:06:08 homer kernel: Code: 8b 02 8b 7c 24 20 8b 6c 24 28 0f b6 40 19 f6 81 f0 00 00 00 

>>EIP; e0a7b3a7 <END_OF_CODE+f4cb/????>   <=====
Trace; e0a7b79d <END_OF_CODE+f8c1/????>
Trace; e0a7c226 <END_OF_CODE+1034a/????>
Trace; c0234ce3 <__delay+13/30>
Trace; e0a7c81d <END_OF_CODE+10941/????>
Trace; e0a70990 <__module_parm_multicast_filter_limit+4ab4/????>
Trace; e0a812a9 <END_OF_CODE+153cd/????>
Trace; e0a7dca7 <END_OF_CODE+11dcb/????>
Trace; c0230000 <rpc_new_task+f0/170>
Trace; e0a6f93e <__module_parm_multicast_filter_limit+3a62/????>
Trace; e0a78855 <END_OF_CODE+c979/????>
Trace; e0a6f891 <__module_parm_multicast_filter_limit+39b5/????>
Trace; e0a6f8b0 <__module_parm_multicast_filter_limit+39d4/????>
Trace; e0a85280 <END_OF_CODE+193a4/????>
Trace; c01d6fdc <pci_announce_device+1c/50>
Trace; e0a85300 <END_OF_CODE+19424/????>
Trace; e0a85360 <END_OF_CODE+19484/????>
Trace; c01d7054 <pci_register_driver+44/60>
Trace; e0a85360 <END_OF_CODE+19484/????>
Trace; e0a85280 <END_OF_CODE+193a4/????>
Trace; e0a7287a <__module_parm_multicast_filter_limit+699e/????>
Trace; e0a6f74e <__module_parm_multicast_filter_limit+3872/????>
Trace; e0a85280 <END_OF_CODE+193a4/????>
Trace; e0a6f068 <__module_parm_multicast_filter_limit+318c/????>
Trace; c01bf7d9 <scsi_register_host+49/2d0>
Trace; e0a85280 <END_OF_CODE+193a4/????>
Trace; e0a85280 <END_OF_CODE+193a4/????>
Trace; e0a6f068 <__module_parm_multicast_filter_limit+318c/????>
Trace; e0a6f000 <__module_parm_multicast_filter_limit+3124/????>
Trace; e0a6f068 <__module_parm_multicast_filter_limit+318c/????>
Trace; c01c003d <scsi_register_module+2d/60>
Trace; e0a85280 <END_OF_CODE+193a4/????>
Trace; e0a6f000 <__module_parm_multicast_filter_limit+3124/????>
Trace; e0a726d6 <__module_parm_multicast_filter_limit+67fa/????>
Trace; e0a85280 <END_OF_CODE+193a4/????>
Trace; c011541d <sys_init_module+4fd/5a0>
Trace; e0a68000 <[emu10k1].data.end+23f9/2459>
Trace; e0a6f060 <__module_parm_multicast_filter_limit+3184/????>
Trace; c0106b9b <system_call+33/38>
Code;  e0a7b3a7 <END_OF_CODE+f4cb/????>
00000000 <_EIP>:
Code;  e0a7b3a7 <END_OF_CODE+f4cb/????>   <=====
   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  e0a7b3a9 <END_OF_CODE+f4cd/????>
   2:   8b 7c 24 20               mov    0x20(%esp,1),%edi
Code;  e0a7b3ad <END_OF_CODE+f4d1/????>
   6:   8b 6c 24 28               mov    0x28(%esp,1),%ebp
Code;  e0a7b3b1 <END_OF_CODE+f4d5/????>
   a:   0f b6 40 19               movzbl 0x19(%eax),%eax
Code;  e0a7b3b5 <END_OF_CODE+f4d9/????>
   e:   f6 81 f0 00 00 00 00      testb  $0x0,0xf0(%ecx)


1 warning issued.  Results may not be reliable.

#################################################

trace2:
#################################################

ksymoops 0.7c on i686 2.4.5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
May 27 04:06:08 homer kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
May 27 04:06:08 homer kernel: e0a7b3a7
May 27 04:06:08 homer kernel: *pde = 00000000
May 27 04:06:08 homer kernel: Oops: 0000
May 27 04:06:08 homer kernel: CPU:    0
May 27 04:06:08 homer kernel: EIP:    0010:[<e0a7b3a7>]
Using defaults from ksymoops -t elf32-i386 -a i386
May 27 04:06:08 homer kernel: EFLAGS: 00010096
May 27 04:06:08 homer kernel: eax: 00000041   ebx: 00000000   ecx: dd5bdc00   edx: 00000000
May 27 04:06:08 homer kernel: esi: 00000000   edi: 000000ff   ebp: dd5bdc00   esp: dd065cbc
May 27 04:06:08 homer kernel: ds: 0018   es: 0018   ss: 0018
May 27 04:06:08 homer kernel: Process modprobe (pid: 480, stackpage=dd065000)
May 27 04:06:08 homer kernel: Stack: 00000000 00000000 000000ff dd5bdc00 41000357 e0a7b79d dd5bdc00 00000000 
May 27 04:06:08 homer kernel:        ffffffff 00000041 ffffffff 000000ff 00000000 00000041 00000000 dd5bdc00 
May 27 04:06:08 homer kernel:        dd5bdc00 00000001 00000001 00000001 00000001 00000001 00000000 00000001 
May 27 04:06:08 homer kernel: Call Trace: [<e0a7b79d>] [<e0a7c226>] [<c0234ce3>] [<e0a7c81d>] [<e0a70990>] [<e0a812a9>] [<e0a7dca7>] 
May 27 04:06:08 homer kernel:        [<c0230000>] [<e0a6f93e>] [<e0a78855>] [<e0a6f891>] [<e0a6f8b0>] [<e0a85280>] [<c01d6fdc>] [<e0a85300>] 
May 27 04:06:08 homer kernel:        [<e0a85360>] [<c01d7054>] [<e0a85360>] [<e0a85280>] [<e0a7287a>] [<e0a6f74e>] [<e0a85280>] [<e0a6f068>] 
May 27 04:06:08 homer kernel:        [<c01bf7d9>] [<e0a85280>] [<e0a85280>] [<e0a6f068>] [<e0a6f000>] [<e0a6f068>] [<c01c003d>] [<e0a85280>] 
May 27 04:06:08 homer kernel:        [<e0a6f000>] [<e0a726d6>] [<e0a85280>] [<c011541d>] [<e0a68000>] [<e0a6f060>] [<c0106b9b>] 
May 27 04:06:08 homer kernel: Code: 8b 02 8b 7c 24 20 8b 6c 24 28 0f b6 40 19 f6 81 f0 00 00 00 

>>EIP; e0a7b3a7 <[aic7xxx]ahc_match_scb+17/c0>   <=====
Trace; e0a7b79d <[aic7xxx]ahc_search_qinfifo+14d/6b0>
Trace; e0a7c226 <[aic7xxx]ahc_abort_scbs+66/300>
Trace; c0234ce3 <__delay+13/30>
Trace; e0a7c81d <[aic7xxx]ahc_reset_channel+25d/370>
Trace; e0a70990 <[aic7xxx]ahc_linux_isr+0/270>
Trace; e0a812a9 <[aic7xxx].rodata.start+c89/157c>
Trace; e0a7dca7 <[aic7xxx]ahc_pci_config+497/4b0>
Trace; c0230000 <rpc_new_task+f0/170>
Trace; e0a6f93e <[aic7xxx]ahc_linux_initialize_scsi_bus+3e/1d0>
Trace; e0a78855 <[aic7xxx]ahc_set_name+15/30>
Trace; e0a6f891 <[aic7xxx]ahc_linux_register_host+111/150>
Trace; e0a6f8b0 <[aic7xxx]ahc_linux_register_host+130/150>
Trace; e0a85280 <[aic7xxx]driver_template+0/6c>
Trace; c01d6fdc <pci_announce_device+1c/50>
Trace; e0a85300 <[aic7xxx]ahc_linux_pci_id_table+0/60>
Trace; e0a85360 <[aic7xxx]aic7xxx_pci_driver+0/20>
Trace; c01d7054 <pci_register_driver+44/60>
Trace; e0a85360 <[aic7xxx]aic7xxx_pci_driver+0/20>
Trace; e0a85280 <[aic7xxx]driver_template+0/6c>
Trace; e0a7287a <[aic7xxx]ahc_linux_pci_probe+a/30>
Trace; e0a6f74e <[aic7xxx]ahc_linux_detect+5e/90>
Trace; e0a85280 <[aic7xxx]driver_template+0/6c>
Trace; e0a6f068 <[aic7xxx].text.start+8/a0>
Trace; c01bf7d9 <scsi_register_host+49/2d0>
Trace; e0a85280 <[aic7xxx]driver_template+0/6c>
Trace; e0a85280 <[aic7xxx]driver_template+0/6c>
Trace; e0a6f068 <[aic7xxx].text.start+8/a0>
Trace; e0a6f000 <[eepro100]__module_parm_multicast_filter_limit+3124/3184>
Trace; e0a6f068 <[aic7xxx].text.start+8/a0>
Trace; c01c003d <scsi_register_module+2d/60>
Trace; e0a85280 <[aic7xxx]driver_template+0/6c>
Trace; e0a6f000 <[eepro100]__module_parm_multicast_filter_limit+3124/3184>
Trace; e0a726d6 <[aic7xxx]init_this_scsi_driver+16/40>
Trace; e0a85280 <[aic7xxx]driver_template+0/6c>
Trace; c011541d <sys_init_module+4fd/5a0>
Trace; e0a68000 <[emu10k1].data.end+23f9/2459>
Trace; e0a6f060 <[aic7xxx]ahc_print_path+0/0>
Trace; c0106b9b <system_call+33/38>
Code;  e0a7b3a7 <[aic7xxx]ahc_match_scb+17/c0>
00000000 <_EIP>:
Code;  e0a7b3a7 <[aic7xxx]ahc_match_scb+17/c0>   <=====
   0:   8b 02                     mov    (%edx),%eax   <=====
Code;  e0a7b3a9 <[aic7xxx]ahc_match_scb+19/c0>
   2:   8b 7c 24 20               mov    0x20(%esp,1),%edi
Code;  e0a7b3ad <[aic7xxx]ahc_match_scb+1d/c0>
   6:   8b 6c 24 28               mov    0x28(%esp,1),%ebp
Code;  e0a7b3b1 <[aic7xxx]ahc_match_scb+21/c0>
   a:   0f b6 40 19               movzbl 0x19(%eax),%eax
Code;  e0a7b3b5 <[aic7xxx]ahc_match_scb+25/c0>
   e:   f6 81 f0 00 00 00 00      testb  $0x0,0xf0(%ecx)


2 warnings issued.  Results may not be reliable.


hope thats better now...

-Marc

-- 
+-O . . . o . . . O . . . o . . . O . . .  ___  . . . O . . . o .-+
| Ein neuer Service von Links2Linux.de:   /  o\   RPMs for SuSE   |
| --> PackMan! <-- naeheres unter        |   __|   and  others    |
| http://packman.links2linux.de/ . . . O  \__\  . . . O . . . O . |
