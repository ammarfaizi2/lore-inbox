Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbRGCA2T>; Mon, 2 Jul 2001 20:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265540AbRGCA2K>; Mon, 2 Jul 2001 20:28:10 -0400
Received: from snowstorm.mail.pipex.net ([158.43.192.97]:10131 "HELO
	snowstorm.mail.pipex.net") by vger.kernel.org with SMTP
	id <S265532AbRGCA16>; Mon, 2 Jul 2001 20:27:58 -0400
From: "Trevor Hemsley" <Trevor-Hemsley@dial.pipex.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 03 Jul 2001 01:28:05 +0000
Reply-To: "Trevor Hemsley" <Trevor-Hemsley@dial.pipex.com>
X-Mailer: PMMail 1.96a For OS/2
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: pcmcia lockup inserting or removing cards in 2.4.5-ac{13,22}
Message-Id: <20010703002805Z265532-17720+9997@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somewhere between 2.4.2 and 2.4.5-ac13, PCMCIA card insertion and 
removal appears to have broken on my Toshiba Libretto. On 2.4.2 all was 
fine. On both 2.4.5-ac13 and ac22 it's broken. The whole machine freezes 
solid, no SAK-s, SAK-u, SAK-b, no Ctrl-Alt-Fn to switch VC's. No messages 
are issued. Problem occurs when inserting/removing any of YE-Data PCMCIA 
floppy, TDK Smartmedia adapter (ide_cs), or 3c589 ethernet card.

If I boot with the cards in the slot then there is no problem - I can cardctl 
eject/insert them as long as I do not physically remove the cards from the 
slots. Any attempt to insert/remove cards kills the machine to power off
point. Dropping back to 2.4.2 cures this.

Base system is SuSE 7.1.

trevor@trevor5:~ > /sbin/lspci                                                            
00:00.0 Host bridge: Toshiba America Info Systems 601 (rev 2e)                            
00:04.0 VGA compatible controller: Neomagic Corporation NM2160 [MagicGraph 128XD] (rev 01)
00:06.0 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 20)                     
00:06.1 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 20)                     
00:0b.0 USB Controller: NEC Corporation USB (rev 02)                                      
00:11.0 Communication controller: Toshiba America Info Systems FIR Port (rev 22)          
00:13.0 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 20)                     
00:13.1 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 20)                     
trevor@trevor5:~ >                                                                        

trevor@trevor5:~ > dmesg
Linux version 2.4.5-ac22 (root@trevor5) (gcc version 2.95.2 19991024 (release)) #4 Mon Jul 2 23:27:13 GMT 2001 
BIOS-provided physical RAM map:                                                                                
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)                                                       
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)                                                     
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)                                                     
 BIOS-e820: 0000000000100000 - 0000000004010000 (usable)                                                       
 BIOS-e820: 0000000004010000 - 0000000004020000 (ACPI data)                                                    
 BIOS-e820: 0000000004020000 - 0000000004040000 (reserved)                                                     
 BIOS-e820: 00000000fef80000 - 00000000ff000000 (reserved)                                                     
 BIOS-e820: 00000000fffe0000 - 00000000fffe6e00 (reserved)                                                     
 BIOS-e820: 00000000fffe6e00 - 00000000fffe7000 (ACPI NVS)                                                     
 BIOS-e820: 00000000fffe7000 - 0000000100000000 (reserved)                                                     
On node 0 totalpages: 16400                                                                                    
zone(0): 4096 pages.                                                                                           
zone(1): 12304 pages.                                                                                          
zone(2): 0 pages.                                                                                              
Kernel command line: BOOT_IMAGE=l245 ro root=306 BOOT_FILE=/l245/vmlinuz video=vesa:ywrap                      
Initializing CPU#0                                                                                             
Detected 166.637 MHz processor.                                                                                
Console: colour dummy device 80x25                                                                             
Calibrating delay loop... 332.59 BogoMIPS                                                                      
Memory: 62616k/65600k available (823k kernel code, 2596k reserved, 225k data, 200k init, 0k highmem)           
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)                                                
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)                                                   
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)                                                   
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)                                                  
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)                                                  
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0                                          
Intel Pentium with F0 0F bug - workaround enabled.                                                             
Intel old style machine check architecture supported.                                                          
Intel old style machine check reporting enabled on CPU#0.                                                      
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000                                              
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000                                              
CPU:             Common caps: 008001bf 00000000 00000000 00000000                                              
CPU: Intel Mobile Pentium MMX stepping 01                                                                      
Checking 'hlt' instruction... OK.                                                                              
POSIX conformance testing by UNIFIX                                                                            
PCI: PCI BIOS revision 2.10 entry at 0xfc5f8, last bus=21                                                      
PCI: Using configuration type 1                                                                                
PCI: Probing PCI hardware                                                                                      
Linux NET4.0 for Linux 2.4                                                                                     
Based upon Swansea University Computer Society NET3.039                                                        
Initializing RT netlink socket                                                                                 
apm: BIOS version 1.2 Flags 0x02 (Driver version 1.14)                                                         
Starting kswapd v1.8                                                                                           
vesafb: framebuffer at 0xfd000000, mapped to 0xc5002000, size 1984k                                            
vesafb: mode is 800x480x8, linelength=800, pages=4                                                             
vesafb: protected mode interface info at c000:8610                                                             
vesafb: pmi: set display start = c00c8646, set palette = c00c8698                                              
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=2539                                         
Console: switching to colour frame buffer device 100x30                                                            
fb0: VESA VGA frame buffer device                                                                                  
pty: 256 Unix98 ptys configured                                                                                    
Toshiba System Managment Mode driver v1.9 22/3/2001                                                                
Serial driver version 5.05b (2001-05-03) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled                              
ttyS00 at 0x03f8 (irq = 4) is a 16550A                                                                             
block: queued sectors max/low 41376kB/13792kB, 128 slots per queue                                                 
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize                                              
Uniform Multi-Platform E-IDE driver Revision: 6.31                                                                 
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx                                        
hda: FUJITSU MHH2064AT, ATA DISK drive                                                                             
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14                                                                                
hda: 12685680 sectors (6495 MB) w/512KiB Cache, CHS=789/255/63                                                     
Partition check:                                                                                                   
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >                                                                       
Linux Kernel Card Services 3.1.22                                                                                  
  options:  [pci] [cardbus] [pm]                                                                                   
PCI: No IRQ known for interrupt pin A of device 00:06.0. Please try using pci=biosirq.                             
PCI: No IRQ known for interrupt pin B of device 00:06.1. Please try using pci=biosirq.                             
PCI: No IRQ known for interrupt pin A of device 00:13.0. Please try using pci=biosirq.                             
PCI: No IRQ known for interrupt pin B of device 00:13.1. Please try using pci=biosirq.                             
Intel PCIC probe: not found.                                                                                       
NET4: Linux TCP/IP 1.0 for NET4.0                                                                                  
IP Protocols: ICMP, UDP, TCP, IGMP                                                                                 
IP: routing cache hash table of 512 buckets, 4Kbytes                                                               
TCP: Hash tables configured (established 4096 bind 4096)                                                           
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.                                                                
Yenta IRQ list 0eb8, PCI irq0                                                                                      
Socket status: 30000007                                                                                            
Yenta IRQ list 0eb8, PCI irq0                                                                                      
Socket status: 30000007                                                                                            
Yenta IRQ list 0eb8, PCI irq0                                                                                      
Socket status: 30000011                                                                                            
Yenta IRQ list 0eb8, PCI irq0                                                                                      
Socket status: 30000007                                                                                            
VFS: Mounted root (ext2 filesystem) readonly.                                                                      
Freeing unused kernel memory: 200k freed                                                                           
Adding Swap: 64220k swap-space (priority -1)                                                                       
cs: IO port probe 0x0c00-0x0cff: clean.                                                                            
cs: IO port probe 0x0800-0x08ff: clean.                                                                            
cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x330-0x337 0x370-0x377 0x388-0x38f 0x480-0x48f 0x4d0-0x4d7 
cs: IO port probe 0x0a00-0x0aff: clean.                                                                            
cs: memory probe 0xa0000000-0xa0ffffff: clean.                                                                     
eth0: 3Com 3c589, io 0x300, irq 3, hw_addr 00:60:97:8B:2B:2B                                                       
  8K FIFO split 5:3 Rx:Tx, auto xcvr                                                                               
eth0: flipped to 10baseT                                                                                           
usb.c: registered new driver usbdevfs                                                                              
usb.c: registered new driver hub                                                                                   
usb-ohci.c: USB OHCI at membase 0xc521c000, IRQ 11            
usb-ohci.c: usb-00:0b.0, NEC Corporation USB                  
usb.c: new USB bus registered, assigned bus number 1          
hub.c: USB hub found                                          
hub.c: 2 ports detected                                       
usb-ohci.c: v5.2:USB OHCI Host Controller Driver              
usb.c: registered new driver hid                              
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers                           
mice: PS/2 mouse device common for all mice                   
scanlogd uses obsolete (PF_INET,SOCK_PACKET)                  
eth0: flipped to 10baseT                                      

trevor@trevor5:/usr/src/linux > /sbin/lsmod    
Module                  Size  Used by          
mousedev                3872   0 (unused)      
hid                    12608   0 (unused)      
input                   3264   0 [mousedev hid]
usb-ohci               17376   0 (unused)      
usbcore                47328   1 [hid usb-ohci]
3c589_cs                7456   1               

trevor@trevor5:~ > grep -v ^# /usr/src/linux/.config
CONFIG_X86=y                    
CONFIG_ISA=y                    
CONFIG_UID16=y                  
CONFIG_EXPERIMENTAL=y           
CONFIG_MODULES=y                
CONFIG_MODVERSIONS=y            
CONFIG_KMOD=y                   
CONFIG_M586MMX=y                
CONFIG_X86_WP_WORKS_OK=y        
CONFIG_X86_INVLPG=y             
CONFIG_X86_CMPXCHG=y            
CONFIG_X86_XADD=y               
CONFIG_X86_BSWAP=y              
CONFIG_X86_POPAD_OK=y           
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5     
CONFIG_X86_USE_STRING_486=y     
CONFIG_X86_ALIGNMENT_16=y       
CONFIG_X86_TSC=y                
CONFIG_X86_GOOD_APIC=y          
CONFIG_TOSHIBA=y                
CONFIG_MICROCODE=m              
CONFIG_X86_MSR=m                
CONFIG_X86_CPUID=m              
CONFIG_NOHIGHMEM=y              
CONFIG_NET=y                    
CONFIG_PCI=y                    
CONFIG_PCI_GOANY=y              
CONFIG_PCI_BIOS=y               
CONFIG_PCI_DIRECT=y             
CONFIG_PCI_NAMES=y              
CONFIG_HOTPLUG=y                
CONFIG_PCMCIA=y                 
CONFIG_CARDBUS=y                
CONFIG_I82365=y                 
CONFIG_SYSVIPC=y                
CONFIG_SYSCTL=y                 
CONFIG_KCORE_ELF=y              
CONFIG_BINFMT_ELF=y             
CONFIG_PM=y                     
CONFIG_APM=y                    
CONFIG_APM_DISPLAY_BLANK=y      
CONFIG_APM_RTC_IS_GMT=y         
CONFIG_APM_ALLOW_INTS=y         
CONFIG_BLK_DEV_FD=m         
CONFIG_BLK_DEV_FD_PCMCIA=y  
CONFIG_BLK_DEV_LOOP=m       
CONFIG_BLK_DEV_RAM=y        
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y     
CONFIG_PACKET=y             
CONFIG_PACKET_MMAP=y        
CONFIG_NETLINK=y            
CONFIG_RTNETLINK=y          
CONFIG_UNIX=y               
CONFIG_INET=y               
CONFIG_IP_MULTICAST=y       
CONFIG_SYN_COOKIES=y        
CONFIG_IDE=y                
CONFIG_BLK_DEV_IDE=y        
CONFIG_BLK_DEV_IDEDISK=y    
CONFIG_BLK_DEV_IDECS=m      
CONFIG_BLK_DEV_IDEPCI=y     
CONFIG_IDEPCI_SHARE_IRQ=y   
CONFIG_BLK_DEV_IDEDMA_PCI=y 
CONFIG_IDEDMA_PCI_AUTO=y    
CONFIG_BLK_DEV_IDEDMA=y     
CONFIG_BLK_DEV_PIIX=y       
CONFIG_PIIX_TUNING=y        
CONFIG_IDEDMA_AUTO=y        
CONFIG_BLK_DEV_IDE_MODES=y  
CONFIG_NETDEVICES=y         
CONFIG_DUMMY=m              
CONFIG_NET_PCMCIA=y                
CONFIG_PCMCIA_3C589=m              
CONFIG_INPUT=m                     
CONFIG_INPUT_MOUSEDEV=m            
CONFIG_INPUT_MOUSEDEV_SCREEN_X=800 
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=480 
CONFIG_VT=y                        
CONFIG_VT_CONSOLE=y                
CONFIG_SERIAL=y                    
CONFIG_UNIX98_PTYS=y               
CONFIG_UNIX98_PTY_COUNT=256        
CONFIG_I2C=m                       
CONFIG_I2C_ALGOBIT=m               
CONFIG_I2C_ELV=m                   
CONFIG_I2C_VELLEMAN=m              
CONFIG_I2C_ALGOPCF=m               
CONFIG_I2C_ELEKTOR=m               
CONFIG_I2C_CHARDEV=m               
CONFIG_MOUSE=y                     
CONFIG_PSMOUSE=y                   
CONFIG_PCMCIA_SERIAL_CS=m          
CONFIG_AUTOFS4_FS=y                
CONFIG_FAT_FS=m                    
CONFIG_MSDOS_FS=m                  
CONFIG_VFAT_FS=m                   
CONFIG_TMPFS=y                     
CONFIG_ISO9660_FS=y                
CONFIG_JOLIET=y                    
CONFIG_MINIX_FS=m                  
CONFIG_PROC_FS=y                   
CONFIG_DEVPTS_FS=y                 
CONFIG_EXT2_FS=y                   
CONFIG_MSDOS_PARTITION=y       
CONFIG_NLS=y                   
CONFIG_NLS_DEFAULT="iso8859-1" 
CONFIG_NLS_CODEPAGE_437=m      
CONFIG_NLS_CODEPAGE_850=m      
CONFIG_NLS_ISO8859_1=m         
CONFIG_NLS_UTF8=m              
CONFIG_VGA_CONSOLE=y           
CONFIG_VIDEO_SELECT=y          
CONFIG_FB=y                    
CONFIG_DUMMY_CONSOLE=y         
CONFIG_FB_VESA=y               
CONFIG_VIDEO_SELECT=y          
CONFIG_FBCON_CFB8=y            
CONFIG_FBCON_CFB16=y           
CONFIG_FBCON_CFB24=y           
CONFIG_FBCON_CFB32=y           
CONFIG_FONT_8x8=y              
CONFIG_FONT_8x16=y             
CONFIG_SOUND=m                 
CONFIG_SOUND_OSS=m             
CONFIG_SOUND_TRACEINIT=y       
CONFIG_SOUND_YM3812=m          
CONFIG_SOUND_OPL3SA2=m         
CONFIG_USB=m                   
CONFIG_USB_DEVICEFS=y          
CONFIG_USB_OHCI=m              
CONFIG_USB_HID=m               
CONFIG_DEBUG_KERNEL=y          
CONFIG_MAGIC_SYSRQ=y           

No need to cc me as I read the newsgroup archive of linux-kernel and should 
get replies there, thanks.


Trevor Hemsley, Brighton, UK.
Trevor-Hemsley@dial.pipex.com

