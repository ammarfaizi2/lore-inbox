Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130429AbQKYAH6>; Fri, 24 Nov 2000 19:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130695AbQKYAHv>; Fri, 24 Nov 2000 19:07:51 -0500
Received: from [209.249.10.20] ([209.249.10.20]:19382 "EHLO
        freya.yggdrasil.com") by vger.kernel.org with ESMTP
        id <S130429AbQKYAHg>; Fri, 24 Nov 2000 19:07:36 -0500
Date: Fri, 24 Nov 2000 15:37:33 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Patch(?): isapnp_card_id tables for all isapnp drivers in 2.4.0-test11
Message-ID: <20001124153733.A1876@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	I have made added isapnp_card_id table to all isapnp drivers.
This is the isapnp equivalent of the pci MODULE_DEVICE_TABLE declarations.
They allow a user level software agent to know which modules correspond
to your hardware configuration and to load them.  One such implementation
(GPL'ed) is available from
ftp://ftp.yggdrasil.com/pub/dist/device_control/isapnpmodules/.

	There previously were no isapnp_card_id tables in the kernel
drivers.  I believe this patch adds isapnp_card_id tables to all of
them, completing the coverage of Keith Owens's
/lib/modules/<version>/modules.{pci,usb,isapnp}map files.  I have
attached a patch below that covers just the files that have the
isapnp changes.  Note that it includes a couple of pci_device_id
table declarations that happened to flow into the same "diff" sections
as the isapnp_card_id declarations.  A complete set of patches
with both pci and isapnp declarations is available from

ftp://ftp.yggdrasil.com/pub/dist/device_control/kernel/pci_id_tables-2.4.0-test11.patch2.gz

	Note that this is not a "final" version.  I plan to go
through all of the changes and bracket all of these new tables
with #ifdef MODULE...#endif so they do not result in complaints
about the table being defined static and never used in cases where
the driver is compiled directly into the kernel.  After 2.4.0, I
imainge most of those #ifdef MODULE conditions will go away
as the tables come to be actually used by the driver code.

	Any comments are welcome.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="diffs.isapnp"

--- linux-2.4.0-test11/drivers/char/serial.c	Mon Oct 16 12:58:51 2000
+++ linux/drivers/char/serial.c	Fri Nov 24 14:07:01 2000
@@ -4682,6 +4682,287 @@
 	unsigned short device;
 };
 
+#define ISPNP_TBL_ENTRY(v1,v2,v3,func) { \
+	card_vendor: ISAPNP_ANY_ID, \
+	card_device: ISAPNP_ANY_ID, \
+	devs: { ISAPNP_DEVICE_ID(v1,v2,v3,func ) }, \
+}
+
+# ifdef MODULE
+static struct isapnp_card_id ixj_isa_ids[] __initdata = {
+	/* Archtek America Corp. */
+	/* Archtek SmartLink Modem 3334BT Plug & Play */
+	ISAPNP_TBL_ENTRY('A', 'A', 'C', 0x000F),
+	/* Anchor Datacomm BV */
+	/* SXPro 144 External Data Fax Modem Plug & Play */
+	ISAPNP_TBL_ENTRY('A', 'D', 'C', 0x0001),
+	/* SXPro 288 External Data Fax Modem Plug & Play */
+	ISAPNP_TBL_ENTRY('A', 'D', 'C', 0x0002),
+	/* Rockwell 56K ACF II Fax+Data+Voice Modem */
+	ISAPNP_TBL_ENTRY('A', 'K', 'Y', 0x1021),
+	/* AZT3005 PnP SOUND DEVICE */
+	ISAPNP_TBL_ENTRY('A', 'Z', 'T', 0x4001),
+	/* Best Data Products Inc. Smart One 336F PnP Modem */
+	ISAPNP_TBL_ENTRY('B', 'D', 'P', 0x3336),
+	/*  Boca Research */
+	/* Boca Complete Ofc Communicator 14.4 Data-FAX */
+	ISAPNP_TBL_ENTRY('B', 'R', 'I', 0x0A49),
+	/* Boca Research 33,600 ACF Modem */
+	ISAPNP_TBL_ENTRY('B', 'R', 'I', 0x1400),
+	/* Boca 33.6 Kbps Internal FD34FSVD */
+	ISAPNP_TBL_ENTRY('B', 'R', 'I', 0x3400),
+	/* Boca 33.6 Kbps Internal FD34FSVD */
+	ISAPNP_TBL_ENTRY('B', 'R', 'I', 0x0A49),
+	/* Best Data Products Inc. Smart One 336F PnP Modem */
+	ISAPNP_TBL_ENTRY('B', 'D', 'P', 0x3336),
+	/* Computer Peripherals Inc */
+	/* EuroViVa CommCenter-33.6 SP PnP */
+	ISAPNP_TBL_ENTRY('C', 'P', 'I', 0x4050),
+	/* Creative Labs */
+	/* Creative Labs Phone Blaster 28.8 DSVD PnP Voice */
+	ISAPNP_TBL_ENTRY('C', 'T', 'L', 0x3001),
+	/* Creative Labs Modem Blaster 28.8 DSVD PnP Voice */
+	ISAPNP_TBL_ENTRY('C', 'T', 'L', 0x3011),
+	/* Creative */
+	/* Creative Modem Blaster Flash56 DI5601-1 */
+	ISAPNP_TBL_ENTRY('D', 'M', 'B', 0x1032),
+	/* Creative Modem Blaster V.90 DI5660 */
+	ISAPNP_TBL_ENTRY('D', 'M', 'B', 0x2001),
+	/* FUJITSU */
+	/* Fujitsu 33600 PnP-I2 R Plug & Play */
+	ISAPNP_TBL_ENTRY('F', 'U', 'J', 0x0202),
+	/* Fujitsu FMV-FX431 Plug & Play */
+	ISAPNP_TBL_ENTRY('F', 'U', 'J', 0x0205),
+	/* Fujitsu 33600 PnP-I4 R Plug & Play */
+	ISAPNP_TBL_ENTRY('F', 'U', 'J', 0x0206),
+	/* Fujitsu Fax Voice 33600 PNP-I5 R Plug & Play */
+	ISAPNP_TBL_ENTRY('F', 'U', 'J', 0x0209),
+	/* Archtek America Corp. */
+	/* Archtek SmartLink Modem 3334BT Plug & Play */
+	ISAPNP_TBL_ENTRY('G', 'V', 'C', 0x000F),
+	/* Hayes */
+	/* Hayes Optima 288 V.34-V.FC + FAX + Voice Plug & Play */
+	ISAPNP_TBL_ENTRY('H', 'A', 'Y', 0x0001),
+	/* Hayes Optima 336 V.34 + FAX + Voice PnP */
+	ISAPNP_TBL_ENTRY('H', 'A', 'Y', 0x000C),
+	/* Hayes Optima 336B V.34 + FAX + Voice PnP */
+	ISAPNP_TBL_ENTRY('H', 'A', 'Y', 0x000D),
+	/* Hayes Accura 56K Ext Fax Modem PnP */
+	ISAPNP_TBL_ENTRY('H', 'A', 'Y', 0x5670),
+	/* Hayes Accura 56K Ext Fax Modem PnP */
+	ISAPNP_TBL_ENTRY('H', 'A', 'Y', 0x5674),
+	/* Hayes Accura 56K Fax Modem PnP */
+	ISAPNP_TBL_ENTRY('H', 'A', 'Y', 0x5675),
+	/* Hayes 288, V.34 + FAX */
+	ISAPNP_TBL_ENTRY('H', 'A', 'Y', 0xF000),
+	/* Hayes Optima 288 V.34 + FAX + Voice, Plug & Play */
+	ISAPNP_TBL_ENTRY('H', 'A', 'Y', 0xF001),
+	/* IBM */
+	/* IBM Thinkpad 701 Internal Modem Voice */
+	ISAPNP_TBL_ENTRY('I', 'B', 'M', 0x0033),
+	/* Intertex */
+	/* Intertex 28k8 33k6 Voice EXT PnP */
+	ISAPNP_TBL_ENTRY('I', 'X', 'D', 0xC801),
+	/* Intertex 33k6 56k Voice EXT PnP */
+	ISAPNP_TBL_ENTRY('I', 'X', 'D', 0xC901),
+	/* Intertex 28k8 33k6 Voice SP EXT PnP */
+	ISAPNP_TBL_ENTRY('I', 'X', 'D', 0xD801),
+	/* Intertex 33k6 56k Voice SP EXT PnP */
+	ISAPNP_TBL_ENTRY('I', 'X', 'D', 0xD901),
+	/* Intertex 28k8 33k6 Voice SP INT PnP */
+	ISAPNP_TBL_ENTRY('I', 'X', 'D', 0xF401),
+	/* Intertex 28k8 33k6 Voice SP EXT PnP */
+	ISAPNP_TBL_ENTRY('I', 'X', 'D', 0xF801),
+	/* Intertex 33k6 56k Voice SP EXT PnP */
+	ISAPNP_TBL_ENTRY('I', 'X', 'D', 0xF901),
+	/* Kortex International */
+	/* KORTEX 28800 Externe PnP */
+	ISAPNP_TBL_ENTRY('K', 'O', 'R', 0x4522),
+	/* KXPro 33.6 Vocal ASVD PnP */
+	ISAPNP_TBL_ENTRY('K', 'O', 'R', 0xF661),
+	/* Lasat */
+	/* LASAT Internet 33600 PnP */
+	ISAPNP_TBL_ENTRY('L', 'A', 'S', 0x4040),
+	/* Lasat Safire 560 PnP */
+	ISAPNP_TBL_ENTRY('L', 'A', 'S', 0x4540),
+	/* Lasat Safire 336  PnP */
+	ISAPNP_TBL_ENTRY('L', 'A', 'S', 0x5440),
+	/* Microcom, Inc. */
+	/* Microcom TravelPorte FAST V.34 Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'N', 'P', 0x281),
+	/* Microcom DeskPorte V.34 FAST or FAST+ Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'N', 'P', 0x0336),
+	/* Microcom DeskPorte FAST EP 28.8 Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'N', 'P', 0x0339),
+	/* Microcom DeskPorte 28.8P Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'N', 'P', 0x0342),
+	/* Microcom DeskPorte FAST ES 28.8 Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'N', 'P', 0x0500),
+	/* Microcom DeskPorte FAST ES 28.8 Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'N', 'P', 0x0501),
+	/* Microcom DeskPorte 28.8S Internal Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'N', 'P', 0x0502),
+	/* Motorola */
+	/* Motorola BitSURFR Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'O', 'T', 0x1105),
+	/* Motorola TA210 Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'O', 'T', 0x1111),
+	/* Motorola HMTA 200 (ISDN) Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'O', 'T', 0x1114),
+	/* Motorola BitSURFR Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'O', 'T', 0x1115),
+	/* Motorola Lifestyle 28.8 Internal */
+	ISAPNP_TBL_ENTRY('M', 'O', 'T', 0x1190),
+	/* Motorola V.3400 Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'O', 'T', 0x1501),
+	/* Motorola Lifestyle 28.8 V.34 Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'O', 'T', 0x1502),
+	/* Motorola Power 28.8 V.34 Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'O', 'T', 0x1505),
+	/* Motorola ModemSURFR External 28.8 Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'O', 'T', 0x1509),
+	/* Motorola Premier 33.6 Desktop Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'O', 'T', 0x150A),
+	/* Motorola VoiceSURFR 56K External PnP */
+	ISAPNP_TBL_ENTRY('M', 'O', 'T', 0x150F),
+	/* Motorola ModemSURFR 56K External PnP */
+	ISAPNP_TBL_ENTRY('M', 'O', 'T', 0x1510),
+	/* Motorola ModemSURFR 56K Internal PnP */
+	ISAPNP_TBL_ENTRY('M', 'O', 'T', 0x1550),
+	/* Motorola ModemSURFR Internal 28.8 Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'O', 'T', 0x1560),
+	/* Motorola Premier 33.6 Internal Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'O', 'T', 0x1580),
+	/* Motorola OnlineSURFR 28.8 Internal Plug & Play */
+	ISAPNP_TBL_ENTRY('M', 'O', 'T', 0x15B0),
+	/* Motorola VoiceSURFR 56K Internal PnP */
+	ISAPNP_TBL_ENTRY('M', 'O', 'T', 0x15F0),
+	/* Com 1 */
+	/*  Deskline K56 Phone System PnP */
+	ISAPNP_TBL_ENTRY('M', 'V', 'X', 0x00A1),
+	/* PC Rider K56 Phone System PnP */
+	ISAPNP_TBL_ENTRY('M', 'V', 'X', 0x00F2),
+	/* Pace 56 Voice Internal Plug & Play Modem */
+	ISAPNP_TBL_ENTRY('P', 'M', 'C', 0x2430),
+	/* Generic */
+	/* Generic standard PC COM port	 */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0x0500),
+	/* Generic 16550A-compatible COM port */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0x0501),
+	/* Compaq 14400 Modem */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC000),
+	/* Compaq 2400/9600 Modem */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC001),
+	/* Dial-Up Networking Serial Cable between 2 PCs */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC031),
+	/* Dial-Up Networking Parallel Cable between 2 PCs */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC032),
+	/* Standard 9600 bps Modem */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC100),
+	/* Standard 14400 bps Modem */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC101),
+	/*  Standard 28800 bps Modem*/
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC102),
+	/*  Standard Modem*/
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC103),
+	/*  Standard 9600 bps Modem*/
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC104),
+	/*  Standard 14400 bps Modem*/
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC105),
+	/*  Standard 28800 bps Modem*/
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC106),
+	/*  Standard Modem */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC107),
+	/* Standard 9600 bps Modem */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC108),
+	/* Standard 14400 bps Modem */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC109),
+	/* Standard 28800 bps Modem */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC10A),
+	/* Standard Modem */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC10B),
+	/* Standard 9600 bps Modem */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC10C),
+	/* Standard 14400 bps Modem */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC10D),
+	/* Standard 28800 bps Modem */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC10E),
+	/* Standard Modem */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0xC10F),
+	/* Standard PCMCIA Card Modem */
+	ISAPNP_TBL_ENTRY('P', 'N', 'P', 0x2000),
+	/* Rockwell */
+	/* Modular Technology */
+	/* Rockwell 33.6 DPF Internal PnP */
+	/* Modular Technology 33.6 Internal PnP */
+	ISAPNP_TBL_ENTRY('R', 'O', 'K', 0x0030),
+	/* Kortex International */
+	/* KORTEX 14400 Externe PnP */
+	ISAPNP_TBL_ENTRY('R', 'O', 'K', 0x0100),
+	/* Viking Components, Inc */
+	/* Viking 28.8 INTERNAL Fax+Data+Voice PnP */
+	ISAPNP_TBL_ENTRY('R', 'O', 'K', 0x4920),
+	/* Rockwell */
+	/* British Telecom */
+	/* Modular Technology */
+	/* Rockwell 33.6 DPF External PnP */
+	/* BT Prologue 33.6 External PnP */
+	/* Modular Technology 33.6 External PnP */
+	ISAPNP_TBL_ENTRY('R', 'S', 'S', 0x00A0),
+	/* Viking 56K FAX INT */
+	ISAPNP_TBL_ENTRY('R', 'S', 'S', 0x0262),
+	/* SupraExpress 28.8 Data/Fax PnP modem */
+	ISAPNP_TBL_ENTRY('S', 'U', 'P', 0x1310),
+	/* SupraExpress 33.6 Data/Fax PnP modem */
+	ISAPNP_TBL_ENTRY('S', 'U', 'P', 0x1421),
+	/* SupraExpress 33.6 Data/Fax PnP modem */
+	ISAPNP_TBL_ENTRY('S', 'U', 'P', 0x1590),
+	/* SupraExpress 33.6 Data/Fax PnP modem */
+	ISAPNP_TBL_ENTRY('S', 'U', 'P', 0x1760),
+	/* Phoebe Micro */
+	/* Phoebe Micro 33.6 Data Fax 1433VQH Plug & Play */
+	ISAPNP_TBL_ENTRY('T', 'E', 'X', 0x0011),
+	/* Archtek America Corp. */
+	/* Archtek SmartLink Modem 3334BT Plug & Play */
+	ISAPNP_TBL_ENTRY('U', 'A', 'C', 0x000F),
+	/* 3Com Corp. */
+	/* Gateway Telepath IIvi 33.6 */
+	ISAPNP_TBL_ENTRY('U', 'S', 'R', 0x0000),
+	/*  Sportster Vi 14.4 PnP FAX Voicemail */
+	ISAPNP_TBL_ENTRY('U', 'S', 'R', 0x0004),
+	/* U.S. Robotics 33.6K Voice INT PnP */
+	ISAPNP_TBL_ENTRY('U', 'S', 'R', 0x0006),
+	/* U.S. Robotics 33.6K Voice EXT PnP */
+	ISAPNP_TBL_ENTRY('U', 'S', 'R', 0x0007),
+	/* U.S. Robotics 33.6K Voice INT PnP */
+	ISAPNP_TBL_ENTRY('U', 'S', 'R', 0x2002),
+	/* U.S. Robotics 56K Voice INT PnP */
+	ISAPNP_TBL_ENTRY('U', 'S', 'R', 0x2070),
+	/* U.S. Robotics 56K Voice EXT PnP */
+	ISAPNP_TBL_ENTRY('U', 'S', 'R', 0x2080),
+	/* U.S. Robotics 56K FAX INT */
+	ISAPNP_TBL_ENTRY('U', 'S', 'R', 0x3031),
+	/* U.S. Robotics 56K Voice INT PnP */
+	ISAPNP_TBL_ENTRY('U', 'S', 'R', 0x3070),
+	/* U.S. Robotics 56K Voice EXT PnP */
+	ISAPNP_TBL_ENTRY('U', 'S', 'R', 0x3080),
+	/* U.S. Robotics 56K Voice INT PnP */
+	ISAPNP_TBL_ENTRY('U', 'S', 'R', 0x3090),
+	/* U.S. Robotics 56K Message  */
+	ISAPNP_TBL_ENTRY('U', 'S', 'R', 0x9100),
+	/*  U.S. Robotics 56K FAX EXT PnP*/
+	ISAPNP_TBL_ENTRY('U', 'S', 'R', 0x9160),
+	/*  U.S. Robotics 56K FAX INT PnP*/
+	ISAPNP_TBL_ENTRY('U', 'S', 'R', 0x9170),
+	/*  U.S. Robotics 56K Voice EXT PnP*/
+	ISAPNP_TBL_ENTRY('U', 'S', 'R', 0x9180),
+	/*  U.S. Robotics 56K Voice INT PnP*/
+	ISAPNP_TBL_ENTRY('U', 'S', 'R', 0x9190),
+	{ ISAPNP_CARD_END }
+};
+ISAPNP_CARD_TABLE(ixj_isa_ids);
+# endif /* MODULE */
+
 static struct pnp_board pnp_devices[] __initdata = {
 	/* Archtek America Corp. */
 	/* Archtek SmartLink Modem 3334BT Plug & Play */
--- linux-2.4.0-test11/drivers/char/joystick/ns558.c	Fri Nov 17 16:52:23 2000
+++ linux/drivers/char/joystick/ns558.c	Fri Nov 24 13:51:26 2000
@@ -250,6 +250,25 @@
 	{ 0, },
 };
 
+# ifdef MODULE
+static struct isapnp_card_id ns558_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID, card_device: ISAPNP_ANY_ID,
+        	devs: {	ISAPNP_DEVICE_ID('C', 'T', 'L', 0x7002) },
+	},
+	{
+		card_vendor: ISAPNP_ANY_ID, card_device: ISAPNP_ANY_ID,
+        	devs: {	ISAPNP_DEVICE_ID('C', 'S', 'C', 0x0b35) },
+	},
+	{
+		card_vendor: ISAPNP_ANY_ID, card_device: ISAPNP_ANY_ID,
+        	devs: {	ISAPNP_DEVICE_ID('P', 'N', 'P', 0x80f8) },
+	},
+	{ ISAPNP_CARD_END }
+};
+ISAPNP_CARD_TABLE(ns558_isa_ids);
+#endif /* MODULE */
+
 static struct ns558* ns558_pnp_probe(struct pci_dev *dev, struct ns558 *next)
 {
 	int ioport, iolen;
--- linux-2.4.0-test11/drivers/ide/ide-pnp.c	Wed May 24 18:38:26 2000
+++ linux/drivers/ide/ide-pnp.c	Fri Nov 24 14:56:34 2000
@@ -19,6 +19,7 @@
 #include <linux/ide.h>
 #include <linux/init.h>
 
+#include <linux/module.h>
 #include <linux/isapnp.h>
 
 #ifndef PREPARE_FUNC
@@ -88,6 +89,16 @@
 };
 
 #ifdef MODULE
+static struct isapnp_card_id ide_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: {	ISAPNP_DEVICE_ID('P', 'N', 'P', 0x0600) },
+	},
+	{ ISAPNP_CARD_END }
+};
+ISAPNP_CARD_TABLE(ide_isa_ids);
+
 #define NR_PNP_DEVICES 8
 struct pnp_dev_inst {
 	struct pci_dev *dev;
--- linux-2.4.0-test11/drivers/media/radio/radio-cadet.c	Fri Nov 17 17:56:51 2000
+++ linux/drivers/media/radio/radio-cadet.c	Fri Nov 24 13:49:15 2000
@@ -48,11 +48,22 @@
 static int cadet_probe(void);
 #endif
 
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || defined(CONFIG_ISAPNP_MODULE)
 #include <linux/isapnp.h>
 
 struct pci_dev *dev;
 static int isapnp_cadet_probe(void);
+
+# ifdef MODULE
+static struct isapnp_card_id cadet_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID, card_device: ISAPNP_ANY_ID,
+                devs: { ISAPNP_DEVICE_ID('M', 'S', 'M', 0x0c24) },
+	},
+	{ ISAPNP_CARD_END }
+};
+ISAPNP_CARD_TABLE(cadet_isa_ids);
+# endif /* MODULE */
 #endif
 
 /*
@@ -551,7 +562,7 @@
 	ioctl:		cadet_ioctl,
 };
 
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || defined(CONFIG_ISAPNP_MODULE)
 static int isapnp_cadet_probe(void)
 {
 	dev = isapnp_find_dev (NULL, ISAPNP_VENDOR('M','S','M'),
--- linux-2.4.0-test11/drivers/net/3c509.c	Tue Nov 14 13:16:37 2000
+++ linux/drivers/net/3c509.c	Fri Nov 24 13:54:28 2000
@@ -66,6 +66,7 @@
 #include <linux/skbuff.h>
 #include <linux/delay.h>	/* for udelay() */
 #include <linux/spinlock.h>
+#include <linux/init.h>
 
 #include <asm/bitops.h>
 #include <asm/io.h>
@@ -183,6 +184,34 @@
 	{0, }
 };
 static u16 el3_isapnp_phys_addr[8][3];
+
+# ifdef MODULE
+static struct isapnp_card_id el3_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID, card_device: ISAPNP_ANY_ID,
+        devs: {	ISAPNP_DEVICE_ID('T', 'C', 'M', 0x5090) },
+	},
+	{
+		card_vendor: ISAPNP_ANY_ID, card_device: ISAPNP_ANY_ID,
+        devs: {	ISAPNP_DEVICE_ID('T', 'C', 'M', 0x5091) },
+	},
+	{
+		card_vendor: ISAPNP_ANY_ID, card_device: ISAPNP_ANY_ID,
+        devs: {	ISAPNP_DEVICE_ID('T', 'C', 'M', 0x5094) },
+	},
+	{
+		card_vendor: ISAPNP_ANY_ID, card_device: ISAPNP_ANY_ID,
+        devs: {	ISAPNP_DEVICE_ID('T', 'C', 'M', 0x5098) },
+	},
+	{
+		card_vendor: ISAPNP_ANY_ID, card_device: ISAPNP_ANY_ID,
+        devs: {	ISAPNP_DEVICE_ID('P', 'N', 'P', 0x80f8) },
+	},
+	{ ISAPNP_CARD_END }
+};
+ISAPNP_CARD_TABLE(el3_isa_ids);
+# endif /* MODULE */
+
 #endif /* CONFIG_ISAPNP */
 #ifdef __ISAPNP__
 static int nopnp;
--- linux-2.4.0-test11/drivers/net/3c515.c	Tue Nov 14 13:16:37 2000
+++ linux/drivers/net/3c515.c	Fri Nov 24 13:40:27 2000
@@ -60,6 +60,7 @@
 #include <linux/malloc.h>
 #include <linux/interrupt.h>
 #include <linux/timer.h>
+#include <linux/init.h>
 #include <asm/bitops.h>
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -360,6 +361,19 @@
 	{ISAPNP_VENDOR('T', 'C', 'M'), ISAPNP_FUNCTION(0x5051), "3Com Fast EtherLink ISA"},
 	{0, }
 };
+
+# ifdef MODULE
+static struct isapnp_card_id corkscrew_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: {	ISAPNP_DEVICE_ID('T', 'C', 'M', 0x5051) },
+	},
+	{ ISAPNP_CARD_END }
+};
+ISAPNP_CARD_TABLE(corkscrew_isa_ids);
+# endif
+
 int corkscrew_isapnp_phys_addr[3] = {
 	0, 0, 0
 };
--- linux-2.4.0-test11/drivers/net/aironet4500_card.c	Tue Nov  7 11:02:24 2000
+++ linux/drivers/net/aironet4500_card.c	Fri Nov 24 13:39:44 2000
@@ -38,6 +38,8 @@
 #include <linux/if_arp.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/isapnp.h>
 
 #include "aironet4500.h"
 
@@ -59,6 +61,40 @@
 
 #include <linux/pci.h>
 
+#ifdef MODULE
+static struct pci_device_id aironet4500_card_pci_tbl[] __initdata = {
+	{
+	  vendor: PCI_VENDOR_ID_AIRONET,
+	  device: PCI_DEVICE_AIRONET_4800_1,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: PCI_VENDOR_ID_AIRONET,
+	  device: PCI_DEVICE_AIRONET_4800,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{
+	  vendor: PCI_VENDOR_ID_AIRONET,
+	  device: PCI_DEVICE_AIRONET_4500,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	},
+	{ }			/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, aironet4500_card_pci_tbl);
+
+static struct isapnp_card_id awc4500_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: {	ISAPNP_DEVICE_ID('A', 'W', 'L', 0x0001) },
+	},
+	{ ISAPNP_CARD_END }
+};
+ISAPNP_CARD_TABLE(awc4500_isa_ids);
+#endif
 
 static int reverse_probe;
 
--- linux-2.4.0-test11/drivers/net/ne.c	Tue Nov  7 11:02:24 2000
+++ linux/drivers/net/ne.c	Fri Nov 24 13:32:54 2000
@@ -83,6 +83,24 @@
 	{0,}
 };
 
+#ifdef MODULE
+static struct isapnp_card_id ne_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: {	ISAPNP_DEVICE_ID('E', 'D', 'I', 0x0216) },
+	},
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: {	ISAPNP_DEVICE_ID('P', 'N', 'P', 0x80d6) },
+	},
+	{ ISAPNP_CARD_END }
+};
+ISAPNP_CARD_TABLE(ne_isa_ids);
+#endif
+
+
 #ifdef SUPPORT_NE_BAD_CLONES
 /* A list of bad clones that we none-the-less recognize. */
 static struct { const char *name8, *name16; unsigned char SAprefix[4];}
--- linux-2.4.0-test11/drivers/net/sb1000.c	Tue Jul 18 16:09:27 2000
+++ linux/drivers/net/sb1000.c	Fri Nov 24 13:41:02 2000
@@ -57,6 +57,7 @@
 #include <asm/uaccess.h>
 #include <linux/etherdevice.h>
 #include <linux/isapnp.h>
+#include <linux/init.h>
 
 /* for SIOGCM/SIOSCM stuff */
 
@@ -71,6 +72,18 @@
 static const int SB1000_IO_EXTENT = 8;
 /* SB1000 Maximum Receive Unit */
 static const int SB1000_MRU = 1500; /* octects */
+
+#ifdef MODULE
+static struct isapnp_card_id ncr5380_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: {	ISAPNP_DEVICE_ID('G', 'I', 'C', 0x1000) },
+	},
+	{ ISAPNP_CARD_END }
+};
+ISAPNP_CARD_TABLE(ncr5380_isa_ids);
+#endif
 
 #define NPIDS 4
 struct sb1000_private {
--- linux-2.4.0-test11/drivers/scsi/aha1542.c	Sat Nov 11 19:01:11 2000
+++ linux/drivers/scsi/aha1542.c	Fri Nov 24 13:24:39 2000
@@ -51,6 +51,20 @@
 
 #include "aha1542.h"
 
+#ifdef MODULE
+static struct isapnp_card_id aha1542_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: {	ISAPNP_DEVICE_ID('A', 'D', 'P', 0x1542) },
+	},
+	{
+		ISAPNP_CARD_END,
+	}
+};
+ISAPNP_CARD_TABLE(aha1542_isa_ids);
+#endif
+
 #define SCSI_PA(address) virt_to_bus(address)
 
 static void BAD_DMA(void *address, unsigned int length)
--- linux-2.4.0-test11/drivers/scsi/g_NCR5380.c	Sat Nov 11 19:01:11 2000
+++ linux/drivers/scsi/g_NCR5380.c	Fri Nov 24 13:45:38 2000
@@ -146,6 +146,18 @@
 
 #define NO_OVERRIDES (sizeof(overrides) / sizeof(struct override))
 
+#ifdef MODULE
+static struct isapnp_card_id ncr5380_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: {	ISAPNP_DEVICE_ID('D', 'T', 'C', 0x436e) },
+	},
+	{ ISAPNP_CARD_END }
+};
+ISAPNP_CARD_TABLE(ncr5380_isa_ids);
+#endif
+
 /*
  * Function : static internal_setup(int board, char *str, int *ints)
  *
--- linux-2.4.0-test11/drivers/sound/ad1816.c	Thu Nov 16 12:51:28 2000
+++ linux/drivers/sound/ad1816.c	Fri Nov 24 13:26:31 2000
@@ -1325,6 +1325,25 @@
 	{0}
 };
 
+#ifdef MODULE
+static struct isapnp_card_id ad1816_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: {	ISAPNP_DEVICE_ID('A', 'D', 'S', 0x7150) },
+	},
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: {	ISAPNP_DEVICE_ID('A', 'D', 'S', 0x7180) },
+	},
+	{
+		ISAPNP_CARD_END,
+	}
+};
+ISAPNP_CARD_TABLE(ad1816_isa_ids);
+#endif
+
 static int __init ad1816_init_isapnp(struct address_info *hw_config,
 	struct pci_bus *bus, struct pci_dev *card, int slot)
 {
--- linux-2.4.0-test11/drivers/sound/awe_wave.c	Thu Nov 16 12:51:28 2000
+++ linux/drivers/sound/awe_wave.c	Fri Nov 24 13:11:47 2000
@@ -4782,6 +4782,29 @@
 	{0,}
 };
 
+static struct isapnp_card_id awe_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: { ISAPNP_DEVICE_ID('A', 'W', 'E', 0x0021) }
+	},
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: { ISAPNP_DEVICE_ID('A', 'W', 'E', 0x0022) }
+	},
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: { ISAPNP_DEVICE_ID('A', 'W', 'E', 0x0023) }
+	},
+	{
+		ISAPNP_CARD_END,
+	}
+};
+ISAPNP_CARD_TABLE(awe_isa_ids);
+
+
 static struct pci_dev *idev = NULL;
 
 static int __init awe_probe_isapnp(int *port)
--- linux-2.4.0-test11/drivers/sound/sb_card.c	Wed Sep 27 13:53:56 2000
+++ linux/drivers/sound/sb_card.c	Fri Nov 24 13:38:21 2000
@@ -477,6 +477,298 @@
 	{0}
 };
 
+#if defined(CONFIG_ISAPNP) || defined(CONFIG_ISAPNP_MODULE)
+static struct isapnp_card_id sb_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: {
+			ISAPNP_DEVICE_ID('Q', 'T', 'I', 0x0110),
+			ISAPNP_DEVICE_ID('Q', 'T', 'I', 0x0310),
+			ISAPNP_DEVICE_ID('Q', 'T', 'I', 0x0410),
+		},
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x0024),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0031),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x0025),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0031),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x0026),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0031),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x0027),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0031),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x0028),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0031),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x0029),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0031),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x002a),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0031),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x002b),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0031),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x0051),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0001),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x0070),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0001),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x0080),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0041),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x00F0),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0043),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x0039),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0031),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x0042),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0031),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x0043),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0031),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x0044),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0031),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x0048),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0031),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x0054),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0031),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x009C),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0041),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x009F),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0041),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x009D),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0042),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x009E),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0044),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x00B2),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0044),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x00C1),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0042),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x00C3),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0045),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x00C5),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0045),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x00C7),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0045),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','T','L', 0x00E4),
+		devs: {
+			ISAPNP_DEVICE_ID('C','T','L', 0x0045),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('E','S','S', 0x0968),
+		devs: {
+			ISAPNP_DEVICE_ID('E','S','S', 0x0968),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('E','S','S', 0x1868),
+		devs: {
+			ISAPNP_DEVICE_ID('E','S','S', 0x1868),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('E','S','S', 0x1868),
+		devs: {
+			ISAPNP_DEVICE_ID('E','S','S', 0x8611),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('E','S','S', 0x0003),
+		devs: {
+			ISAPNP_DEVICE_ID('E','S','S', 0x1869),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('E','S','S', 0x1869),
+		devs: {
+			ISAPNP_DEVICE_ID('E','S','S', 0x1869),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('E','S','S', 0x1878),
+		devs: {
+			ISAPNP_DEVICE_ID('E','S','S', 0x1878),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('E','S','S', 0x1879),
+		devs: {
+			ISAPNP_DEVICE_ID('E','S','S', 0x1879),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('C','M','I', 0x0001),
+		devs: {
+			ISAPNP_DEVICE_ID('@','X','@', 0x0001),
+			ISAPNP_DEVICE_ID('@','H','@', 0x0001),
+			ISAPNP_DEVICE_ID('@','@','@', 0x0001),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('R','W','B', 0x1688),
+		devs: {
+			ISAPNP_DEVICE_ID('@','@','@', 0x0001),
+			ISAPNP_DEVICE_ID('@','X','@', 0x0001),
+			ISAPNP_DEVICE_ID('@','H','@', 0x0001),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('A','L','S', 0x0007),
+		devs: {
+			ISAPNP_DEVICE_ID('@','@','@', 0x0001),
+			ISAPNP_DEVICE_ID('@','X','@', 0x0001),
+			ISAPNP_DEVICE_ID('@','H','@', 0x0001),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('A','L','S', 0x0001),
+		devs: {
+			ISAPNP_DEVICE_ID('@','@','@', 0x0001),
+			ISAPNP_DEVICE_ID('@','X','@', 0x0001),
+			ISAPNP_DEVICE_ID('@','H','@', 0x0001),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('A','L','S', 0x0110),
+		devs: {
+			ISAPNP_DEVICE_ID('@','@','@', 0x1001),
+			ISAPNP_DEVICE_ID('@','X','@', 0x1001),
+			ISAPNP_DEVICE_ID('@','H','@', 0x0001),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('A','L','S', 0x0120),
+		devs: {
+			ISAPNP_DEVICE_ID('@','@','@', 0x2001),
+			ISAPNP_DEVICE_ID('@','X','@', 0x2001),
+			ISAPNP_DEVICE_ID('@','H','@', 0x0001),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('A','L','S', 0x0200),
+		devs: {
+			ISAPNP_DEVICE_ID('@','@','@', 0x0020),
+			ISAPNP_DEVICE_ID('@','X','@', 0x0020),
+			ISAPNP_DEVICE_ID('@','H','@', 0x0001),
+		}
+	},
+	{
+		ISAPNP_CARD_ID('R','T','L', 0x3000),
+		devs: {
+			ISAPNP_DEVICE_ID('@','@','@', 0x2001),
+			ISAPNP_DEVICE_ID('@','X','@', 0x2001),
+			ISAPNP_DEVICE_ID('@','H','@', 0x0001),
+		}
+	},
+	{
+		ISAPNP_CARD_END,
+	}
+};
+ISAPNP_CARD_TABLE(sb_isa_ids);
+#endif
+
 static struct pci_dev *activate_dev(char *devname, char *resname, struct pci_dev *dev)
 {
 	int err;
--- linux-2.4.0-test11/drivers/telephony/ixj.c	Wed Nov 15 00:41:03 2000
+++ linux/drivers/telephony/ixj.c	Fri Nov 24 13:49:38 2000
@@ -37,8 +37,8 @@
  *
  ***************************************************************************/
 
-static char ixj_c_rcsid[] = "$Id: ixj.c,v 3.31 2000/04/14 19:24:47 jaugenst Exp $";
-static char ixj_c_revision[] = "$Revision: 3.31 $";
+static char ixj_c_rcsid[] = "$Id$";
+static char ixj_c_revision[] = "$Revision$";
 
 //#define PERFMON_STATS
 #define IXJDEBUG 0
@@ -75,7 +75,7 @@
 #include <pcmcia/ds.h>
 #endif
 
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || defined(CONFIG_ISAPNP_MODULE)
 #include <linux/isapnp.h>
 #endif
 
@@ -90,6 +90,35 @@
 
 MODULE_PARM(ixjdebug, "i");
 
+#ifdef MODULE
+static struct pci_device_id ixj_pci_tbl[] __initdata = {
+  {
+    vendor: 0x15E2,
+    device: 0x0500,
+    subvendor: PCI_ANY_ID,
+    subdevice: PCI_ANY_ID,
+  },
+  { }				/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(pci, ixj_pci_tbl);
+
+# if defined(CONFIG_ISAPNP) || defined(CONFIG_ISAPNP_MODULE)
+static struct isapnp_card_id ixj_isa_ids[] __initdata = {
+	{
+		card_vendor: ISAPNP_ANY_ID,
+		card_device: ISAPNP_ANY_ID,
+                devs: {
+			ISAPNP_DEVICE_ID('Q', 'T', 'I', 0x0110),
+			ISAPNP_DEVICE_ID('Q', 'T', 'I', 0x0310),
+			ISAPNP_DEVICE_ID('Q', 'T', 'I', 0x0410),
+		},
+	},
+	{ ISAPNP_CARD_END }
+};
+ISAPNP_CARD_TABLE(ixj_isa_ids);
+# endif
+#endif /* MODULE */
+
 static IXJ ixj[IXJMAX];
 
 static struct timer_list ixj_timer;
@@ -6107,7 +6136,7 @@
 			kfree(ixj[cnt].read_buffer);
 		if (ixj[cnt].write_buffer)
 			kfree(ixj[cnt].write_buffer);
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || defined(CONFIG_ISAPNP_MODULE)
 		if (ixj[cnt].dev)
 			ixj[cnt].dev->deactivate(ixj[cnt].dev);
 #endif
@@ -6229,7 +6258,7 @@
 	int i = 0;
 	int cnt = 0;
 	int probe = 0;
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || defined(CONFIG_ISAPNP_MODULE)
 	int func = 0x110;
 	struct pci_dev *dev = NULL, *old_dev = NULL;
 #endif
@@ -6247,7 +6276,7 @@
 	register_pcmcia_driver(&dev_info, &ixj_attach, &ixj_detach);
 	probe = 0;
 #else
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || defined(CONFIG_ISAPNP_MODULE)
 	while (1) {
 		do {
 			old_dev = dev;

--9amGYk9869ThD9tj--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
