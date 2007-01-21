Return-Path: <linux-kernel-owner+w=401wt.eu-S1751567AbXAUNO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbXAUNO6 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 08:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbXAUNO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 08:14:57 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:47148 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbXAUNO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 08:14:56 -0500
Message-ID: <45B367AC.5000209@student.ltu.se>
Date: Sun, 21 Jan 2007 14:16:28 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: lnz@dandelion.com
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/scsi/BusLogic: Replace 'boolean' by 'bool'
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
---
"sed s/boolean/bool/" and remove "typedef bool boolean". Minor 
comment-alignment fixes.
BusLogic.c includes FlashPoint.c.
Compile-tested with "allyes" and "allmod" on i386.

 BusLogic.c   |   42 ++++----
 BusLogic.h   |  300 
++++++++++++++++++++++++++++-------------------------------
 FlashPoint.c |    4
 3 files changed, 170 insertions(+), 176 deletions(-)


diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index 3075204..34f55cf 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -192,7 +192,7 @@ static void BusLogic_InitializeCCBs(struct BusLogic_HostAdapter *HostAdapter, vo
   BusLogic_CreateInitialCCBs allocates the initial CCBs for Host Adapter.
 */
 
-static boolean __init BusLogic_CreateInitialCCBs(struct BusLogic_HostAdapter *HostAdapter)
+static bool __init BusLogic_CreateInitialCCBs(struct BusLogic_HostAdapter *HostAdapter)
 {
 	int BlockSize = BusLogic_CCB_AllocationGroupSize * sizeof(struct BusLogic_CCB);
 	void *BlockPointer;
@@ -238,7 +238,7 @@ static void BusLogic_DestroyCCBs(struct BusLogic_HostAdapter *HostAdapter)
   multiple host adapters share the same IRQ Channel.
 */
 
-static void BusLogic_CreateAdditionalCCBs(struct BusLogic_HostAdapter *HostAdapter, int AdditionalCCBs, boolean SuccessMessageP)
+static void BusLogic_CreateAdditionalCCBs(struct BusLogic_HostAdapter *HostAdapter, int AdditionalCCBs, bool SuccessMessageP)
 {
 	int BlockSize = BusLogic_CCB_AllocationGroupSize * sizeof(struct BusLogic_CCB);
 	int PreviouslyAllocated = HostAdapter->AllocatedCCBs;
@@ -639,9 +639,9 @@ static int __init BusLogic_InitializeMultiMasterProbeInfo(struct BusLogic_HostAd
 	struct BusLogic_ProbeInfo *PrimaryProbeInfo = &BusLogic_ProbeInfoList[BusLogic_ProbeInfoCount];
 	int NonPrimaryPCIMultiMasterIndex = BusLogic_ProbeInfoCount + 1;
 	int NonPrimaryPCIMultiMasterCount = 0, PCIMultiMasterCount = 0;
-	boolean ForceBusDeviceScanningOrder = false;
-	boolean ForceBusDeviceScanningOrderChecked = false;
-	boolean StandardAddressSeen[6];
+	bool ForceBusDeviceScanningOrder = false;
+	bool ForceBusDeviceScanningOrderChecked = false;
+	bool StandardAddressSeen[6];
 	struct pci_dev *PCI_Device = NULL;
 	int i;
 	if (BusLogic_ProbeInfoCount >= BusLogic_MaxHostAdapters)
@@ -1011,7 +1011,7 @@ static void __init BusLogic_InitializeProbeInfoList(struct BusLogic_HostAdapter
   BusLogic_Failure prints a standardized error message, and then returns false.
 */
 
-static boolean BusLogic_Failure(struct BusLogic_HostAdapter *HostAdapter, char *ErrorMessage)
+static bool BusLogic_Failure(struct BusLogic_HostAdapter *HostAdapter, char *ErrorMessage)
 {
 	BusLogic_AnnounceDriver(HostAdapter);
 	if (HostAdapter->HostAdapterBusType == BusLogic_PCI_Bus) {
@@ -1030,7 +1030,7 @@ static boolean BusLogic_Failure(struct BusLogic_HostAdapter *HostAdapter, char *
   BusLogic_ProbeHostAdapter probes for a BusLogic Host Adapter.
 */
 
-static boolean __init BusLogic_ProbeHostAdapter(struct BusLogic_HostAdapter *HostAdapter)
+static bool __init BusLogic_ProbeHostAdapter(struct BusLogic_HostAdapter *HostAdapter)
 {
 	union BusLogic_StatusRegister StatusRegister;
 	union BusLogic_InterruptRegister InterruptRegister;
@@ -1101,8 +1101,8 @@ static boolean __init BusLogic_ProbeHostAdapter(struct BusLogic_HostAdapter *Hos
   SCSI Bus Reset.
 */
 
-static boolean BusLogic_HardwareResetHostAdapter(struct BusLogic_HostAdapter
-						 *HostAdapter, boolean HardReset)
+static bool BusLogic_HardwareResetHostAdapter(struct BusLogic_HostAdapter
+						 *HostAdapter, bool HardReset)
 {
 	union BusLogic_StatusRegister StatusRegister;
 	int TimeoutCounter;
@@ -1205,11 +1205,11 @@ static boolean BusLogic_HardwareResetHostAdapter(struct BusLogic_HostAdapter
   Host Adapter.
 */
 
-static boolean __init BusLogic_CheckHostAdapter(struct BusLogic_HostAdapter *HostAdapter)
+static bool __init BusLogic_CheckHostAdapter(struct BusLogic_HostAdapter *HostAdapter)
 {
 	struct BusLogic_ExtendedSetupInformation ExtendedSetupInformation;
 	unsigned char RequestedReplyLength;
-	boolean Result = true;
+	bool Result = true;
 	/*
 	   FlashPoint Host Adapters do not require this protection.
 	 */
@@ -1239,7 +1239,7 @@ static boolean __init BusLogic_CheckHostAdapter(struct BusLogic_HostAdapter *Hos
   from Host Adapter and initializes the Host Adapter structure.
 */
 
-static boolean __init BusLogic_ReadHostAdapterConfiguration(struct BusLogic_HostAdapter
+static bool __init BusLogic_ReadHostAdapterConfiguration(struct BusLogic_HostAdapter
 							    *HostAdapter)
 {
 	struct BusLogic_BoardID BoardID;
@@ -1686,14 +1686,14 @@ static boolean __init BusLogic_ReadHostAdapterConfiguration(struct BusLogic_Host
   Host Adapter.
 */
 
-static boolean __init BusLogic_ReportHostAdapterConfiguration(struct BusLogic_HostAdapter
+static bool __init BusLogic_ReportHostAdapterConfiguration(struct BusLogic_HostAdapter
 							      *HostAdapter)
 {
 	unsigned short AllTargetsMask = (1 << HostAdapter->MaxTargetDevices) - 1;
 	unsigned short SynchronousPermitted, FastPermitted;
 	unsigned short UltraPermitted, WidePermitted;
 	unsigned short DisconnectPermitted, TaggedQueuingPermitted;
-	boolean CommonSynchronousNegotiation, CommonTaggedQueueDepth;
+	bool CommonSynchronousNegotiation, CommonTaggedQueueDepth;
 	char SynchronousString[BusLogic_MaxTargetDevices + 1];
 	char WideString[BusLogic_MaxTargetDevices + 1];
 	char DisconnectString[BusLogic_MaxTargetDevices + 1];
@@ -1835,7 +1835,7 @@ static boolean __init BusLogic_ReportHostAdapterConfiguration(struct BusLogic_Ho
   Host Adapter.
 */
 
-static boolean __init BusLogic_AcquireResources(struct BusLogic_HostAdapter *HostAdapter)
+static bool __init BusLogic_AcquireResources(struct BusLogic_HostAdapter *HostAdapter)
 {
 	if (HostAdapter->IRQ_Channel == 0) {
 		BusLogic_Error("NO LEGAL INTERRUPT CHANNEL ASSIGNED - DETACHING\n", HostAdapter);
@@ -1903,7 +1903,7 @@ static void BusLogic_ReleaseResources(struct BusLogic_HostAdapter *HostAdapter)
   of the Host Adapter from its initial power on or hard reset state.
 */
 
-static boolean BusLogic_InitializeHostAdapter(struct BusLogic_HostAdapter
+static bool BusLogic_InitializeHostAdapter(struct BusLogic_HostAdapter
 					      *HostAdapter)
 {
 	struct BusLogic_ExtendedMailboxRequest ExtendedMailboxRequest;
@@ -2002,7 +2002,7 @@ static boolean BusLogic_InitializeHostAdapter(struct BusLogic_HostAdapter
   through Host Adapter.
 */
 
-static boolean __init BusLogic_TargetDeviceInquiry(struct BusLogic_HostAdapter
+static bool __init BusLogic_TargetDeviceInquiry(struct BusLogic_HostAdapter
 						   *HostAdapter)
 {
 	u16 InstalledDevices;
@@ -2739,7 +2739,7 @@ static irqreturn_t BusLogic_InterruptHandler(int IRQ_Channel, void *DeviceIdenti
   already have been acquired by the caller.
 */
 
-static boolean BusLogic_WriteOutgoingMailbox(struct BusLogic_HostAdapter
+static bool BusLogic_WriteOutgoingMailbox(struct BusLogic_HostAdapter
 					     *HostAdapter, enum BusLogic_ActionCode ActionCode, struct BusLogic_CCB *CCB)
 {
 	struct BusLogic_OutgoingMailbox *NextOutgoingMailbox;
@@ -3058,7 +3058,7 @@ static int BusLogic_AbortCommand(struct scsi_cmnd *Command)
   currently executing SCSI Commands as having been Reset.
 */
 
-static int BusLogic_ResetHostAdapter(struct BusLogic_HostAdapter *HostAdapter, boolean HardReset)
+static int BusLogic_ResetHostAdapter(struct BusLogic_HostAdapter *HostAdapter, bool HardReset)
 {
 	struct BusLogic_CCB *CCB;
 	int TargetID;
@@ -3309,7 +3309,7 @@ Target	Requested Completed  Requested Completed  Requested Completed\n\
 static void BusLogic_Message(enum BusLogic_MessageLevel MessageLevel, char *Format, struct BusLogic_HostAdapter *HostAdapter, ...)
 {
 	static char Buffer[BusLogic_LineBufferSize];
-	static boolean BeginningOfLine = true;
+	static bool BeginningOfLine = true;
 	va_list Arguments;
 	int Length = 0;
 	va_start(Arguments, HostAdapter);
@@ -3347,7 +3347,7 @@ static void BusLogic_Message(enum BusLogic_MessageLevel MessageLevel, char *Form
   and updates the pointer if the keyword is recognized and false otherwise.
 */
 
-static boolean __init BusLogic_ParseKeyword(char **StringPointer, char *Keyword)
+static bool __init BusLogic_ParseKeyword(char **StringPointer, char *Keyword)
 {
 	char *Pointer = *StringPointer;
 	while (*Keyword != '\0') {
diff --git a/drivers/scsi/BusLogic.h b/drivers/scsi/BusLogic.h
index cca6d45..bfbfb5c 100644
--- a/drivers/scsi/BusLogic.h
+++ b/drivers/scsi/BusLogic.h
@@ -234,12 +234,6 @@ enum BusLogic_BIOS_DiskGeometryTranslation {
 
 
 /*
-  Define a Boolean data type.
-*/
-
-typedef bool boolean;
-
-/*
   Define a 10^18 Statistics Byte Counter data type.
 */
 
@@ -269,19 +263,19 @@ struct BusLogic_ProbeInfo {
 */
 
 struct BusLogic_ProbeOptions {
-	boolean NoProbe:1;	/* Bit 0 */
-	boolean NoProbeISA:1;	/* Bit 1 */
-	boolean NoProbePCI:1;	/* Bit 2 */
-	boolean NoSortPCI:1;	/* Bit 3 */
-	boolean MultiMasterFirst:1;	/* Bit 4 */
-	boolean FlashPointFirst:1;	/* Bit 5 */
-	boolean LimitedProbeISA:1;	/* Bit 6 */
-	boolean Probe330:1;	/* Bit 7 */
-	boolean Probe334:1;	/* Bit 8 */
-	boolean Probe230:1;	/* Bit 9 */
-	boolean Probe234:1;	/* Bit 10 */
-	boolean Probe130:1;	/* Bit 11 */
-	boolean Probe134:1;	/* Bit 12 */
+	bool NoProbe:1;		/* Bit 0 */
+	bool NoProbeISA:1;	/* Bit 1 */
+	bool NoProbePCI:1;	/* Bit 2 */
+	bool NoSortPCI:1;	/* Bit 3 */
+	bool MultiMasterFirst:1;/* Bit 4 */
+	bool FlashPointFirst:1;	/* Bit 5 */
+	bool LimitedProbeISA:1;	/* Bit 6 */
+	bool Probe330:1;	/* Bit 7 */
+	bool Probe334:1;	/* Bit 8 */
+	bool Probe230:1;	/* Bit 9 */
+	bool Probe234:1;	/* Bit 10 */
+	bool Probe130:1;	/* Bit 11 */
+	bool Probe134:1;	/* Bit 12 */
 };
 
 /*
@@ -289,10 +283,10 @@ struct BusLogic_ProbeOptions {
 */
 
 struct BusLogic_GlobalOptions {
-	boolean TraceProbe:1;	/* Bit 0 */
-	boolean TraceHardwareReset:1;	/* Bit 1 */
-	boolean TraceConfiguration:1;	/* Bit 2 */
-	boolean TraceErrors:1;	/* Bit 3 */
+	bool TraceProbe:1;	/* Bit 0 */
+	bool TraceHardwareReset:1;	/* Bit 1 */
+	bool TraceConfiguration:1;	/* Bit 2 */
+	bool TraceErrors:1;	/* Bit 3 */
 };
 
 /*
@@ -300,7 +294,7 @@ struct BusLogic_GlobalOptions {
 */
 
 struct BusLogic_LocalOptions {
-	boolean InhibitTargetInquiry:1;	/* Bit 0 */
+	bool InhibitTargetInquiry:1;	/* Bit 0 */
 };
 
 /*
@@ -322,10 +316,10 @@ union BusLogic_ControlRegister {
 	unsigned char All;
 	struct {
 		unsigned char:4;	/* Bits 0-3 */
-		boolean SCSIBusReset:1;	/* Bit 4 */
-		boolean InterruptReset:1;	/* Bit 5 */
-		boolean SoftReset:1;	/* Bit 6 */
-		boolean HardReset:1;	/* Bit 7 */
+		bool SCSIBusReset:1;	/* Bit 4 */
+		bool InterruptReset:1;	/* Bit 5 */
+		bool SoftReset:1;	/* Bit 6 */
+		bool HardReset:1;	/* Bit 7 */
 	} cr;
 };
 
@@ -336,14 +330,14 @@ union BusLogic_ControlRegister {
 union BusLogic_StatusRegister {
 	unsigned char All;
 	struct {
-		boolean CommandInvalid:1;	/* Bit 0 */
-		boolean Reserved:1;	/* Bit 1 */
-		boolean DataInRegisterReady:1;	/* Bit 2 */
-		boolean CommandParameterRegisterBusy:1;	/* Bit 3 */
-		boolean HostAdapterReady:1;	/* Bit 4 */
-		boolean InitializationRequired:1;	/* Bit 5 */
-		boolean DiagnosticFailure:1;	/* Bit 6 */
-		boolean DiagnosticActive:1;	/* Bit 7 */
+		bool CommandInvalid:1;		/* Bit 0 */
+		bool Reserved:1;		/* Bit 1 */
+		bool DataInRegisterReady:1;	/* Bit 2 */
+		bool CommandParameterRegisterBusy:1;	/* Bit 3 */
+		bool HostAdapterReady:1;	/* Bit 4 */
+		bool InitializationRequired:1;	/* Bit 5 */
+		bool DiagnosticFailure:1;	/* Bit 6 */
+		bool DiagnosticActive:1;	/* Bit 7 */
 	} sr;
 };
 
@@ -354,12 +348,12 @@ union BusLogic_StatusRegister {
 union BusLogic_InterruptRegister {
 	unsigned char All;
 	struct {
-		boolean IncomingMailboxLoaded:1;	/* Bit 0 */
-		boolean OutgoingMailboxAvailable:1;	/* Bit 1 */
-		boolean CommandComplete:1;	/* Bit 2 */
-		boolean ExternalBusReset:1;	/* Bit 3 */
+		bool IncomingMailboxLoaded:1;	/* Bit 0 */
+		bool OutgoingMailboxAvailable:1;/* Bit 1 */
+		bool CommandComplete:1;		/* Bit 2 */
+		bool ExternalBusReset:1;	/* Bit 3 */
 		unsigned char Reserved:3;	/* Bits 4-6 */
-		boolean InterruptValid:1;	/* Bit 7 */
+		bool InterruptValid:1;		/* Bit 7 */
 	} ir;
 };
 
@@ -373,7 +367,7 @@ union BusLogic_GeometryRegister {
 		enum BusLogic_BIOS_DiskGeometryTranslation Drive0Geometry:2;	/* Bits 0-1 */
 		enum BusLogic_BIOS_DiskGeometryTranslation Drive1Geometry:2;	/* Bits 2-3 */
 		unsigned char:3;	/* Bits 4-6 */
-		boolean ExtendedTranslationEnabled:1;	/* Bit 7 */
+		bool ExtendedTranslationEnabled:1;	/* Bit 7 */
 	} gr;
 };
 
@@ -445,16 +439,16 @@ struct BusLogic_BoardID {
 
 struct BusLogic_Configuration {
 	unsigned char:5;	/* Byte 0 Bits 0-4 */
-	boolean DMA_Channel5:1;	/* Byte 0 Bit 5 */
-	boolean DMA_Channel6:1;	/* Byte 0 Bit 6 */
-	boolean DMA_Channel7:1;	/* Byte 0 Bit 7 */
-	boolean IRQ_Channel9:1;	/* Byte 1 Bit 0 */
-	boolean IRQ_Channel10:1;	/* Byte 1 Bit 1 */
-	boolean IRQ_Channel11:1;	/* Byte 1 Bit 2 */
-	boolean IRQ_Channel12:1;	/* Byte 1 Bit 3 */
+	bool DMA_Channel5:1;	/* Byte 0 Bit 5 */
+	bool DMA_Channel6:1;	/* Byte 0 Bit 6 */
+	bool DMA_Channel7:1;	/* Byte 0 Bit 7 */
+	bool IRQ_Channel9:1;	/* Byte 1 Bit 0 */
+	bool IRQ_Channel10:1;	/* Byte 1 Bit 1 */
+	bool IRQ_Channel11:1;	/* Byte 1 Bit 2 */
+	bool IRQ_Channel12:1;	/* Byte 1 Bit 3 */
 	unsigned char:1;	/* Byte 1 Bit 4 */
-	boolean IRQ_Channel14:1;	/* Byte 1 Bit 5 */
-	boolean IRQ_Channel15:1;	/* Byte 1 Bit 6 */
+	bool IRQ_Channel14:1;	/* Byte 1 Bit 5 */
+	bool IRQ_Channel15:1;	/* Byte 1 Bit 6 */
 	unsigned char:1;	/* Byte 1 Bit 7 */
 	unsigned char HostAdapterID:4;	/* Byte 2 Bits 0-3 */
 	unsigned char:4;	/* Byte 2 Bits 4-7 */
@@ -467,12 +461,12 @@ struct BusLogic_Configuration {
 struct BusLogic_SynchronousValue {
 	unsigned char Offset:4;	/* Bits 0-3 */
 	unsigned char TransferPeriod:3;	/* Bits 4-6 */
-	boolean Synchronous:1;	/* Bit 7 */
+	bool Synchronous:1;	/* Bit 7 */
 };
 
 struct BusLogic_SetupInformation {
-	boolean SynchronousInitiationEnabled:1;	/* Byte 0 Bit 0 */
-	boolean ParityCheckingEnabled:1;	/* Byte 0 Bit 1 */
+	bool SynchronousInitiationEnabled:1;	/* Byte 0 Bit 0 */
+	bool ParityCheckingEnabled:1;		/* Byte 0 Bit 1 */
 	unsigned char:6;	/* Byte 0 Bits 2-7 */
 	unsigned char BusTransferRate;	/* Byte 1 */
 	unsigned char PreemptTimeOnBus;	/* Byte 2 */
@@ -523,13 +517,13 @@ enum BusLogic_ISACompatibleIOPort {
 struct BusLogic_PCIHostAdapterInformation {
 	enum BusLogic_ISACompatibleIOPort ISACompatibleIOPort;	/* Byte 0 */
 	unsigned char PCIAssignedIRQChannel;	/* Byte 1 */
-	boolean LowByteTerminated:1;	/* Byte 2 Bit 0 */
-	boolean HighByteTerminated:1;	/* Byte 2 Bit 1 */
+	bool LowByteTerminated:1;	/* Byte 2 Bit 0 */
+	bool HighByteTerminated:1;	/* Byte 2 Bit 1 */
 	unsigned char:2;	/* Byte 2 Bits 2-3 */
-	boolean JP1:1;		/* Byte 2 Bit 4 */
-	boolean JP2:1;		/* Byte 2 Bit 5 */
-	boolean JP3:1;		/* Byte 2 Bit 6 */
-	boolean GenericInfoValid:1;	/* Byte 2 Bit 7 */
+	bool JP1:1;		/* Byte 2 Bit 4 */
+	bool JP2:1;		/* Byte 2 Bit 5 */
+	bool JP3:1;		/* Byte 2 Bit 6 */
+	bool GenericInfoValid:1;/* Byte 2 Bit 7 */
 	unsigned char:8;	/* Byte 3 */
 };
 
@@ -545,17 +539,17 @@ struct BusLogic_ExtendedSetupInformation {
 	u32 BaseMailboxAddress;	/* Bytes 5-8 */
 	struct {
 		unsigned char:2;	/* Byte 9 Bits 0-1 */
-		boolean FastOnEISA:1;	/* Byte 9 Bit 2 */
+		bool FastOnEISA:1;	/* Byte 9 Bit 2 */
 		unsigned char:3;	/* Byte 9 Bits 3-5 */
-		boolean LevelSensitiveInterrupt:1;	/* Byte 9 Bit 6 */
+		bool LevelSensitiveInterrupt:1;	/* Byte 9 Bit 6 */
 		unsigned char:1;	/* Byte 9 Bit 7 */
 	} Misc;
 	unsigned char FirmwareRevision[3];	/* Bytes 10-12 */
-	boolean HostWideSCSI:1;	/* Byte 13 Bit 0 */
-	boolean HostDifferentialSCSI:1;	/* Byte 13 Bit 1 */
-	boolean HostSupportsSCAM:1;	/* Byte 13 Bit 2 */
-	boolean HostUltraSCSI:1;	/* Byte 13 Bit 3 */
-	boolean HostSmartTermination:1;	/* Byte 13 Bit 4 */
+	bool HostWideSCSI:1;		/* Byte 13 Bit 0 */
+	bool HostDifferentialSCSI:1;	/* Byte 13 Bit 1 */
+	bool HostSupportsSCAM:1;	/* Byte 13 Bit 2 */
+	bool HostUltraSCSI:1;		/* Byte 13 Bit 3 */
+	bool HostSmartTermination:1;	/* Byte 13 Bit 4 */
 	unsigned char:3;	/* Byte 13 Bits 5-7 */
 } PACKED;
 
@@ -590,35 +584,35 @@ struct BusLogic_AutoSCSIData {
 	unsigned char InformationByteCount;	/* Byte 2 */
 	unsigned char HostAdapterType[6];	/* Bytes 3-8 */
 	unsigned char:8;	/* Byte 9 */
-	boolean FloppyEnabled:1;	/* Byte 10 Bit 0 */
-	boolean FloppySecondary:1;	/* Byte 10 Bit 1 */
-	boolean LevelSensitiveInterrupt:1;	/* Byte 10 Bit 2 */
+	bool FloppyEnabled:1;		/* Byte 10 Bit 0 */
+	bool FloppySecondary:1;		/* Byte 10 Bit 1 */
+	bool LevelSensitiveInterrupt:1;	/* Byte 10 Bit 2 */
 	unsigned char:2;	/* Byte 10 Bits 3-4 */
 	unsigned char SystemRAMAreaForBIOS:3;	/* Byte 10 Bits 5-7 */
 	unsigned char DMA_Channel:7;	/* Byte 11 Bits 0-6 */
-	boolean DMA_AutoConfiguration:1;	/* Byte 11 Bit 7 */
+	bool DMA_AutoConfiguration:1;	/* Byte 11 Bit 7 */
 	unsigned char IRQ_Channel:7;	/* Byte 12 Bits 0-6 */
-	boolean IRQ_AutoConfiguration:1;	/* Byte 12 Bit 7 */
+	bool IRQ_AutoConfiguration:1;	/* Byte 12 Bit 7 */
 	unsigned char DMA_TransferRate;	/* Byte 13 */
 	unsigned char SCSI_ID;	/* Byte 14 */
-	boolean LowByteTerminated:1;	/* Byte 15 Bit 0 */
-	boolean ParityCheckingEnabled:1;	/* Byte 15 Bit 1 */
-	boolean HighByteTerminated:1;	/* Byte 15 Bit 2 */
-	boolean NoisyCablingEnvironment:1;	/* Byte 15 Bit 3 */
-	boolean FastSynchronousNegotiation:1;	/* Byte 15 Bit 4 */
-	boolean BusResetEnabled:1;	/* Byte 15 Bit 5 */
-	 boolean:1;		/* Byte 15 Bit 6 */
-	boolean ActiveNegationEnabled:1;	/* Byte 15 Bit 7 */
+	bool LowByteTerminated:1;	/* Byte 15 Bit 0 */
+	bool ParityCheckingEnabled:1;	/* Byte 15 Bit 1 */
+	bool HighByteTerminated:1;	/* Byte 15 Bit 2 */
+	bool NoisyCablingEnvironment:1;	/* Byte 15 Bit 3 */
+	bool FastSynchronousNegotiation:1;	/* Byte 15 Bit 4 */
+	bool BusResetEnabled:1;		/* Byte 15 Bit 5 */
+	 bool:1;		/* Byte 15 Bit 6 */
+	bool ActiveNegationEnabled:1;	/* Byte 15 Bit 7 */
 	unsigned char BusOnDelay;	/* Byte 16 */
 	unsigned char BusOffDelay;	/* Byte 17 */
-	boolean HostAdapterBIOSEnabled:1;	/* Byte 18 Bit 0 */
-	boolean BIOSRedirectionOfINT19Enabled:1;	/* Byte 18 Bit 1 */
-	boolean ExtendedTranslationEnabled:1;	/* Byte 18 Bit 2 */
-	boolean MapRemovableAsFixedEnabled:1;	/* Byte 18 Bit 3 */
-	 boolean:1;		/* Byte 18 Bit 4 */
-	boolean BIOSSupportsMoreThan2DrivesEnabled:1;	/* Byte 18 Bit 5 */
-	boolean BIOSInterruptModeEnabled:1;	/* Byte 18 Bit 6 */
-	boolean FlopticalSupportEnabled:1;	/* Byte 19 Bit 7 */
+	bool HostAdapterBIOSEnabled:1;		/* Byte 18 Bit 0 */
+	bool BIOSRedirectionOfINT19Enabled:1;	/* Byte 18 Bit 1 */
+	bool ExtendedTranslationEnabled:1;	/* Byte 18 Bit 2 */
+	bool MapRemovableAsFixedEnabled:1;	/* Byte 18 Bit 3 */
+	 bool:1;		/* Byte 18 Bit 4 */
+	bool BIOSSupportsMoreThan2DrivesEnabled:1;	/* Byte 18 Bit 5 */
+	bool BIOSInterruptModeEnabled:1;	/* Byte 18 Bit 6 */
+	bool FlopticalSupportEnabled:1;		/* Byte 19 Bit 7 */
 	unsigned short DeviceEnabled;	/* Bytes 19-20 */
 	unsigned short WidePermitted;	/* Bytes 21-22 */
 	unsigned short FastPermitted;	/* Bytes 23-24 */
@@ -628,22 +622,22 @@ struct BusLogic_AutoSCSIData {
 	unsigned short IgnoreInBIOSScan;	/* Bytes 31-32 */
 	unsigned char PCIInterruptPin:2;	/* Byte 33 Bits 0-1 */
 	unsigned char HostAdapterIOPortAddress:2;	/* Byte 33 Bits 2-3 */
-	boolean StrictRoundRobinModeEnabled:1;	/* Byte 33 Bit 4 */
-	boolean VESABusSpeedGreaterThan33MHz:1;	/* Byte 33 Bit 5 */
-	boolean VESABurstWriteEnabled:1;	/* Byte 33 Bit 6 */
-	boolean VESABurstReadEnabled:1;	/* Byte 33 Bit 7 */
+	bool StrictRoundRobinModeEnabled:1;	/* Byte 33 Bit 4 */
+	bool VESABusSpeedGreaterThan33MHz:1;	/* Byte 33 Bit 5 */
+	bool VESABurstWriteEnabled:1;	/* Byte 33 Bit 6 */
+	bool VESABurstReadEnabled:1;	/* Byte 33 Bit 7 */
 	unsigned short UltraPermitted;	/* Bytes 34-35 */
 	unsigned int:32;	/* Bytes 36-39 */
 	unsigned char:8;	/* Byte 40 */
 	unsigned char AutoSCSIMaximumLUN;	/* Byte 41 */
-	 boolean:1;		/* Byte 42 Bit 0 */
-	boolean SCAM_Dominant:1;	/* Byte 42 Bit 1 */
-	boolean SCAM_Enabled:1;	/* Byte 42 Bit 2 */
-	boolean SCAM_Level2:1;	/* Byte 42 Bit 3 */
+	 bool:1;		/* Byte 42 Bit 0 */
+	bool SCAM_Dominant:1;	/* Byte 42 Bit 1 */
+	bool SCAM_Enabled:1;	/* Byte 42 Bit 2 */
+	bool SCAM_Level2:1;	/* Byte 42 Bit 3 */
 	unsigned char:4;	/* Byte 42 Bits 4-7 */
-	boolean INT13ExtensionEnabled:1;	/* Byte 43 Bit 0 */
-	 boolean:1;		/* Byte 43 Bit 1 */
-	boolean CDROMBootEnabled:1;	/* Byte 43 Bit 2 */
+	bool INT13ExtensionEnabled:1;	/* Byte 43 Bit 0 */
+	 bool:1;		/* Byte 43 Bit 1 */
+	bool CDROMBootEnabled:1;	/* Byte 43 Bit 2 */
 	unsigned char:5;	/* Byte 43 Bits 3-7 */
 	unsigned char BootTargetID:4;	/* Byte 44 Bits 0-3 */
 	unsigned char BootChannel:4;	/* Byte 44 Bits 4-7 */
@@ -852,7 +846,7 @@ struct BusLogic_CCB {
 	enum BusLogic_CCB_Opcode Opcode;	/* Byte 0 */
 	unsigned char:3;	/* Byte 1 Bits 0-2 */
 	enum BusLogic_DataDirection DataDirection:2;	/* Byte 1 Bits 3-4 */
-	boolean TagEnable:1;	/* Byte 1 Bit 5 */
+	bool TagEnable:1;	/* Byte 1 Bit 5 */
 	enum BusLogic_QueueTag QueueTag:2;	/* Byte 1 Bits 6-7 */
 	unsigned char CDB_Length;	/* Byte 2 */
 	unsigned char SenseDataLength;	/* Byte 3 */
@@ -864,7 +858,7 @@ struct BusLogic_CCB {
 	enum BusLogic_TargetDeviceStatus TargetDeviceStatus;	/* Byte 15 */
 	unsigned char TargetID;	/* Byte 16 */
 	unsigned char LogicalUnit:5;	/* Byte 17 Bits 0-4 */
-	boolean LegacyTagEnable:1;	/* Byte 17 Bit 5 */
+	bool LegacyTagEnable:1;	/* Byte 17 Bit 5 */
 	enum BusLogic_QueueTag LegacyQueueTag:2;	/* Byte 17 Bits 6-7 */
 	SCSI_CDB_T CDB;		/* Bytes 18-29 */
 	unsigned char:8;	/* Byte 30 */
@@ -939,13 +933,13 @@ struct BusLogic_DriverOptions {
 */
 
 struct BusLogic_TargetFlags {
-	boolean TargetExists:1;
-	boolean TaggedQueuingSupported:1;
-	boolean WideTransfersSupported:1;
-	boolean TaggedQueuingActive:1;
-	boolean WideTransfersActive:1;
-	boolean CommandSuccessfulFlag:1;
-	boolean TargetInfoReported:1;
+	bool TargetExists:1;
+	bool TaggedQueuingSupported:1;
+	bool WideTransfersSupported:1;
+	bool TaggedQueuingActive:1;
+	bool WideTransfersActive:1;
+	bool CommandSuccessfulFlag:1;
+	bool TargetInfoReported:1;
 };
 
 /*
@@ -992,7 +986,7 @@ typedef unsigned int FlashPoint_CardHandle_T;
 
 struct FlashPoint_Info {
 	u32 BaseAddress;	/* Bytes 0-3 */
-	boolean Present;	/* Byte 4 */
+	bool Present;		/* Byte 4 */
 	unsigned char IRQ_Channel;	/* Byte 5 */
 	unsigned char SCSI_ID;	/* Byte 6 */
 	unsigned char SCSI_LUN;	/* Byte 7 */
@@ -1002,15 +996,15 @@ struct FlashPoint_Info {
 	unsigned short UltraPermitted;	/* Bytes 14-15 */
 	unsigned short DisconnectPermitted;	/* Bytes 16-17 */
 	unsigned short WidePermitted;	/* Bytes 18-19 */
-	boolean ParityCheckingEnabled:1;	/* Byte 20 Bit 0 */
-	boolean HostWideSCSI:1;	/* Byte 20 Bit 1 */
-	boolean HostSoftReset:1;	/* Byte 20 Bit 2 */
-	boolean ExtendedTranslationEnabled:1;	/* Byte 20 Bit 3 */
-	boolean LowByteTerminated:1;	/* Byte 20 Bit 4 */
-	boolean HighByteTerminated:1;	/* Byte 20 Bit 5 */
-	boolean ReportDataUnderrun:1;	/* Byte 20 Bit 6 */
-	boolean SCAM_Enabled:1;	/* Byte 20 Bit 7 */
-	boolean SCAM_Level2:1;	/* Byte 21 Bit 0 */
+	bool ParityCheckingEnabled:1;	/* Byte 20 Bit 0 */
+	bool HostWideSCSI:1;		/* Byte 20 Bit 1 */
+	bool HostSoftReset:1;		/* Byte 20 Bit 2 */
+	bool ExtendedTranslationEnabled:1;	/* Byte 20 Bit 3 */
+	bool LowByteTerminated:1;	/* Byte 20 Bit 4 */
+	bool HighByteTerminated:1;	/* Byte 20 Bit 5 */
+	bool ReportDataUnderrun:1;	/* Byte 20 Bit 6 */
+	bool SCAM_Enabled:1;	/* Byte 20 Bit 7 */
+	bool SCAM_Level2:1;	/* Byte 21 Bit 0 */
 	unsigned char:7;	/* Byte 21 Bits 1-7 */
 	unsigned char Family;	/* Byte 22 */
 	unsigned char BusType;	/* Byte 23 */
@@ -1044,29 +1038,29 @@ struct BusLogic_HostAdapter {
 	unsigned char IRQ_Channel;
 	unsigned char DMA_Channel;
 	unsigned char SCSI_ID;
-	boolean IRQ_ChannelAcquired:1;
-	boolean DMA_ChannelAcquired:1;
-	boolean ExtendedTranslationEnabled:1;
-	boolean ParityCheckingEnabled:1;
-	boolean BusResetEnabled:1;
-	boolean LevelSensitiveInterrupt:1;
-	boolean HostWideSCSI:1;
-	boolean HostDifferentialSCSI:1;
-	boolean HostSupportsSCAM:1;
-	boolean HostUltraSCSI:1;
-	boolean ExtendedLUNSupport:1;
-	boolean TerminationInfoValid:1;
-	boolean LowByteTerminated:1;
-	boolean HighByteTerminated:1;
-	boolean BounceBuffersRequired:1;
-	boolean StrictRoundRobinModeSupport:1;
-	boolean SCAM_Enabled:1;
-	boolean SCAM_Level2:1;
-	boolean HostAdapterInitialized:1;
-	boolean HostAdapterExternalReset:1;
-	boolean HostAdapterInternalError:1;
-	boolean ProcessCompletedCCBsActive;
-	volatile boolean HostAdapterCommandCompleted;
+	bool IRQ_ChannelAcquired:1;
+	bool DMA_ChannelAcquired:1;
+	bool ExtendedTranslationEnabled:1;
+	bool ParityCheckingEnabled:1;
+	bool BusResetEnabled:1;
+	bool LevelSensitiveInterrupt:1;
+	bool HostWideSCSI:1;
+	bool HostDifferentialSCSI:1;
+	bool HostSupportsSCAM:1;
+	bool HostUltraSCSI:1;
+	bool ExtendedLUNSupport:1;
+	bool TerminationInfoValid:1;
+	bool LowByteTerminated:1;
+	bool HighByteTerminated:1;
+	bool BounceBuffersRequired:1;
+	bool StrictRoundRobinModeSupport:1;
+	bool SCAM_Enabled:1;
+	bool SCAM_Level2:1;
+	bool HostAdapterInitialized:1;
+	bool HostAdapterExternalReset:1;
+	bool HostAdapterInternalError:1;
+	bool ProcessCompletedCCBsActive;
+	volatile bool HostAdapterCommandCompleted;
 	unsigned short HostAdapterScatterGatherLimit;
 	unsigned short DriverScatterGatherLimit;
 	unsigned short MaxTargetDevices;
@@ -1141,25 +1135,25 @@ struct SCSI_Inquiry {
 	unsigned char PeripheralDeviceType:5;	/* Byte 0 Bits 0-4 */
 	unsigned char PeripheralQualifier:3;	/* Byte 0 Bits 5-7 */
 	unsigned char DeviceTypeModifier:7;	/* Byte 1 Bits 0-6 */
-	boolean RMB:1;		/* Byte 1 Bit 7 */
+	bool RMB:1;		/* Byte 1 Bit 7 */
 	unsigned char ANSI_ApprovedVersion:3;	/* Byte 2 Bits 0-2 */
 	unsigned char ECMA_Version:3;	/* Byte 2 Bits 3-5 */
 	unsigned char ISO_Version:2;	/* Byte 2 Bits 6-7 */
 	unsigned char ResponseDataFormat:4;	/* Byte 3 Bits 0-3 */
 	unsigned char:2;	/* Byte 3 Bits 4-5 */
-	boolean TrmIOP:1;	/* Byte 3 Bit 6 */
-	boolean AENC:1;		/* Byte 3 Bit 7 */
+	bool TrmIOP:1;		/* Byte 3 Bit 6 */
+	bool AENC:1;		/* Byte 3 Bit 7 */
 	unsigned char AdditionalLength;	/* Byte 4 */
 	unsigned char:8;	/* Byte 5 */
 	unsigned char:8;	/* Byte 6 */
-	boolean SftRe:1;	/* Byte 7 Bit 0 */
-	boolean CmdQue:1;	/* Byte 7 Bit 1 */
-	 boolean:1;		/* Byte 7 Bit 2 */
-	boolean Linked:1;	/* Byte 7 Bit 3 */
-	boolean Sync:1;		/* Byte 7 Bit 4 */
-	boolean WBus16:1;	/* Byte 7 Bit 5 */
-	boolean WBus32:1;	/* Byte 7 Bit 6 */
-	boolean RelAdr:1;	/* Byte 7 Bit 7 */
+	bool SftRe:1;		/* Byte 7 Bit 0 */
+	bool CmdQue:1;		/* Byte 7 Bit 1 */
+	 bool:1;		/* Byte 7 Bit 2 */
+	bool Linked:1;		/* Byte 7 Bit 3 */
+	bool Sync:1;		/* Byte 7 Bit 4 */
+	bool WBus16:1;		/* Byte 7 Bit 5 */
+	bool WBus32:1;		/* Byte 7 Bit 6 */
+	bool RelAdr:1;		/* Byte 7 Bit 7 */
 	unsigned char VendorIdentification[8];	/* Bytes 8-15 */
 	unsigned char ProductIdentification[16];	/* Bytes 16-31 */
 	unsigned char ProductRevisionLevel[4];	/* Bytes 32-35 */
@@ -1348,7 +1342,7 @@ static int BusLogic_ProcDirectoryInfo(struct Scsi_Host *, char *, char **, off_t
 static int BusLogic_SlaveConfigure(struct scsi_device *);
 static void BusLogic_QueueCompletedCCB(struct BusLogic_CCB *);
 static irqreturn_t BusLogic_InterruptHandler(int, void *);
-static int BusLogic_ResetHostAdapter(struct BusLogic_HostAdapter *, boolean HardReset);
+static int BusLogic_ResetHostAdapter(struct BusLogic_HostAdapter *, bool HardReset);
 static void BusLogic_Message(enum BusLogic_MessageLevel, char *, struct BusLogic_HostAdapter *, ...);
 static int __init BusLogic_Setup(char *);
 
diff --git a/drivers/scsi/FlashPoint.c b/drivers/scsi/FlashPoint.c
index 7c00680..a7f916c 100644
--- a/drivers/scsi/FlashPoint.c
+++ b/drivers/scsi/FlashPoint.c
@@ -7609,7 +7609,7 @@ FlashPoint__AbortCCB(FlashPoint_CardHandle_T CardHandle,
 	FlashPoint_AbortCCB(CardHandle, (struct sccb *)CCB);
 }
 
-static inline boolean
+static inline bool
 FlashPoint__InterruptPending(FlashPoint_CardHandle_T CardHandle)
 {
 	return FlashPoint_InterruptPending(CardHandle);
@@ -7640,7 +7640,7 @@ extern FlashPoint_CardHandle_T
 FlashPoint_HardwareResetHostAdapter(struct FlashPoint_Info *);
 extern void FlashPoint_StartCCB(FlashPoint_CardHandle_T, struct BusLogic_CCB *);
 extern int FlashPoint_AbortCCB(FlashPoint_CardHandle_T, struct BusLogic_CCB *);
-extern boolean FlashPoint_InterruptPending(FlashPoint_CardHandle_T);
+extern bool FlashPoint_InterruptPending(FlashPoint_CardHandle_T);
 extern int FlashPoint_HandleInterrupt(FlashPoint_CardHandle_T);
 extern void FlashPoint_ReleaseHostAdapter(FlashPoint_CardHandle_T);
 


