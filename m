Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264340AbRFUBIa>; Wed, 20 Jun 2001 21:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264345AbRFUBIU>; Wed, 20 Jun 2001 21:08:20 -0400
Received: from snowstorm.mail.pipex.net ([158.43.192.97]:22670 "HELO
	snowstorm.mail.pipex.net") by vger.kernel.org with SMTP
	id <S264340AbRFUBIE>; Wed, 20 Jun 2001 21:08:04 -0400
From: "Trevor Hemsley" <Trevor-Hemsley@dial.pipex.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 21 Jun 2001 02:08:17 +0000
Reply-To: "Trevor Hemsley" <Trevor-Hemsley@dial.pipex.com>
X-Mailer: PMMail 1.96a For OS/2
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: aic7xxx oops with 2.4.5-ac13
Message-Id: <20010621010814Z264340-17720+6179@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just upgraded from 2.4.3 to 2.4.5-ac13 and get an aiee, killing interrupt 
handler on boot as aic7xxx.o is loaded. I have an Adaptec 2906 PCI card 
with a Nikon CoolscanIII and an HP optical drive attached. Works ok on 
aic7xxx_old. Works with an initial bus reset on 2.4.3. Dies a horrible death 
on 2.4.5-ac13.

trevor@trevor4:/tmp > /sbin/lspci                                                  
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)  
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)    
00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)                   
00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)                
00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)               
00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)                      
00:09.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)                         
00:0a.0 SCSI storage controller: Initio Corporation 360P (rev 02)                  
00:0b.0 Network controller: Compaq Computer Corporation Netelligent 10/100 (rev 10)
00:0c.0 Ethernet controller: 3Com Corporation 3c900 Combo [Boomerang]              
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP (rev 01)     

On 2.4.3 I get the following errors when aic7xxx loads

ahc_pci:0:9:0: WARNING no command for scb 0 (cmdcmplt)         
QOUTPOS = 0                                                    
scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.1.5
        <Adaptec 2902/04/10/15/20/30C SCSI adapter>            
        aic7850: Single Channel A, SCSI Id=7, 3/255 SCBs       
                                                               
scsi1:0:2:0: Attempting to queue an ABORT message              
(scsi1:A:2:0): Queuing a recovery SCB                          
scsi1:0:2:0: Device is disconnected, re-queuing SCB            
Recovery code sleeping                                         
(scsi1:A:2:0): Abort Message Sent                              
(scsi1:A:2:0): SCB 3 - Abort Completed.                        
Recovery SCB completes                                         
Recovery code awake                                            
aic7xxx_abort returns 8194                                     

It then carries on and works.

Ksymoops output follows but may not be entirely reliable 
because it's from a hand written file and /proc/ksyms and /proc/modules are
from 2.4.3.
trevor@trevor4:/tmp > more decoded-245-ksymoops                                
ksymoops 2.4.0 on i686 2.4.3.  Options used                                    
     -V (default)                                                              
     -k /proc/ksyms (default)                                                  
     -l /proc/modules (default)                                                
     -o /lib/modules/2.4.5-ac13/ (specified)                                   
     -m /l243/System.map-2.4.5-ac13 (specified)                                
                                                                               
Unable to handle kernel NULL pointer dereference at virtual address 00000004   
c018d250                                                                       
*pde = 00000000                                                                
Oops: 0000                                                                     
CPU: 0                                                                         
EIP: 0010:[<c018d250>]                                                         
Using defaults from ksymoops -t elf32-i386 -a i386                             
EFLAGS: 00010057                                                               
eax: 00000000 ebx: 00000012 ecx: 00000001 edx: 00000000                        
esi: ffffffff edi: d74f0600 ebp: 00000000 esp: c0233dc0                        
ds: 0018 es: 0018 ss: 0018                                                     
Process swapper (pid 0, stackpage=c0233000)                                    
Stack: d9133058 00000000 00000000 00000012 00000000 d74f0600 00000000 414f0600 
       d74f0600 00000001 00000001 d91356ee d74f0600 d74f0690 00000000 00000000 
       00000003 d913e18f d74f0600 00000012 00000000 d74f0600 00000000 00000010 
Call Trace: [<d9133058>] [<d91356ee>] [<d913e18f>] [<d913e4fd>] [<d913e539>]   
 [<c0115b98>] [<c0110000>] [<d9136b89>] [<e6948262>] [<c019c9a2>] [<c011c635>] 
 [<d9132ad4>] [<c0108301>] [<c01084e6>] [<c0105160>] [<c0105160>] [<c010a82e>] 
 [<c0105160>] [<c0105160>] [<c0100018>] [<c010518d>] [<c01051f2>] [<c0105000>] 
 [<c01001cf>]                                                                  
Code: 8b 40 04 85 c0 74 15 3b 90 6c 00 00 00 75 07 80 88 fc 00 00              
                                                                               
>>EIP; c018d250 <scsi_report_bus_reset+8/28>   <=====                          
Trace; d9133058 <[serial].bss.end+18d5/18dd>                                   
Trace; d91356ee <[aic7xxx]ahc_filter_command+20a/2a4>                          
Trace; d913e18f <[aic7xxx]ahc_reset+37/470>                                    
Trace; d913e4fd <[aic7xxx]ahc_reset+3a5/470>                                   
Trace; d913e539 <[aic7xxx]ahc_reset+3e1/470>                                   
Trace; c0115b98 <release_console_sem+94/98>                                    
Trace; c0110000 <mtrr_close+34/c8>                                             
Trace; d9136b89 <[aic7xxx]ahc_pci_map_registers+1c5/254>                       
Trace; e6948262 <END_OF_CODE+d78b186/????>                                     
Trace; c019c9a2 <cursor_timer_handler+22/28>                                   
Trace; c011c635 <timer_bh+259/2b0>                                             
Trace; d9132ad4 <[serial].bss.end+1351/18dd>                                   
Trace; c0108301 <handle_IRQ_event+4d/78>                                       
Trace; c01084e6 <do_IRQ+a6/f4>                                                 
Trace; c0105160 <default_idle+0/34>                                            
Trace; c0105160 <default_idle+0/34>                                            
Trace; c010a82e <call_do_IRQ+5/b>                                              
Trace; c0105160 <default_idle+0/34>                                            
Trace; c0105160 <default_idle+0/34>                                                           
Trace; c0100018 <startup_32+18/cb>                                                            
Trace; c010518d <default_idle+2d/34>                                                          
Trace; c01051f2 <cpu_idle+3e/54>                                                              
Trace; c0105000 <prepare_namespace+0/8>                                                       
Trace; c01001cf <L6+0/2>                                                                      
Code;  c018d250 <scsi_report_bus_reset+8/28>                                                  
00000000 <_EIP>:                                                                              
Code;  c018d250 <scsi_report_bus_reset+8/28>   <=====                                         
   0:   8b 40 04                  mov    0x4(%eax),%eax   <=====                              
Code;  c018d253 <scsi_report_bus_reset+b/28>                                                  
   3:   85 c0                     test   %eax,%eax                                            
Code;  c018d255 <scsi_report_bus_reset+d/28>                                                  
   5:   74 15                     je     1c <_EIP+0x1c> c018d26c <scsi_report_bus_reset+24/28>
Code;  c018d257 <scsi_report_bus_reset+f/28>                                                  
   7:   3b 90 6c 00 00 00         cmp    0x6c(%eax),%edx                                      
Code;  c018d25d <scsi_report_bus_reset+15/28>                                                 
   d:   75 07                     jne    16 <_EIP+0x16> c018d266 <scsi_report_bus_reset+1e/28>
Code;  c018d25f <scsi_report_bus_reset+17/28>                                                 
   f:   80 88 fc 00 00 00 00      orb    $0x0,0xfc(%eax)                                      
                                                                                              
 <0> Kernel panic: Aiee, killing interrupt handler!                                           
                                                                                              
1070 warnings issued.  Results may not be reliable.                                           


Trevor Hemsley, Brighton, UK.
Trevor-Hemsley@dial.pipex.com

