Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129234AbQKTQZK>; Mon, 20 Nov 2000 11:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129199AbQKTQZA>; Mon, 20 Nov 2000 11:25:00 -0500
Received: from chiara.elte.hu ([157.181.150.200]:41745 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S129234AbQKTQY6>;
	Mon, 20 Nov 2000 11:24:58 -0500
Date: Mon, 20 Nov 2000 16:54:55 +0100
From: KELEMEN Peter <fuji@elte.hu>
To: linux-kernel@vger.kernel.org
Subject: AIC-7xxx oops
Message-ID: <20001120165454.A15236@chiara.elte.hu>
Reply-To: KELEMEN Peter <fuji@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Organization: ELTE Eotvos Lorand University of Sciences, Budapest, Hungary
X-GPG-KeyID: 1024D/EE4C26E8 2000-03-20
X-GPG-Fingerprint: D402 4AF3 7488 165B CC34  4147 7F0C D922 EE4C 26E8
X-PGP-KeyID: 1024/45F83E45 1998/04/04
X-PGP-Fingerprint: 26 87 63 4B 07 28 1F AD  6D AA B5 8A D6 03 0F BF
X-Comment: Personal opinion.  Paragraphs might have been reformatted.
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Accept-Language: hu,en
X-Beat: @703
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I've been experiencing SCSI-related oopsen since 2.4.0-test6.
Couple of minutes ago I tried with test11 final, no luck still.
When I attempt to play an audio CD using cdplay from the cdtool
package, I'm rewarded with the following oops and cdplay
segfaults.

ksymoops 2.3.5 on i686 2.4.0-test11.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11/ (default)
     -m /boot/System.map-2.4.0-test11 (specified)

kernel BUG at /home/fuji/tmpX/linux/include/asm/pci.h:61!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c884e6a4>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 0000003a   ebx: 00000000   ecx: c01e2168   edx: c124cd00
esi: c70eca62   edi: c7a5fc10   ebp: c7a62000   esp: c6f0196c
ds: 0018   es: 0018   ss: 0018
Process cdplay (pid: 288, stackpage=c6f01000)
Stack: c88518ec c88519e0 0000003d c7a61000 c70eca00 c70eca00 c7d6f078 c70eca00
       c70ecb4c 04d6f078 c884e7e9 c7d6f078 c70eca00 c7a61000 00000246 c7a3b2f4
       c70eca00 c7d6f000 c8828659 c70eca00 c882dc40 c70eca00 c7a3b2f4 c70ecaac
Call Trace: [<c88518ec>] [<c88519e0>] [<c884e7e9>] [<c8828659>] [<c882dc40>] [<c882f33f>] [<c882e8fa>]
       [<c88288c3>] [<c882875a>] [<c8828088>] [<c886530c>] [<c88659cc>] [<c8866c00>] [<c8866c00>] [<c8866c00>]
       [<c885e806>] [<c8866c00>] [<c01224af>] [<c011f528>] [<c011f670>] [<c0110eeb>] [<c0110db4>] [<c0121c2d>]
       [<c0121f13>] [<c01209db>] [<c010a36c>] [<c01ac946>] [<c010a36c>] [<c01ac946>] [<c0141f1c>] [<c0142eda>]
       [<c01425e4>] [<c01c06ac>] [<c883955f>] [<c885a087>] [<c88523c0>] [<c883955f>] [<c885a087>] [<c88523c0>]
       [<c885a087>] [<c88523c0>] [<c883e48a>] [<c0128ef8>] [<c011f488>] [<c011f50a>] [<c011f670>] [<c0110eeb>]
       [<c0110db4>] [<c0127fed>] [<c012154c>] [<c012239c>] [<c0122447>] [<c012239c>] [<c011f528>] [<c011f670>]
       [<c0129147>] [<c012957b>] [<c012012e>] [<c01204f0>] [<c013349c>] [<c01398a7>] [<c010a24f>]
Code: 0f 0b 83 c4 0c 8d b4 26 00 00 00 00 8b 7c 24 24 8d 93 00 00

>>EIP; c884e6a4 <[aic7xxx]aic7xxx_buildscb+290/31c>   <=====
Trace; c88518ec <[aic7xxx].rodata.start+2c/5b27>
Trace; c88519e0 <[aic7xxx].rodata.start+120/5b27>
Trace; c884e7e9 <[aic7xxx]aic7xxx_queue+b9/148>
Trace; c8828659 <[scsi_mod]scsi_dispatch_cmd+19d/22c>
Trace; c882dc40 <[scsi_mod]scsi_old_done+0/588>
Trace; c882f33f <[scsi_mod]scsi_request_fn+2d3/308>
Trace; c882e8fa <[scsi_mod]scsi_insert_special_req+6a/78>
Trace; c88288c3 <[scsi_mod]scsi_do_req+133/158>
Trace; c882875a <[scsi_mod]scsi_wait_req+72/a8>
Trace; c8828088 <[scsi_mod]scsi_wait_done+0/20>
Trace; c886530c <[sr_mod]sr_do_ioctl+fc/2ac>
Trace; c88659cc <[sr_mod]sr_audio_ioctl+1bc/1dc>
Trace; c8866c00 <[sr_mod]sr_dops+0/40>
Trace; c8866c00 <[sr_mod]sr_dops+0/40>
Trace; c8866c00 <[sr_mod]sr_dops+0/40>
Trace; c885e806 <[cdrom]cdrom_ioctl+dc2/ddc>
Trace; c8866c00 <[sr_mod]sr_dops+0/40>
Trace; c01224af <filemap_nopage+113/37c>
Trace; c011f528 <do_no_page+50/b0>
Trace; c011f670 <handle_mm_fault+e8/154>
Trace; c0110eeb <do_page_fault+137/3dc>
Trace; c0110db4 <do_page_fault+0/3dc>
Trace; c0121c2d <do_generic_file_read+215/508>
Trace; c0121f13 <do_generic_file_read+4fb/508>
Trace; c01209db <merge_segments+1b/180>
Trace; c010a36c <error_code+34/3c>
Trace; c01ac946 <clear_user+2e/40>
Trace; c010a36c <error_code+34/3c>
Trace; c01ac946 <clear_user+2e/40>
Trace; c0141f1c <padzero+1c/20>
Trace; c0142eda <load_elf_binary+8f6/a38>
Trace; c01425e4 <load_elf_binary+0/a38>
Trace; c01c06ac <tvecs+6680/d454>
Trace; c883955f <[aic7xxx]unpause_sequencer+8f/b0>
Trace; c885a087 <[aic7xxx].bss.end+14a8/3481>
Trace; c88523c0 <[aic7xxx].rodata.start+b00/5b27>
Trace; c883955f <[aic7xxx]unpause_sequencer+8f/b0>
Trace; c885a087 <[aic7xxx].bss.end+14a8/3481>
Trace; c88523c0 <[aic7xxx].rodata.start+b00/5b27>
Trace; c885a087 <[aic7xxx].bss.end+14a8/3481>
Trace; c88523c0 <[aic7xxx].rodata.start+b00/5b27>
Trace; c883e48a <[aic7xxx]aic7xxx_run_waiting_queues+1e6/200>
Trace; c0128ef8 <__alloc_pages+e0/2d0>
Trace; c011f488 <do_anonymous_page+30/80>
Trace; c011f50a <do_no_page+32/b0>
Trace; c011f670 <handle_mm_fault+e8/154>
Trace; c0110eeb <do_page_fault+137/3dc>
Trace; c0110db4 <do_page_fault+0/3dc>
Trace; c0127fed <inactive_shortage+29/40>
Trace; c012154c <__find_get_page+34/74>
Trace; c012239c <filemap_nopage+0/37c>
Trace; c0122447 <filemap_nopage+ab/37c>
Trace; c012239c <filemap_nopage+0/37c>
Trace; c011f528 <do_no_page+50/b0>
Trace; c011f670 <handle_mm_fault+e8/154>
Trace; c0129147 <__free_pages+13/14>
Trace; c012957b <free_page_and_swap_cache+83/88>
Trace; c012012e <unmap_fixup+62/12c>
Trace; c01204f0 <do_munmap+274/284>
Trace; c013349c <blkdev_ioctl+28/34>
Trace; c01398a7 <sys_ioctl+16b/184>
Trace; c010a24f <system_call+33/38>
Code;  c884e6a4 <[aic7xxx]aic7xxx_buildscb+290/31c>
00000000 <_EIP>:
Code;  c884e6a4 <[aic7xxx]aic7xxx_buildscb+290/31c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c884e6a6 <[aic7xxx]aic7xxx_buildscb+292/31c>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c884e6a9 <[aic7xxx]aic7xxx_buildscb+295/31c>
   5:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c884e6b0 <[aic7xxx]aic7xxx_buildscb+29c/31c>
   c:   8b 7c 24 24               mov    0x24(%esp,1),%edi
Code;  c884e6b4 <[aic7xxx]aic7xxx_buildscb+2a0/31c>
  10:   8d 93 00 00 00 00         lea    0x0(%ebx),%edx

Couple of seconds later, the kernel emits the following messages:

scsi : aborting command due to timeout : pid 0, scsi0, channel 0, id 4, lun 0 0x48 00 00 00 01 01 00 07 63 00
(scsi0:-1:-1:-1) aic7xxx_isr - referenced scb not valid during scsiint 0x3 scb(0)
      SIMODE0 0x0, SIMODE1 0xad, SSTAT0 0x7, SEQADDR 0xa4
(scsi0:-1:-1:-1) aic7xxx_isr - referenced scb not valid during scsiint 0x3 scb(0)
      SIMODE0 0x0, SIMODE1 0xad, SSTAT0 0x7, SEQADDR 0x160
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 abort (pid 0) timed out - resetting
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 channel 0 reset (pid 0) timed out - trying harder
SCSI bus is being reset for host 0 channel 0.
SCSI host 0 reset (pid 0) timed out again -
probably an unrecoverable SCSI bus or device hang.

...and the device is not accessible any more.

(scsi0) <Adaptec AIC-7880 Ultra SCSI host adapter> found at PCI 0/14/0
(scsi0) Wide Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Downloading sequencer code... 422 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.2.1/5.2.0
       <Adaptec AIC-7880 Ultra SCSI host adapter>
(scsi0:0:4:0) Synchronous at 4.0 Mbyte/sec, offset 15.
  Vendor: PLEXTOR   Model: CD-ROM PX-4XCS    Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 4, lun 0
Uniform CD-ROM driver Revision: 3.11

The machine is available for trying patches if you send any.

TIA,
Peter

-- 
    .+'''+.         .+'''+.         .+'''+.         .+'''+.         .+''
 Kelemen Péter     /       \       /       \       /      fuji@elte.hu
.+'         `+...+'         `+...+'         `+...+'         `+...+'
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
