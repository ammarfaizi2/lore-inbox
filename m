Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274368AbRJUKyx>; Sun, 21 Oct 2001 06:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275822AbRJUKyn>; Sun, 21 Oct 2001 06:54:43 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:3599 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S274368AbRJUKy3>; Sun, 21 Oct 2001 06:54:29 -0400
Date: Sun, 21 Oct 2001 13:54:55 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10ac10, cdrecord 1.9-6, Mitsumi CR-4804TE: lock up burning too large image
Message-ID: <20011021135455.C1598@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When (accidentally) trying to burn ~670MB onto a 74" cdr disk, I experienced
a complete lock up.
                                                                                
It went to 99% (as one would expect), and then drive began giving weird
sounds - as if it was moving the head from start to end over and over. After
a short while, the whole system locked up, no mouse, keyboard, caps lock,
ctrl-alt-del, alt-sysrq-{s,u,b}.
                                                                                
It used to give a nice error when disk size was exceeded with 2.2.18pre19
and a tad older cdrecord (1.9-something (1.10-4 failed on 2.2 BTW, giving
error on mmapping /dev/null)).
                                                                                
I assume this is a kernel thing...
                                                                                
BTW: Also the cd audio ripping speed has dropped from ~8x to ~1x with both
my cdrw and cd drive. The drop took place before upgrading from 2.2 to 2.4. 
I am and was using scsi-emulation for both drives. I tried going back to
older cdparanoia, but it didn't help. Before I try to binary search what has
changed, does anybody have any ideas on what to try?
                                                                                
------------------------------------------------------------------------        
kernel 2.4.10-ac10 SMP                                                          
cdrecord 1.9-6                                                                  
                                                                                
dmesg:                                                                          
scsi : 0 hosts left.                                                            
SCSI subsystem driver Revision: 1.00                                            
scsi0 : SCSI host adapter emulation for IDE ATAPI devices                       
  Vendor: MITSUMI   Model: CR-4804TE         Rev: 2.4C                          
  Type:   CD-ROM                             ANSI SCSI revision: 02             
APIC error on CPU0: 08(02)                                                      
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0                       
sr0: scsi3-mmc drive: 32x/32x cd/rw xa/form2 cdda tray                          
Uniform CD-ROM driver Revision: 3.12                                            
sr1: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray                   
                                                                                
hdparm /dev/hdd:
                                                                                
/dev/hdd:                                                                       
 HDIO_GET_MULTCOUNT failed: Input/output error                                  
 I/O support  =  0 (default 16-bit)                                             
 unmaskirq    =  0 (off)                                                        
 using_dma    =  1 (on)                                                         
 keepsettings =  0 (off)                                                        
 HDIO_GET_NOWERR failed: Input/output error                                     
 readonly     =  0 (off)                                                        
 BLKRAGET failed: Input/output error                                            
 HDIO_GETGEO failed: Invalid argument                                           
                                                                                
cdrecord -scanbus:                                                              
        0,1,0     1) 'MITSUMI ' 'CR-4804TE       ' '2.4C' Removable CD-ROM      
                                                                                
                                                                                
kernel messages before the lockup:
                                                                                
Oct 20 20:35:53 kernel: scsi : aborting command due to timeout : pid 155966,    
@+scsi0, channel 0, id 1, lun 0 0x2a 00 00 05 48 9e 00 00 1f 00                 
Oct 20 20:35:53 kernel: hdd: timeout waiting for DMA                            
Oct 20 20:35:53 kernel: ide_dmaproc: chipset supported ide_dma_timeout func     
@+only: 14                                                                      
Oct 20 20:35:54 kernel: hdd: status timeout: status=0xd0 { Busy }               
Oct 20 20:35:54 kernel: hdd: drive not ready for command                        
Oct 20 20:36:28 kernel: hdd: ATAPI reset timed-out, status=0xd0                 
<halted at this point>                                                          


-- v --

v@iki.fi
