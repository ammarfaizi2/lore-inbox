Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTJIQgA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 12:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbTJIQgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 12:36:00 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:41200
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S262228AbTJIQfe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 12:35:34 -0400
Date: Thu, 9 Oct 2003 18:35:30 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Daniel Blueman <daniel.blueman@gmx.net>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [BUG] [2.4.21] 8139too 'too much work at interrupt'...
Message-ID: <20031009163530.GA7001@wind.cocodriloo.com>
References: <16084.1065694106@www3.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16084.1065694106@www3.gmx.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This happens to me also on 2.4.18 and 2.4.19 (yes, I know they are old).

Happens about once every 5 months, with the box running at
about 1 month uptime per reboot (home server, there is no UPS)

On Thu, Oct 09, 2003 at 12:08:26PM +0200, Daniel Blueman wrote:
> eth0 stopped receiving and sending packets. Please CC me for more
> information.
> 
> ---
> 
> # dmesg
> [snip]
> 8139too Fast Ethernet driver 0.9.26
> eth0: SMC1211TX EZCard 10/100 (RealTek RTL8139) at 0xfffffd0009442000,
> 00:e0:29:1c:7c:50, IRQ 23
> eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability
> 45e1.
> [snip, some time later]
> eth0: Too much work at interrupt, IntrStatus=0x0010.
> [eth0 not rx/txing packets]
> 
> # ethtool -i eth0
> driver: 8139too
> version: 0.9.26
> firmware-version:
> bus-info: 00:09.0
> 
> # ethtool eth0
> Settings for eth0:
>                                                                             
>                                                                             
>        
>         Supported ports: [ TP MII ]
>         Supported link modes:   10baseT/Half 10baseT/Full
>                                 100baseT/Half 100baseT/Full
>                                                                             
>                                                                             
>        
>         Supports auto-negotiation? Yes
>         Speed: 100Mb/s
>         Duplex: Full
>         Port: MII
>         PHYAD: 32
>         Transceiver: internal
>         Auto-negotiation: on
> 
> # lspci -s 00:09.0 -vxxx
> 00:09.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev
> 10)
>         Subsystem: Accton Technology Corporation EN-1207D Fast Ethernet
> Adapter
>         Flags: bus master, medium devsel, latency 32, IRQ 23
>         I/O ports at 8400 [size=128]
>         Memory at 0000000009442000 (32-bit, non-prefetchable) [size=128]
> 00: 13 11 11 12 07 00 00 02 10 00 00 02 00 20 00 00
> 10: 01 84 00 00 00 20 44 09 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 13 11 11 12
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 17 01 20 40
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> # cat /proc/interrupts
>            CPU0       CPU1
>   1:          2          0          XT-PIC   keyboard
>   2:          0          0          XT-PIC   cascade
>   4:       4102          0          XT-PIC   serial
>   8:   65836187   65835236             RTC  +timer
>  14:          5          0          XT-PIC  +ide0
>  19:          0      32045           DP264   aic7xxx
>  23:          0    2225944           DP264   eth0
>  27:     363080          0           DP264   elan
> IPI:    3238154    3303111
> ERR:          0
> 
> # cat /proc/cpuinfo
> cpu                     : Alpha
> cpu model               : EV67
> cpu variation           : 7
> cpu revision            : 0
> cpu serial number       :
> system type             : Tsunami
> system variation        : DP264
> system revision         : 0
> system serial number    : 007
> cycle frequency [Hz]    : 666666666
> timer frequency [Hz]    : 1024.00
> page size [bytes]       : 8192
> phys. address bits      : 44
> max. addr. space #      : 255
> BogoMIPS                : 1330.04
> kernel unaligned acc    : 0 (pc=0,va=0)
> user unaligned acc      : 0 (pc=0,va=0)
> platform string         : UP2000 666 MHz
> cpus detected           : 2
> cpus active             : 2
> cpu active mask         : 0000000000000003
> 
> [restarted of eth0 interface here]
> 
> # ./rtl8139-diag -mmaaavvveef
> rtl8139-diag.c:v2.01 1/8/2001 Donald Becker (becker@scyld.com)
>  http://www.scyld.com/diag/index.html
> Index #1: Found a SMC1211TX EZCard 10/100 (RealTek RTL8139) adapter at
> 0x8400.
> RealTek chip registers at 0x8400
>  0x000: 1c29e000 0000507c 80000000 00000000 0008a0ba 0008a0b6 0008a0ba
> 0008a0ba
>  0x020: 94c20000 94c20600 94c20c00 94c21200 9e8d0000 0d0a0000 b308b2f8
> 0000807f
>  0x040: 60000600 0000f78e c4367d6d 00000000 000c10c6 00000000 00000080
> 00100000
>  0x060: 1100f00f 05e1782d 000145e1 00000000 00000024 000007c8 00000000
> 00000000.
>   No interrupt sources are pending.
>  The chip configuration is 0x10 0x0c, MII half-duplex mode.
> EEPROM size test returned 6, 0x204a7 / 0x29697.
> Parsing the EEPROM of a RealTek chip:
>   PCI IDs -- Vendor 0x1113, Device 0x1211, Subsystem 0x1113.
>   PCI timer settings -- minimum grant 32, maximum latency 64.
>   General purpose pins --  direction 0xf3  value 0x10.
>   Station Address 00:E0:29:1C:7C:50.
>   Configuration register 0/1 -- 0x2c / 0x00.
>  EEPROM active region checksum is 04c8.
> EEPROM contents:
>   8129 1113 1211 1113 1211 4020 f310 e000
>   1c29 507c 2c10 0000 a5a5 a5a5 a5a5 a5a5
>   a5a5 a5a5 a5a5 a5a5 a5a5 a5a5 a5a5 a5a5
>   a5a5 a5a5 a5a5 a5a5 a5a5 a5a5 a5a5 a5a5
>   a5a5 a5a5 a5a5 a5a5 a5a5 a5a5 a5a5 a5a5
>   a5a5 a5a5 a5a5 a5a5 a5a5 a5a5 a5a5 a5a5
>   a5a5 a5a5 a5a5 a5a5 a5a5 a5a5 a5a5 a5a5
>   a5a5 a5a5 a5a5 a5a5 a5a5 a5a5 a5a5 a5a5
>  The word-wide EEPROM checksum is 0x18da.
> 
> 
> # ./rtl8139-diag-parse.pl /tmp/diag.txt
> ID registers: 00:E0:29:1C:7C:50
> Reserved (06) = 0x00
> Reserved (07) = 0x00
> MAR0-7: 00:00:00:80:00:00:00:00
> TSD0: SIZE=186 ERTXTH=256 NCC=0 OWN TOK
> TSD1: SIZE=82 ERTXTH=256 NCC=0 OWN TOK
> TSD2: SIZE=134 ERTXTH=256 NCC=0 OWN TOK
> TSD3: SIZE=186 ERTXTH=256 NCC=0 OWN TOK
> TSAD0 = 0x94C20000
> TSAD1 = 0x94C20600
> TSAD2 = 0x94C20C00
> TSAD3 = 0x94C21200
> RBSTART = 0x9E8D0000
> ERBCR = 0x0D0A
> ERSR: ERGood EROVW
> CR: RE TE BUFE
> CAPR = 20720
> CBR = 20736
> IMR1: SERR FOVW PUN/LinkChg RXOVW TER TOK RER ROK
> ISR1: 0
> TCR: CHIP=RTL-8139 TXRR=0 MAXDMA=1024 LOOP=normal
> RCR: MAXDMA=unlimited RBLEN=32K+16 RXFTH=none ERTH=none
> RCR (cont): WRAP AB AM APM
> TCTR = 3226309911
> MPC = 0x00000000
> 9346CR: Config register write enable
> Config0: PL1
> Config1: MEMMAP IOMAP
> Reserved (53) = 0x00
> TimerInt = 0x00000000
> MSR: TXFCE
> Config3: 0
> Config4: 0
> Reserved (5B) = 0x00
> MISR: 0
> RERID = 0x10
> Reserved (5F) = 0x00
> TSAD: TOK3 TOK2 TOK1 TOK0 OWN3 OWN2 OWN1 OWN0
> BMCR: ANE FDX
> BMSR: 100baseT-HD 100baseT-HD 10baseT-FD 10baseT-HD ANC AutoNeg LinkStatus
> ExtCap
> ANAR: Pause TXFD TX 10FD 10 Sel0
> ANLPAR: ACK Pause TXFD TX 10FD 10 Sel0
> ANER: LP_NW_ABLE
> DIS = 0
> FCSC = 0
> NWAYTR: BIT5 FLAGABD
> Rx Err Count = 0
> CSCR: BIT10 LD HEART_BEAT JBEN F_LINK_100
> Reserved(76) = 0x0000
> PHY1_PARM = 0x00000000
> TW_PARM = 0x00000000
> 
> -- 
> Daniel J Blueman
> 
> NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
> Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService
> 
> Jetzt kostenlos anmelden unter http://www.gmx.net
> 
> +++ GMX - die erste Adresse für Mail, Message, More! +++
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
winden/network

1. Dado un programa, siempre tiene al menos un fallo.
2. Dadas varias lineas de codigo, siempre se pueden acortar a menos lineas.
3. Por induccion, todos los programas se pueden
   reducir a una linea que no funciona.
