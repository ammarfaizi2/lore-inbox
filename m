Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264706AbTAJJg0>; Fri, 10 Jan 2003 04:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbTAJJg0>; Fri, 10 Jan 2003 04:36:26 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:37832 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id <S264706AbTAJJgW>; Fri, 10 Jan 2003 04:36:22 -0500
Date: Fri, 10 Jan 2003 10:45:04 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre3-ac2
Message-ID: <20030110094504.GM25979@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200301090139.h091d9G26412@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301090139.h091d9G26412@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@redhat.com>:
> The skb_padto bug is quite ugly so people really want to be using ac2 not
> ac1. 

I got an oops with that kernel on two different machines:

ksymoops 2.4.8 on i686 2.4.21-pre3-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre3-ac2/ (default)
     -m /boot/System.map-2.4.21-pre3-ac2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x330-0x337 0x378-0x37f 0x388-0x38f 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
ad1848: No ISAPnP cards found, trying standard ones...
Unable to handle kernel NULL pointer dereference at virtual address 00000004
c0132d7d
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0132d7d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c117b874   ecx: c7cc8000   edx: c7cc805c
esi: 00000000   edi: 00000000   ebp: c0271030   esp: c7cc9e40
ds: 0018   es: 0018   ss: 0018
Process apt-get (pid: 1352, stackpage=c7cc9000)
Stack: 00000001 00000286 c898f420 c898f420 c898f420 c117b874 c013e66e c898f420 
       c88b2e68 c117b874 000011d1 c0271030 c0131f0f c117b874 000001d2 c7cc8000 
       000001c8 000001d2 00000020 00000020 000001d2 00000020 00000006 c0132153 
Call Trace:    [<c013e66e>] [<c0131f0f>] [<c0132153>] [<c01321c6>] [<c0133067>]
  [<c01332f3>] [<c012dd70>] [<c015f5d9>] [<c013a173>] [<c0107307>]
Code: 89 58 04 89 03 89 53 04 89 59 5c 89 73 0c ff 41 68 eb bf 0f 


>>EIP; c0132d7d <__free_pages_ok+27d/2a0>   <=====

>>ebx; c117b874 <_end+e88fbc/c9937a8>
>>ecx; c7cc8000 <_end+79d5748/c9937a8>
>>edx; c7cc805c <_end+79d57a4/c9937a8>
>>ebp; c0271030 <contig_page_data+b0/340>
>>esp; c7cc9e40 <_end+79d7588/c9937a8>

Trace; c013e66e <try_to_free_buffers+8e/100>
Trace; c0131f0f <shrink_cache+21f/310>
Trace; c0132153 <shrink_caches+63/a0>
Trace; c01321c6 <try_to_free_pages_zone+36/50>
Trace; c0133067 <balance_classzone+57/1f0>
Trace; c01332f3 <__alloc_pages+f3/190>
Trace; c012dd70 <generic_file_write+370/760>
Trace; c015f5d9 <ext3_file_write+39/d0>
Trace; c013a173 <sys_write+a3/140>
Trace; c0107307 <system_call+33/38>

Code;  c0132d7d <__free_pages_ok+27d/2a0>
00000000 <_EIP>:
Code;  c0132d7d <__free_pages_ok+27d/2a0>   <=====
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=====
Code;  c0132d80 <__free_pages_ok+280/2a0>
   3:   89 03                     mov    %eax,(%ebx)
Code;  c0132d82 <__free_pages_ok+282/2a0>
   5:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  c0132d85 <__free_pages_ok+285/2a0>
   8:   89 59 5c                  mov    %ebx,0x5c(%ecx)
Code;  c0132d88 <__free_pages_ok+288/2a0>
   b:   89 73 0c                  mov    %esi,0xc(%ebx)
Code;  c0132d8b <__free_pages_ok+28b/2a0>
   e:   ff 41 68                  incl   0x68(%ecx)
Code;  c0132d8e <__free_pages_ok+28e/2a0>
  11:   eb bf                     jmp    ffffffd2 <_EIP+0xffffffd2>
Code;  c0132d90 <__free_pages_ok+290/2a0>
  13:   0f 00 00                  sldtl  (%eax)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
c0132d7d
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c0132d7d>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: c10cc138   ecx: c7cc8000   edx: c7cc805c
esi: 00000000   edi: 00000000   ebp: 00000000   esp: c7cc9c64
ds: 0018   es: 0018   ss: 0018
Process apt-get (pid: 1352, stackpage=c7cc9000)
Stack: 0000002f 00000082 00000082 c02d93b4 00000020 00000000 c01911b3 c02d93b4 
       00000000 c9ed51a8 00004000 00000001 c0129027 c10cc138 00000000 00000001 
       cbf7ef00 c10cc138 08400000 c436a084 0806e000 00000000 c012787b cb0887a0 
Call Trace:    [<c01911b3>] [<c0129027>] [<c012787b>] [<c012a769>] [<c01171b7>]
  [<c011c09f>] [<c0107992>] [<c0114ad4>] [<c01643d2>] [<c016b21b>] [<c016a896>]
  [<c016b21b>] [<c016a896>] [<c0114830>] [<c01073f8>] [<c0132d7d>] [<c013e66e>]
  [<c0131f0f>] [<c0132153>] [<c01321c6>] [<c0133067>] [<c01332f3>] [<c012dd70>]
  [<c015f5d9>] [<c013a173>] [<c0107307>]
Code: 89 58 04 89 03 89 53 04 89 59 5c 89 73 0c ff 41 68 eb bf 0f 


>>EIP; c0132d7d <__free_pages_ok+27d/2a0>   <=====

>>ebx; c10cc138 <_end+dd9880/c9937a8>
>>ecx; c7cc8000 <_end+79d5748/c9937a8>
>>edx; c7cc805c <_end+79d57a4/c9937a8>
>>esp; c7cc9c64 <_end+79d73ac/c9937a8>

Trace; c01911b3 <poke_blanked_console+53/70>
Trace; c0129027 <zap_pte_range+f7/120>
Trace; c012787b <zap_page_range+8b/f0>
Trace; c012a769 <exit_mmap+b9/160>
Trace; c01171b7 <mmput+47/a0>
Trace; c011c09f <do_exit+8f/240>
Trace; c0107992 <die+72/80>
Trace; c0114ad4 <do_page_fault+2a4/4cf>
Trace; c01643d2 <ext3_mark_iloc_dirty+42/70>
Trace; c016b21b <journal_dirty_metadata+17b/210>
Trace; c016a896 <do_get_write_access+296/520>
Trace; c016b21b <journal_dirty_metadata+17b/210>
Trace; c016a896 <do_get_write_access+296/520>
Trace; c0114830 <do_page_fault+0/4cf>
Trace; c01073f8 <error_code+34/3c>
Trace; c0132d7d <__free_pages_ok+27d/2a0>
Trace; c013e66e <try_to_free_buffers+8e/100>
Trace; c0131f0f <shrink_cache+21f/310>
Trace; c0132153 <shrink_caches+63/a0>
Trace; c01321c6 <try_to_free_pages_zone+36/50>
Trace; c0133067 <balance_classzone+57/1f0>
Trace; c01332f3 <__alloc_pages+f3/190>
Trace; c012dd70 <generic_file_write+370/760>
Trace; c015f5d9 <ext3_file_write+39/d0>
Trace; c013a173 <sys_write+a3/140>
Trace; c0107307 <system_call+33/38>

Code;  c0132d7d <__free_pages_ok+27d/2a0>
00000000 <_EIP>:
Code;  c0132d7d <__free_pages_ok+27d/2a0>   <=====
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=====
Code;  c0132d80 <__free_pages_ok+280/2a0>
   3:   89 03                     mov    %eax,(%ebx)
Code;  c0132d82 <__free_pages_ok+282/2a0>
   5:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  c0132d85 <__free_pages_ok+285/2a0>
   8:   89 59 5c                  mov    %ebx,0x5c(%ecx)
Code;  c0132d88 <__free_pages_ok+288/2a0>
   b:   89 73 0c                  mov    %esi,0xc(%ebx)
Code;  c0132d8b <__free_pages_ok+28b/2a0>
   e:   ff 41 68                  incl   0x68(%ecx)
Code;  c0132d8e <__free_pages_ok+28e/2a0>
  11:   eb bf                     jmp    ffffffd2 <_EIP+0xffffffd2>
Code;  c0132d90 <__free_pages_ok+290/2a0>
  13:   0f 00 00                  sldtl  (%eax)


1 warning issued.  Results may not be reliable.

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite Campus Mitte                            Tel.  +49 (0)30-450 570-155
Referat V a - Kommunikationsnetze -             Fax.  +49 (0)30-450 570-916
Why you can't find your system administrators:
(S)he's catching twenty winks under the floorboards, tread gingerly. 

