Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130372AbQK0Eui>; Sun, 26 Nov 2000 23:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131542AbQK0Eu2>; Sun, 26 Nov 2000 23:50:28 -0500
Received: from ha1.rdc2.mi.home.com ([24.2.68.68]:63446 "EHLO
        mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
        id <S130372AbQK0EuN>; Sun, 26 Nov 2000 23:50:13 -0500
Message-ID: <3A21E07C.C3A9880E@didntduck.org>
Date: Sun, 26 Nov 2000 23:18:04 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: CDROMPLAYTRKIND causes an oops on aic7xxx
Content-Type: multipart/mixed;
 boundary="------------D7440C7314E8D01A3CEDDD86"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------D7440C7314E8D01A3CEDDD86
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I get an oops from aic7xxx_buildscb() when CDROMPLAYTRKIND is used. 
I've tracked it down to sr_audio_ioctl() using SCSI_DATA_NONE for the
direction of the command, which gets changed to PCI_DMA_NONE, which then
triggers a BUG() in pci_map_single().  Is SCSI_DATA_NONE the correct
direction code, or is there a problem further down the code?  Oops
attached.

-- 

						Brian Gerst
--------------D7440C7314E8D01A3CEDDD86
Content-Type: text/plain; charset=us-ascii;
 name="oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops"

ksymoops 2.3.4 on i686 2.4.0-test11-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11-ac2/ (default)
     -m /boot/System.map-2.4.0-test11-ac2 (specified)

invalid operand: 0000
CPU:    0
EIP:    0010:[<c01bb654>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210086
eax: 00000030   ebx: 00000000   ecx: 00000000   edx: 00000008
esi: c14fee62   edi: c14fee00   ebp: cff2c000   esp: ca667960
ds: 0018   es: 0018   ss: 0018
Process heretic2 (pid: 859, stackpage=ca667000)
Stack: c02502c2 c025035f 0000003d cff2e800 c14fee00 cff2c000 c147b878 00000001 
       00000200 c1470002 c147b8d8 c01bb79c c147b878 c14fee00 cff2e800 00200246 
       cf59cdd4 c147b800 c14fee00 c019afa0 c019b006 c14fee00 c019fba0 c14fee00 
Call Trace: [<c02502c2>] [<c025035f>] [<c01bb79c>] [<c019afa0>] [<c019b006>] [<c019fba0>] [<c01a141c>] 
       [<c01a089a>] [<c019b1c2>] [<c019b0c2>] [<c019ab90>] [<c01c1e2c>] [<c01c25c6>] [<c01c9ede>] [<c0120f40>] 
       [<c0111320>] [<c0111320>] [<c012239b>] [<c0196708>] [<c01908c4>] [<c0196708>] [<c01908c4>] [<c0196708>] 
       [<c0196050>] [<c0196550>] [<c019ab30>] [<c019ab4e>] [<c01908c4>] [<c0196708>] [<c0196050>] [<c0196550>] 
       [<c019ab30>] [<c019ab4e>] [<c0195128>] [<c019ab30>] [<c01919e0>] [<c0191a39>] [<c017fad9>] [<c0120dc0>] 
       [<c0120f40>] [<c0111320>] [<c0121849>] [<c0171714>] [<c017e9f9>] [<c011212c>] [<c011223a>] [<c0112292>] 
       [<c011b260>] [<c011254d>] [<c011b2a0>] [<c011ecec>] [<c010f016>] [<c011befb>] [<c01363b6>] [<c013cb56>] 
       [<c0136390>] [<c010ae37>] 
Code: 0f 0b 83 c4 0c 8d b4 26 00 00 00 00 8d 93 00 00 00 40 8b 4c 

>>EIP; c01bb654 <aic7xxx_buildscb+304/390>   <=====
Trace; c02502c2 <RCSid+1502/7fc8>
Trace; c025035f <RCSid+159f/7fc8>
Trace; c01bb79c <aic7xxx_queue+bc/150>
Trace; c019afa0 <scsi_dispatch_cmd+a0/150>
Trace; c019b006 <scsi_dispatch_cmd+106/150>
Trace; c019fba0 <scsi_old_done+0/5b0>
Trace; c01a141c <scsi_request_fn+34c/370>
Trace; c01a089a <scsi_insert_special_req+6a/80>
Trace; c019b1c2 <scsi_do_req+c2/d0>
Trace; c019b0c2 <scsi_wait_req+72/b0>
Trace; c019ab90 <scsi_wait_done+0/20>
Trace; c01c1e2c <sr_do_ioctl+14c/360>
Trace; c01c25c6 <sr_audio_ioctl+206/230>
Trace; c01c9ede <cdrom_ioctl+e9e/ec0>
Trace; c0120f40 <handle_mm_fault+f0/170>
Trace; c0111320 <do_page_fault+0/410>
Trace; c0111320 <do_page_fault+0/410>
Trace; c012239b <merge_segments+1b/180>
Trace; c0196708 <ide_dmaproc+148/240>
Trace; c01908c4 <ide_set_handler+54/60>
Trace; c0196708 <ide_dmaproc+148/240>
Trace; c01908c4 <ide_set_handler+54/60>
Trace; c0196708 <ide_dmaproc+148/240>
Trace; c0196050 <ide_dma_intr+0/a0>
Trace; c0196550 <dma_timer_expiry+0/70>
Trace; c019ab30 <via82cxxx_dmaproc+0/30>
Trace; c019ab4e <via82cxxx_dmaproc+1e/30>
Trace; c01908c4 <ide_set_handler+54/60>
Trace; c0196708 <ide_dmaproc+148/240>
Trace; c0196050 <ide_dma_intr+0/a0>
Trace; c0196550 <dma_timer_expiry+0/70>
Trace; c019ab30 <via82cxxx_dmaproc+0/30>
Trace; c019ab4e <via82cxxx_dmaproc+1e/30>
Trace; c0195128 <do_rw_disk+138/3b0>
Trace; c019ab30 <via82cxxx_dmaproc+0/30>
Trace; c01919e0 <start_request+160/230>
Trace; c0191a39 <start_request+1b9/230>
Trace; c017fad9 <n_tty_receive_buf+ca9/ce0>
Trace; c0120dc0 <do_no_page+30/c0>
Trace; c0120f40 <handle_mm_fault+f0/170>
Trace; c0111320 <do_page_fault+0/410>
Trace; c0121849 <avl_remove+c9/e0>
Trace; c0171714 <pty_write+114/120>
Trace; c017e9f9 <opost_block+189/1a0>
Trace; c011212c <send_signal+2c/f0>
Trace; c011223a <deliver_signal+4a/50>
Trace; c0112292 <send_sig_info+52/a0>
Trace; c011b260 <it_real_fn+0/50>
Trace; c011254d <send_sig+1d/30>
Trace; c011b2a0 <it_real_fn+40/50>
Trace; c011ecec <timer_bh+21c/260>
Trace; c010f016 <timer_interrupt+76/130>
Trace; c011befb <bh_action+1b/70>
Trace; c01363b6 <blkdev_ioctl+26/40>
Trace; c013cb56 <sys_ioctl+176/190>
Trace; c0136390 <blkdev_ioctl+0/40>
Trace; c010ae37 <system_call+33/38>
Code;  c01bb654 <aic7xxx_buildscb+304/390>
00000000 <_EIP>:
Code;  c01bb654 <aic7xxx_buildscb+304/390>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01bb656 <aic7xxx_buildscb+306/390>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c01bb659 <aic7xxx_buildscb+309/390>
   5:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c01bb660 <aic7xxx_buildscb+310/390>
   c:   8d 93 00 00 00 40         lea    0x40000000(%ebx),%edx
Code;  c01bb666 <aic7xxx_buildscb+316/390>
  12:   8b 4c 00 00               mov    0x0(%eax,%eax,1),%ecx


--------------D7440C7314E8D01A3CEDDD86--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
