Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRALLu5>; Fri, 12 Jan 2001 06:50:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbRALLus>; Fri, 12 Jan 2001 06:50:48 -0500
Received: from mail.lin-gen.com ([195.64.80.162]:24193 "EHLO server")
	by vger.kernel.org with ESMTP id <S129183AbRALLug>;
	Fri, 12 Jan 2001 06:50:36 -0500
Date: Fri, 12 Jan 2001 12:50:10 +0100
To: Hans Grobler <grobh@sun.ac.za>
Cc: linux-kernel@vger.kernel.org
Subject: PRoblem with pcnet32 under 2.4.0 , was :Drivers under 2.4
Message-ID: <20010112125010.A6371@lin-gen.com>
Reply-To: dth@lin-gen.com
In-Reply-To: <93kn8a$itt$1@voyager.cistron.net> <Pine.LNX.4.30.0101111836460.30013-100000@prime.sun.ac.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.30.0101111836460.30013-100000@prime.sun.ac.za>; from grobh@sun.ac.za on Thu, Jan 11, 2001 at 06:44:48PM +0200
X-NCC-RegID: com.lin-gen
From: Danny ter Haar <dth@lin-gen.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Hans Grobler:
> If you're willing, would you please follow "REPORTING-BUGS" and send some
> more info. Also cat /proc/interrupts. This one's intriging...


In short:

Cyrix Multimedia box
Everything onboard, including ethernet.
Works as supposed to under 2.2.x (including 2.2.19pre7)
installing 2.4.0 kernel recognises the driver but
no byte is passed over the ethernet.

Kernel:
Linux version 2.4.0-ac7 (root@multimedia) (gcc version 2.95.3 20001229 (prerelea
se)) #2 Fri Jan 12 11:17:47 CET 2001 

Distribution: 
Debian unstable (sid)


Output of loading the pcnet32 module:

pcnet32_probe_pci: found device 0x001022.0x002000                               
    ioaddr=0x00fce0  resource_flags=0x000101                                    
PCI: Found IRQ 9 for device 00:0f.0                                             
eth0: PCnet/FAST III 79C973 at 0xfce0, 00 00 e2 24 41 1d                        
pcnet32: pcnet32_private lp=c3c42000 lp_dma_addr=0x3c42000 assigned IRQ 9.      
pcnet32.c:v1.25kf 26.9.1999 tsbogend@alpha.franken.de             

lspci -vx output:

00:0f.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet LANCE] (
rev 42)                                                                         
        Subsystem: Advanced Micro Devices [AMD]: Unknown device 2000            
        Flags: bus master, medium devsel, latency 64, IRQ 9                     
        I/O ports at fce0 [size=32]                                             
        Memory at fedffc00 (32-bit, non-prefetchable) [size=32]                 
        Expansion ROM at <unassigned> [disabled] [size=1M]                      
        Capabilities: [40] Power Management version 1                           
00: 22 10 00 20 07 00 90 02 42 00 00 02 00 40 00 00                             
10: e1 fc 00 00 00 fc df fe 00 00 00 00 00 00 00 00                             
20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 00 20                             
30: 00 00 00 00 40 00 00 00 00 00 00 00 09 01 18 18         

The machine is connected to a 3com 8ports 100Mbit hub 

no additional parameters when the module is loaded, except i tried
debug=7 which gave verbose output 

After bootup this is the situation:

multimedia:~# ifconfig                                                          
eth0      Link encap:Ethernet  HWaddr 00:00:E2:24:41:1D                         
          inet addr:192.168.1.51  Bcast:192.168.1.255  Mask:255.255.255.0       
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1                    
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0                    
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0                  
          collisions:0 txqueuelen:100                                           
          Interrupt:9 Base address:0xfce0          

procinfo:

multimedia:~# procinfo                                                          
Linux 2.4.0-ac7 (root@multimedia) (gcc 2.95.3 20001229 ) #2 Fri Jan 12 11:17:47 
CET 2001 1CPU [multimedia.(none)]                                               
                                                                                
Memory:      Total        Used        Free      Shared     Buffers      Cached  
Mem:         62308       12596       49712           0         636        6636  
Swap:       184708           0      184708                                      
                                                                                
Bootup: Fri Jan 12 12:30:22 2001    Load average: 0.02 0.03 0.01 1/28 229       
                                                                                
user  :       0:00:05.32   3.2%  page in :     5744                             
nice  :       0:00:00.00   0.0%  page out:      354                             
system:       0:00:09.31   5.5%  swap in :        1                             
idle  :       0:02:33.77  91.3%  swap out:        0                             
uptime:       0:02:48.38         context :     2940                             
                                                                                
irq  0:     16840 timer                 irq  9:         0 acpi, PCnet/FAST III  
irq  1:         3 keyboard              irq 12:         0 PS/2 Mouse            
irq  2:         0 cascade [4]           irq 14:      1640 ide0                  
irq  4:       127 serial                irq 15:         3 ide1                  
irq  8:         1 rtc                                               


after trying to ping -c10 a host in it's own range (default gw in fact):

Jan 12 12:30:36 multimedia kernel: eth0: pcnet32_open() irq 9 tx/rx rings 0x3c41
200/0x3c41000 init 0x3c41300.                                                   
Jan 12 12:30:36 multimedia kernel: eth0: pcnet32 open after 5 ticks, init block 
0x3c41300 csr0 01f3.                                                            
Jan 12 12:30:38 multimedia kernel: eth0: pcnet32_start_xmit() called, csr0 01f3.
Jan 12 12:33:38 multimedia kernel: eth0: pcnet32_start_xmit() called, csr0 07f3.
Jan 12 12:33:50 multimedia last message repeated 12 times                       
Jan 12 12:36:38 multimedia kernel: eth0: pcnet32_start_xmit() called, csr0 07f3.
Jan 12 12:39:38 multimedia kernel: eth0: pcnet32_start_xmit() called, csr0 07f3.
Jan 12 12:39:38 multimedia kernel: NETDEV WATCHDOG: eth0: transmit timed out    
Jan 12 12:39:38 multimedia kernel: eth0: transmit timed out, status 07f3, resett
ing.                                                                            
Jan 12 12:39:38 multimedia kernel:  Ring data dump: dirty_tx 0 cur_tx 16 (full) 
cur_rx 0.                                                                       
Jan 12 12:39:38 multimedia kernel:   03b1b012 0608 00000040 0310 03b1b812 0608 0
0000040 0310                                                                    
Jan 12 12:39:38 multimedia kernel:   03b1a012 0608 00000040 0310 03b1a812 0608 0
0000040 0310                                                                    
Jan 12 12:39:38 multimedia kernel:   03b19012 0608 00000040 0310 03b19812 0608 0
0000040 0310                                                                    
Jan 12 12:39:38 multimedia kernel:   03b18012 0608 00000040 0310 03b18812 0608 0
0000040 0310                                                                    
Jan 12 12:39:38 multimedia kernel:   03b03012 0608 00000040 0310 03b03812 0608 0
0000040 0310                                                                    
Jan 12 12:39:38 multimedia kernel:   03b02012 0608 00000040 0310 03b02812 0608 0
0000040 0310                                                                    
Jan 12 12:39:38 multimedia kernel:   03b01012 0608 00000040 0310 03b01812 0608 0
0000040 0310                                                                    
Jan 12 12:39:38 multimedia kernel:   03b00012 0608 00000040 0310 03b00812 0608 0
0000092 0310                                                                    
Jan 12 12:39:38 multimedia kernel:   03b0f012 0608 00000040 0310 03b0f812 0608 0
0000040 0310                                                                    
Jan 12 12:39:38 multimedia kernel:   03b0e012 0608 00000040 0310 03b0e812 0608 0
0000040 0310                                                           

I send an email to the author, no response yet.

Danny
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
