Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSECOeR>; Fri, 3 May 2002 10:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313715AbSECOeQ>; Fri, 3 May 2002 10:34:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:9748 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S313578AbSECOeM>;
	Fri, 3 May 2002 10:34:12 -0400
Date: Fri, 3 May 2002 16:32:48 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Jens Axboe <axboe@suse.de>
Cc: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH] IDE TCQ #2
Message-Id: <20020503163248.633c8358.sebastian.droege@gmx.de>
In-Reply-To: <20020503110652.GF839@suse.de>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.,Ijn0H.AcHzK9s"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.,Ijn0H.AcHzK9s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 May 2002 13:06:52 +0200
Jens Axboe <axboe@suse.de> wrote:

> Hi,
> 
> 2.5.13 now has the generic tag support that I wrote included, here's an
> IDE TCQ that uses that. Changes since the version posted for 2.5.12:
> 
> - Fix the ide_tcq_invalidate_queue() WIN_NOP usage needed to clear the
>   internal queue on errors. It was disabled in the last version due to
>   the ata_request changes, it should work now.
> 
> - Remove Promise tcq disable check, it works just fine on Promise as
>   long as we handle the two-drives-with-tcq case like we currently do.

Hi,
I get following oops after a while... it's not really reproducable but happens a few minutes after bootup
With TCQ disabled the kernel is rock-solid ;)
I only use TCQ on one harddisk (hda)... hdb doesn't support it.
The IDE controller is an Intel Corp. 82371AB PIIX4 IDE (rev 01)
hda is a IBM-DTTA-351010

Bye

ide_tcq_intr_timeout: timeout waiting for interrupt...
ide_tcq_intr_timeout: hwgroup not busy
hda: invalidating pending queue (10)
kernel BUG at ll_rw_blk.c:407!
CPU: 0
EIP: 0010:[<c0106b9f>] Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: cff40f28 ebx: ffffffff ecx: cff40960 edx: c13d90e0
esi: c13dacc0 edi: cff40f20 ebp: c038dea4 esp: c032debc
ds: 0018 es: 0018 ss: 0018
Stack: cff55760 c038dea4 c038de94 c038de90 cff40f20 c01f3b96 c038dea4 c023c000
        c038de90 00000282 cff55760 00000296 c01f3d34 c038de90 c038de90 c01f3c8c
        c032c000 c036bcc0 c011a5c7 c038de90 c032c000 00000000 00000000 c036bcc0
Call Trace: [<c01f3b96>] [<c01f3d34>] [<c01f3c8c>] [<c011d5c7>] [<c011d2f0>]
        [<c011a13e>] [<c011a586>] [<c011a0b1>] [<c0108bef>] [<c010704e>] [<c01bb8e1>]
        [<c01bb7f8>] [<c0105954>] [<c01059b3>] [<c0105000>] [<c010503d>]
Code: 0f 0b 97 01 ea 09 2d c0 3b 5f 14 7d 53 8b 57 04 0f b3 1a 19


>>EIP; c0106b9f <do_signal+97/290>   <=====

>>eax; cff40f28 <END_OF_CODE+fbabb8c/????>
>>ebx; ffffffff <END_OF_CODE+3fc6ac63/????>
>>ecx; cff40960 <END_OF_CODE+fbab5c4/????>
>>edx; c13d90e0 <END_OF_CODE+1043d44/????>
>>esi; c13dacc0 <END_OF_CODE+1045924/????>
>>edi; cff40f20 <END_OF_CODE+fbabb84/????>
>>ebp; c038dea4 <ide_hwifs+104/39d0>
>>esp; c032debc <init_thread_union+1ebc/2000>

Trace; c01f3b96 <ide_tcq_invalidate_queue+86/17c>
Trace; c01f3d34 <ide_tcq_intr_timeout+a8/b0>
Trace; c01f3c8c <ide_tcq_intr_timeout+0/b0>
Trace; c011d5c7 <timer_bh+27b/2d0>
Trace; c011d2f0 <update_process_times+d4/dc>
Trace; c011a13e <bh_action+26/70>
Trace; c011a586 <tasklet_hi_action+4a/74>
Trace; c011a0b1 <do_softirq+61/c8>
Trace; c0108bef <do_IRQ+137/144>
Trace; c010704e <common_interrupt+22/28>
Trace; c01bb8e1 <acpi_processor_idle+e9/210>
Trace; c01bb7f8 <acpi_processor_idle+0/210>
Trace; c0105954 <default_idle+0/28>
Trace; c01059b3 <cpu_idle+37/48>
Trace; c0105000 <_stext+0/0>
Trace; c010503d <rest_init+3d/50>

Code;  c0106b9f <do_signal+97/290>
00000000 <_EIP>:
Code;  c0106b9f <do_signal+97/290>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0106ba1 <do_signal+99/290>
   2:   97                        xchg   %eax,%edi
Code;  c0106ba2 <do_signal+9a/290>
   3:   01 ea                     add    %ebp,%edx
Code;  c0106ba4 <do_signal+9c/290>
   5:   09 2d c0 3b 5f 14         or     %ebp,0x145f3bc0
Code;  c0106baa <do_signal+a2/290>
   b:   7d 53                     jge    60 <_EIP+0x60> c0106bff <do_signal+f7/290>
Code;  c0106bac <do_signal+a4/290>
   d:   8b 57 04                  mov    0x4(%edi),%edx
Code;  c0106baf <do_signal+a7/290>
  10:   0f b3 1a                  btr    %ebx,(%edx)
Code;  c0106bb2 <do_signal+aa/290>
  13:   19 00                     sbb    %eax,(%eax)

<0> Kernel panic: Aiee, killing interrupt handler!
--=.,Ijn0H.AcHzK9s
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE80p+Te9FFpVVDScsRAqOJAKCZ1grmfZe1rjyabITtc4Ftzs3V7ACgyp/u
PyL6OKwyudPzu43+5eTPJ6M=
=nAG1
-----END PGP SIGNATURE-----

--=.,Ijn0H.AcHzK9s--

