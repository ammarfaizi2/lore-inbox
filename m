Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbUBZDWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 22:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbUBZDUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 22:20:33 -0500
Received: from palrel10.hp.com ([156.153.255.245]:24201 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262649AbUBZDQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 22:16:50 -0500
Date: Wed, 25 Feb 2004 19:16:49 -0800
To: "David S. Miller" <davem@redhat.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6 IrDA] static_via
Message-ID: <20040226031649.GI32263@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

irXXX_static_via.diff :
~~~~~~~~~~~~~~~~~~~~~
		<Patch from Stephen Hemminger>
	o [FEATURE] make more symbol static (namespace pollution)
	o [FEATURE] remove unused code


diff -Nru a/drivers/net/irda/via-ircc.c b/drivers/net/irda/via-ircc.c
--- a/drivers/net/irda/via-ircc.c	Mon Jan 26 14:35:44 2004
+++ b/drivers/net/irda/via-ircc.c	Mon Jan 26 14:35:44 2004
@@ -103,14 +103,14 @@
 static void via_ircc_change_dongle_speed(int iobase, int speed,
 					 int dongle_id);
 static int RxTimerHandler(struct via_ircc_cb *self, int iobase);
-void hwreset(struct via_ircc_cb *self);
+static void hwreset(struct via_ircc_cb *self);
 static int via_ircc_dma_xmit(struct via_ircc_cb *self, u16 iobase);
 static int upload_rxdata(struct via_ircc_cb *self, int iobase);
 static int __devinit via_init_one (struct pci_dev *pcidev, const struct pci_device_id *id);
 static void __exit via_remove_one (struct pci_dev *pdev);
 
 /* Should use udelay() instead, even if we are x86 only - Jean II */
-void iodelay(int udelay)
+static void iodelay(int udelay)
 {
 	u8 data;
 	int i;
@@ -1397,7 +1397,7 @@
 	return IRQ_RETVAL(iHostIntType);
 }
 
-void hwreset(struct via_ircc_cb *self)
+static void hwreset(struct via_ircc_cb *self)
 {
 	int iobase;
 	iobase = self->io.fir_base;
diff -Nru a/drivers/net/irda/via-ircc.h b/drivers/net/irda/via-ircc.h
--- a/drivers/net/irda/via-ircc.h	Mon Jan 26 14:35:44 2004
+++ b/drivers/net/irda/via-ircc.h	Mon Jan 26 14:35:44 2004
@@ -194,14 +194,7 @@
 #define Rd_Valid 0x08
 #define RxBit 0x08
 
-__u8 ReadPCIByte(__u8, __u8, __u8, __u8);
-__u32 ReadPCI(__u8, __u8, __u8, __u8);
-void WritePCI(__u8, __u8, __u8, __u8, __u32);
-void WritePCIByte(__u8, __u8, __u8, __u8, __u8);
-int mySearchPCI(__u8 *, __u16, __u16);
-
-
-void DisableDmaChannel(unsigned int channel)
+static void DisableDmaChannel(unsigned int channel)
 {
 	switch (channel) {	// 8 Bit DMA channels DMAC1
 	case 0:
@@ -230,7 +223,7 @@
 	};			//Switch
 }
 
-unsigned char ReadLPCReg(int iRegNum)
+static unsigned char ReadLPCReg(int iRegNum)
 {
 	unsigned char iVal;
 
@@ -243,7 +236,7 @@
 	return iVal;
 }
 
-void WriteLPCReg(int iRegNum, unsigned char iVal)
+static void WriteLPCReg(int iRegNum, unsigned char iVal)
 {
 
 	outb(0x87, 0x2e);
@@ -253,17 +246,17 @@
 	outb(0xAA, 0x2e);
 }
 
-__u8 ReadReg(unsigned int BaseAddr, int iRegNum)
+static __u8 ReadReg(unsigned int BaseAddr, int iRegNum)
 {
 	return ((__u8) inb(BaseAddr + iRegNum));
 }
 
-void WriteReg(unsigned int BaseAddr, int iRegNum, unsigned char iVal)
+static void WriteReg(unsigned int BaseAddr, int iRegNum, unsigned char iVal)
 {
 	outb(iVal, BaseAddr + iRegNum);
 }
 
-int WriteRegBit(unsigned int BaseAddr, unsigned char RegNum,
+static int WriteRegBit(unsigned int BaseAddr, unsigned char RegNum,
 		unsigned char BitPos, unsigned char value)
 {
 	__u8 Rtemp, Wtemp;
@@ -286,7 +279,7 @@
 	return 0;
 }
 
-__u8 CheckRegBit(unsigned int BaseAddr, unsigned char RegNum,
+static __u8 CheckRegBit(unsigned int BaseAddr, unsigned char RegNum,
 		 unsigned char BitPos)
 {
 	__u8 temp;
@@ -300,122 +293,7 @@
 	return GetBit(temp, BitPos);
 }
 
-__u8 ReadPCIByte(__u8 bus, __u8 device, __u8 fun, __u8 reg)
-{
-	__u32 dTmp;
-	__u8 bData, bTmp;
-
-	bTmp = reg & ~0x03;
-	dTmp = ReadPCI(bus, device, fun, bTmp);
-	bTmp = reg & 0x03;
-	bData = (__u8) (dTmp >> bTmp);
-	return bData;
-}
-
-__u32 ReadPCI(__u8 bus, __u8 device, __u8 fun, __u8 reg)
-{
-	__u32 CONFIG_ADDR, temp, data;
-
-	if ((bus == 0xff) || (device == 0xff) || (fun == 0xff))
-		return 0xffffffff;
-	CONFIG_ADDR = 0x80000000;
-	temp = (__u32) reg << 2;
-	CONFIG_ADDR = CONFIG_ADDR | temp;
-	temp = (__u32) fun << 8;
-	CONFIG_ADDR = CONFIG_ADDR | temp;
-	temp = (__u32) device << 11;
-	CONFIG_ADDR = CONFIG_ADDR | temp;
-	temp = (__u32) bus << 16;
-	CONFIG_ADDR = CONFIG_ADDR | temp;
-
-	outl(PCI_CONFIG_ADDRESS, CONFIG_ADDR);
-	data = inl(PCI_CONFIG_DATA);
-	return data;
-}
-
-
-void WritePCIByte(__u8 bus, __u8 device, __u8 fun, __u8 reg,
-		  __u8 CONFIG_DATA)
-{
-	__u32 dTmp, dTmp1 = 0;
-	__u8 bTmp;
-
-	bTmp = reg & ~0x03;
-	dTmp = ReadPCI(bus, device, fun, bTmp);
-	switch (reg & 0x03) {
-	case 0:
-		dTmp1 = (dTmp & ~0xff) | CONFIG_DATA;
-		break;
-	case 1:
-		dTmp = (dTmp & ~0x00ff00);
-		dTmp1 = CONFIG_DATA;
-		dTmp1 = dTmp1 << 8;
-		dTmp1 = dTmp1 | dTmp;
-		break;
-	case 2:
-		dTmp = (dTmp & ~0xff0000);
-		dTmp1 = CONFIG_DATA;
-		dTmp1 = dTmp1 << 16;
-		dTmp1 = dTmp1 | dTmp;
-		break;
-	case 3:
-		dTmp = (dTmp & ~0xff000000);
-		dTmp1 = CONFIG_DATA;
-		dTmp1 = dTmp1 << 24;
-		dTmp1 = dTmp1 | dTmp;
-		break;
-	}
-	WritePCI(bus, device, fun, bTmp, dTmp1);
-}
-
-//------------------
-void WritePCI(__u8 bus, __u8 device, __u8 fun, __u8 reg, __u32 CONFIG_DATA)
-{
-	__u32 CONFIG_ADDR, temp;
-
-	if ((bus == 0xff) || (device == 0xff) || (fun == 0xff))
-		return;
-	CONFIG_ADDR = 0x80000000;
-	temp = (__u32) reg << 2;
-	CONFIG_ADDR = CONFIG_ADDR | temp;
-	temp = (__u32) fun << 8;
-	CONFIG_ADDR = CONFIG_ADDR | temp;
-	temp = (__u32) device << 11;
-	CONFIG_ADDR = CONFIG_ADDR | temp;
-	temp = (__u32) bus << 16;
-	CONFIG_ADDR = CONFIG_ADDR | temp;
-
-	outl(PCI_CONFIG_ADDRESS, CONFIG_ADDR);
-	outl(PCI_CONFIG_DATA, CONFIG_DATA);
-
-}
-
-											// find device with DeviceID and VenderID                                       // if match return three byte buffer (bus,device,function)                      // no found, address={99,99,99} 
-int mySearchPCI(__u8 * SBridpos, __u16 VID, __u16 DID)
-{
-	__u8 i, j, k;
-	__u16 FindDeviceID, FindVenderID;
-
-	for (k = 0; k < 8; k++) {	//scan function
-		i = 0;
-		j = 0x11;
-		k = 0;
-		if (ReadPCI(i, j, k, 0) < 0xffffffff) {	// not empty
-			FindDeviceID = (__u16) (ReadPCI(i, j, k, 0) >> 16);
-			FindVenderID =
-			    (__u16) (ReadPCI(i, j, k, 0) & 0x0000ffff);
-			if ((VID == FindVenderID) && (DID == FindDeviceID)) {
-				SBridpos[0] = i;	// bus
-				SBridpos[1] = j;	//device
-				SBridpos[2] = k;	//func
-				return 1;
-			}
-		}
-	}
-	return 0;
-}
-
-void SetMaxRxPacketSize(__u16 iobase, __u16 size)
+static void SetMaxRxPacketSize(__u16 iobase, __u16 size)
 {
 	__u16 low, high;
 	if ((size & 0xe000) == 0) {
@@ -430,7 +308,7 @@
 
 //for both Rx and Tx
 
-void SetFIFO(__u16 iobase, __u16 value)
+static void SetFIFO(__u16 iobase, __u16 value)
 {
 	switch (value) {
 	case 128:
@@ -541,7 +419,7 @@
 #define GetFIRVersion(BaseAddr)		ReadReg(BaseAddr,VERSION)
 
 
-void SetTimer(__u16 iobase, __u8 count)
+static void SetTimer(__u16 iobase, __u8 count)
 {
 	EnTimerInt(iobase, OFF);
 	WriteReg(iobase, TIMER, count);
@@ -549,7 +427,7 @@
 }
 
 
-void SetSendByte(__u16 iobase, __u32 count)
+static void SetSendByte(__u16 iobase, __u32 count)
 {
 	__u32 low, high;
 
@@ -561,7 +439,7 @@
 	}
 }
 
-void ResetChip(__u16 iobase, __u8 type)
+static void ResetChip(__u16 iobase, __u8 type)
 {
 	__u8 value;
 
@@ -569,16 +447,7 @@
 	WriteReg(iobase, RESET, type);
 }
 
-void SetAddrMode(__u16 iobase, __u8 mode)
-{
-	__u8 bTmp = 0;
-	if (mode < 3) {
-		bTmp = (ReadReg(iobase, RX_CT) & 0xcf) | (mode << 4);
-		WriteReg(iobase, RX_CT, bTmp);
-	}
-}
-
-int CkRxRecv(__u16 iobase, struct via_ircc_cb *self)
+static int CkRxRecv(__u16 iobase, struct via_ircc_cb *self)
 {
 	__u8 low, high;
 	__u16 wTmp = 0, wTmp1 = 0, wTmp_new = 0;
@@ -599,7 +468,7 @@
 
 }
 
-__u16 RxCurCount(__u16 iobase, struct via_ircc_cb * self)
+static __u16 RxCurCount(__u16 iobase, struct via_ircc_cb * self)
 {
 	__u8 low, high;
 	__u16 wTmp = 0, wTmp1 = 0;
@@ -615,7 +484,7 @@
  * for it will update last count.
  */
 
-__u16 GetRecvByte(__u16 iobase, struct via_ircc_cb * self)
+static __u16 GetRecvByte(__u16 iobase, struct via_ircc_cb * self)
 {
 	__u8 low, high;
 	__u16 wTmp, wTmp1, ret;
@@ -645,23 +514,7 @@
 	return ret;
 }
 
-
-__u16 GetRecvLen(__u16 iobase)
-{
-	__u8 low, high;
-	__u16 temp;
-
-	low = ReadReg(iobase, RX_P_L);
-	high = ReadReg(iobase, RX_P_H);
-
-	if (!(high & 0xe000)) {
-		temp = (high << 8) + low;
-		return temp;
-	} else
-		return 0;
-}
-
-void Sdelay(__u16 scale)
+static void Sdelay(__u16 scale)
 {
 	__u8 bTmp;
 	int i, j;
@@ -674,7 +527,7 @@
 	}
 }
 
-void Tdelay(__u16 scale)
+static void Tdelay(__u16 scale)
 {
 	__u8 bTmp;
 	int i, j;
@@ -688,7 +541,7 @@
 }
 
 
-void ActClk(__u16 iobase, __u8 value)
+static void ActClk(__u16 iobase, __u8 value)
 {
 	__u8 bTmp;
 	bTmp = ReadReg(iobase, 0x34);
@@ -698,18 +551,7 @@
 		WriteReg(iobase, 0x34, bTmp & ~Clk_bit);
 }
 
-void ActTx(__u16 iobase, __u8 value)
-{
-	__u8 bTmp;
-
-	bTmp = ReadReg(iobase, 0x34);
-	if (value)
-		WriteReg(iobase, 0x34, bTmp | Tx_bit);
-	else
-		WriteReg(iobase, 0x34, bTmp & ~Tx_bit);
-}
-
-void ClkTx(__u16 iobase, __u8 Clk, __u8 Tx)
+static void ClkTx(__u16 iobase, __u8 Clk, __u8 Tx)
 {
 	__u8 bTmp;
 
@@ -731,7 +573,7 @@
 	WriteReg(iobase, 0x34, bTmp);
 }
 
-void Wr_Byte(__u16 iobase, __u8 data)
+static void Wr_Byte(__u16 iobase, __u8 data)
 {
 	__u8 bData = data;
 //      __u8 btmp;
@@ -757,7 +599,7 @@
 	}
 }
 
-__u8 Rd_Indx(__u16 iobase, __u8 addr, __u8 index)
+static __u8 Rd_Indx(__u16 iobase, __u8 addr, __u8 index)
 {
 	__u8 data = 0, bTmp, data_bit;
 	int i;
@@ -821,7 +663,7 @@
 	return data;
 }
 
-void Wr_Indx(__u16 iobase, __u8 addr, __u8 index, __u8 data)
+static void Wr_Indx(__u16 iobase, __u8 addr, __u8 index, __u8 data)
 {
 	int i;
 	__u8 bTmp;
@@ -842,7 +684,7 @@
 	ActClk(iobase, 0);
 }
 
-void ResetDongle(__u16 iobase)
+static void ResetDongle(__u16 iobase)
 {
 	int i;
 	ClkTx(iobase, 0, 0);
@@ -856,7 +698,7 @@
 	ActClk(iobase, 0);
 }
 
-void SetSITmode(__u16 iobase)
+static void SetSITmode(__u16 iobase)
 {
 
 	__u8 bTmp;
@@ -868,7 +710,7 @@
 	WriteReg(iobase, 0x28, bTmp | 0x80);	// enable All interrupt
 }
 
-void SI_SetMode(__u16 iobase, int mode)
+static void SI_SetMode(__u16 iobase, int mode)
 {
 	//__u32 dTmp;
 	__u8 bTmp;
@@ -883,7 +725,7 @@
 	bTmp = Rd_Indx(iobase, 0x40, 1);
 }
 
-void InitCard(__u16 iobase)
+static void InitCard(__u16 iobase)
 {
 	ResetChip(iobase, 5);
 	WriteReg(iobase, I_ST_CT_0, 0x00);	// open CHIP on
@@ -891,12 +733,7 @@
 	SetSIREOF(iobase, 0xc1);
 }
 
-void CommonShutDown(__u16 iobase, __u8 TxDMA)
-{
-	DisableDmaChannel(TxDMA);
-}
-
-void CommonInit(__u16 iobase)
+static void CommonInit(__u16 iobase)
 {
 //  EnTXCRC(iobase,0);
 	SwapDMA(iobase, OFF);
@@ -921,7 +758,7 @@
 	EnableDMA(iobase, ON);
 }
 
-void SetBaudRate(__u16 iobase, __u32 rate)
+static void SetBaudRate(__u16 iobase, __u32 rate)
 {
 	__u8 value = 11, temp;
 
@@ -958,7 +795,7 @@
 	WriteReg(iobase, I_CF_H_1, temp);
 }
 
-void SetPulseWidth(__u16 iobase, __u8 width)
+static void SetPulseWidth(__u16 iobase, __u8 width)
 {
 	__u8 temp, temp1, temp2;
 
@@ -972,7 +809,7 @@
 	WriteReg(iobase, I_CF_H_1, temp1);
 }
 
-void SetSendPreambleCount(__u16 iobase, __u8 count)
+static void SetSendPreambleCount(__u16 iobase, __u8 count)
 {
 	__u8 temp;
 
@@ -982,7 +819,7 @@
 
 }
 
-void SetVFIR(__u16 BaseAddr, __u8 val)
+static void SetVFIR(__u16 BaseAddr, __u8 val)
 {
 	__u8 tmp;
 
@@ -991,7 +828,7 @@
 	WriteRegBit(BaseAddr, I_CF_H_0, 5, val);
 }
 
-void SetFIR(__u16 BaseAddr, __u8 val)
+static void SetFIR(__u16 BaseAddr, __u8 val)
 {
 	__u8 tmp;
 
@@ -1001,7 +838,7 @@
 	WriteRegBit(BaseAddr, I_CF_L_0, 6, val);
 }
 
-void SetMIR(__u16 BaseAddr, __u8 val)
+static void SetMIR(__u16 BaseAddr, __u8 val)
 {
 	__u8 tmp;
 
@@ -1011,7 +848,7 @@
 	WriteRegBit(BaseAddr, I_CF_L_0, 5, val);
 }
 
-void SetSIR(__u16 BaseAddr, __u8 val)
+static void SetSIR(__u16 BaseAddr, __u8 val)
 {
 	__u8 tmp;
 
@@ -1020,25 +857,5 @@
 	WriteReg(BaseAddr, I_CF_L_0, tmp & 0x8f);
 	WriteRegBit(BaseAddr, I_CF_L_0, 4, val);
 }
-
-void ClrHBusy(__u16 iobase)
-{
-
-	EnableDMA(iobase, OFF);
-	EnableDMA(iobase, ON);
-	RXStart(iobase, OFF);
-	RXStart(iobase, ON);
-	RXStart(iobase, OFF);
-	EnableDMA(iobase, OFF);
-	EnableDMA(iobase, ON);
-}
-
-void SetFifo64(__u16 iobase)
-{
-
-	WriteRegBit(iobase, I_CF_H_0, 0, 0);
-	WriteRegBit(iobase, I_CF_H_0, 7, 0);
-}
-
 
 #endif				/* via_IRCC_H */
