Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280740AbRKSVm6>; Mon, 19 Nov 2001 16:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280737AbRKSVmt>; Mon, 19 Nov 2001 16:42:49 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:4247 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S280728AbRKSVml>; Mon, 19 Nov 2001 16:42:41 -0500
Subject: oops with 2.2.20
Date: 19 Nov 2001 22:42:37 +0100
Organization: Chemnitz University of Technology
Message-ID: <87y9l2fnea.fsf@kosh.ultra.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
To: linux-kernel@vger.kernel.org
From: Enrico Scholz <enrico.scholz@informatik.tu-chemnitz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

while having high disk-load (e.g. making backup), I get following oops
regularly and the corresponding process (here 'tar') goes into 'D'
state.

It is a vanilla 2.2.20 kernel compiled with gcc version 2.95.2
19991024. Previous kernelversions were affected also.


| Nov 18 04:12:31 truhe kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000002
| Nov 18 04:12:31 truhe kernel: current->tss.cr3 = 01be1000, %cr3 = 01be1000
| Nov 18 04:12:31 truhe kernel: *pde = 00000000
| Nov 18 04:12:31 truhe kernel: Oops: 0000
| Nov 18 04:12:31 truhe kernel: CPU:    0
| Nov 18 04:12:31 truhe kernel: EIP:    0010:[find_buffer+106/140]
| Nov 18 04:12:31 truhe kernel: EFLAGS: 00010202
| Nov 18 04:12:31 truhe kernel: eax: 00000002   ebx: 00000004   ecx: 0000dc08   edx: 00000002
| Nov 18 04:12:31 truhe kernel: esi: 0000000a   edi: 00000805   ebp: 0005162a   esp: c0f45d9c
| Nov 18 04:12:31 truhe kernel: ds: 0018   es: 0018   ss: 0018
| Nov 18 04:12:31 truhe kernel: Process tar (pid: 6362, process nr: 44, stackpage=c0f45000)
| Nov 18 04:12:31 truhe kernel: Stack: 00000000 00000100 00000002 000a2c52 00000003 0000dc08 00000001 000515a5 
| Nov 18 04:12:32 truhe kernel:        00000400 c01270be 00000805 0005162a 00000400 c0f45ea4 c08e0720 c08e0720 
| Nov 18 04:12:32 truhe kernel:        0005162a c0127e99 c08e0720 00000805 0005162a c0127ee3 00000805 0005162a 
| Nov 18 04:12:32 truhe kernel: Call Trace: [get_hash_table+30/84] [brw_page+229/840] [brw_page+303/840] [ext2_bmap+112/140] [generic_readpage+140/156] [update_wall_time+18/72] [timer_bh+199/928] 
| Nov 18 04:12:32 truhe kernel:        [try_to_read_ahead+239/264] [try_to_read_ahead+47/264] [do_generic_file_read+660/1392] [generic_file_read+99/124] [file_read_actor+0/80] [sys_read+178/208] [system_call+52/64] 
| Nov 18 04:12:32 truhe kernel: Code: 8b 12 39 68 04 75 f3 8b 4c 24 38 39 48 08 75 ea 66 39 78 0c 


| Code;  00000000 Before first symbol
| 00000000 <_EIP>:
| Code;  00000000 Before first symbol
|    0:   8b 12                     mov    (%edx),%edx
| Code;  00000002 Before first symbol
|    2:   39 68 04                  cmp    %ebp,0x4(%eax)
| Code;  00000004 Before first symbol
|    5:   75 f3                     jne    fffffffa <_EIP+0xfffffffa> fffffffa <END_OF_CODE+3b76c03c/????>
| Code;  00000006 Before first symbol
|    7:   8b 4c 24 38               mov    0x38(%esp,1),%ecx
| Code;  0000000a Before first symbol
|    b:   39 48 08                  cmp    %ecx,0x8(%eax)
| Code;  0000000e Before first symbol
|    e:   75 ea                     jne    fffffffa <_EIP+0xfffffffa> fffffffa <END_OF_CODE+3b76c03c/????>
| Code;  00000010 Before first symbol
|   10:   66 39 78 0c               cmp    %di,0xc(%eax)


# lspci 
00:00.0 Host bridge: Intel Corporation 430HX - 82439HX TXC [Triton II] (rev 03)
00:03.0 Class ff00: Siemens Nixdorf AG Tulip controller, power management, switch extender (rev 01)
00:03.1 Class ff00: Siemens Nixdorf AG Tulip controller, power management, switch extender (rev 01)
00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
00:08.0 VGA compatible controller: Cirrus Logic GD 5436 [Alpine]
00:12.0 Ethernet controller: 3Com Corporation 3c595 100BaseTX [Vortex]
00:13.0 SCSI storage controller: Adaptec AIC-7881U

# cat /proc/scsi/scsi 
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DORS-32160       Rev: WA6A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: IBM      Model: DCAS-34330       Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: QUANTUM  Model: QM39100TD-S      Rev: N491
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: NEC      Model: CD-ROM DRIVE:462 Rev: 1.13
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: HP       Model: C1533A           Rev: 9503
  Type:   Sequential-Access                ANSI SCSI revision: 02






Enrico

