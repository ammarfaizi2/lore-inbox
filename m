Return-Path: <linux-kernel-owner+w=401wt.eu-S1751333AbXAVKAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbXAVKAI (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 05:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbXAVKAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 05:00:08 -0500
Received: from gepetto.dc.ltu.se ([130.240.42.40]:37212 "EHLO
	gepetto.dc.ltu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333AbXAVKAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 05:00:02 -0500
Message-ID: <45B48B88.4000305@student.ltu.se>
Date: Mon, 22 Jan 2007 11:01:44 +0100
From: Richard Knutsson <ricknu-0@student.ltu.se>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: axboe@kernel.dk, mingo@redhat.com, neilb@cse.unsw.edu.au
CC: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/block/DAC960: Converted 'boolean' to 'bool'
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Converts 'boolean' to 'bool' and removes the 'boolean' typedef.

Signed-off-by: Richard Knutsson <ricknu-0@student.ltu.se>
---
"sed s/boolean/bool/" and remove "typedef bool boolean". Minor comment-alignment fixes.
Compile-tested with "allyes" and "allmod" under "i386".

 DAC960.c |   72 ++++-----
 DAC960.h |  495 +++++++++++++++++++++++++++++++--------------------------------
 2 files changed, 280 insertions(+), 287 deletions(-)


diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index 8d81a3a..6ad28df 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -177,7 +177,7 @@ static void DAC960_AnnounceDriver(DAC960_Controller_T *Controller)
   DAC960_Failure prints a standardized error message, and then returns false.
 */
 
-static boolean DAC960_Failure(DAC960_Controller_T *Controller,
+static bool DAC960_Failure(DAC960_Controller_T *Controller,
 			      unsigned char *ErrorMessage)
 {
   DAC960_Error("While configuring DAC960 PCI RAID Controller at\n",
@@ -206,7 +206,7 @@ static boolean DAC960_Failure(DAC960_Controller_T *Controller,
   that are passed in.
  */
 
-static boolean init_dma_loaf(struct pci_dev *dev, struct dma_loaf *loaf,
+static bool init_dma_loaf(struct pci_dev *dev, struct dma_loaf *loaf,
 								 size_t len)
 {
 	void *cpu_addr;
@@ -250,7 +250,7 @@ static void free_dma_loaf(struct pci_dev *dev, struct dma_loaf *loaf_handle)
   failure.
 */
 
-static boolean DAC960_CreateAuxiliaryStructures(DAC960_Controller_T *Controller)
+static bool DAC960_CreateAuxiliaryStructures(DAC960_Controller_T *Controller)
 {
   int CommandAllocationLength, CommandAllocationGroupSize;
   int CommandsRemaining = 0, CommandIdentifier, CommandGroupByteCount;
@@ -790,7 +790,7 @@ static void DAC960_ExecuteCommand(DAC960_Command_T *Command)
   on failure.
 */
 
-static boolean DAC960_V1_ExecuteType3(DAC960_Controller_T *Controller,
+static bool DAC960_V1_ExecuteType3(DAC960_Controller_T *Controller,
 				      DAC960_V1_CommandOpcode_T CommandOpcode,
 				      dma_addr_t DataDMA)
 {
@@ -814,7 +814,7 @@ static boolean DAC960_V1_ExecuteType3(DAC960_Controller_T *Controller,
   on failure.
 */
 
-static boolean DAC960_V1_ExecuteType3B(DAC960_Controller_T *Controller,
+static bool DAC960_V1_ExecuteType3B(DAC960_Controller_T *Controller,
 				       DAC960_V1_CommandOpcode_T CommandOpcode,
 				       unsigned char CommandOpcode2,
 				       dma_addr_t DataDMA)
@@ -840,7 +840,7 @@ static boolean DAC960_V1_ExecuteType3B(DAC960_Controller_T *Controller,
   on failure.
 */
 
-static boolean DAC960_V1_ExecuteType3D(DAC960_Controller_T *Controller,
+static bool DAC960_V1_ExecuteType3D(DAC960_Controller_T *Controller,
 				       DAC960_V1_CommandOpcode_T CommandOpcode,
 				       unsigned char Channel,
 				       unsigned char TargetID,
@@ -870,7 +870,7 @@ static boolean DAC960_V1_ExecuteType3D(DAC960_Controller_T *Controller,
   Return data in The controller's HealthStatusBuffer, which is dma-able memory
 */
 
-static boolean DAC960_V2_GeneralInfo(DAC960_Controller_T *Controller)
+static bool DAC960_V2_GeneralInfo(DAC960_Controller_T *Controller)
 {
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
   DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
@@ -908,7 +908,7 @@ static boolean DAC960_V2_GeneralInfo(DAC960_Controller_T *Controller)
   memory buffer.
 */
 
-static boolean DAC960_V2_NewControllerInfo(DAC960_Controller_T *Controller)
+static bool DAC960_V2_NewControllerInfo(DAC960_Controller_T *Controller)
 {
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
   DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
@@ -946,7 +946,7 @@ static boolean DAC960_V2_NewControllerInfo(DAC960_Controller_T *Controller)
   Data is returned in the controller's V2.NewLogicalDeviceInformation
 */
 
-static boolean DAC960_V2_NewLogicalDeviceInfo(DAC960_Controller_T *Controller,
+static bool DAC960_V2_NewLogicalDeviceInfo(DAC960_Controller_T *Controller,
 					   unsigned short LogicalDeviceNumber)
 {
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
@@ -997,7 +997,7 @@ static boolean DAC960_V2_NewLogicalDeviceInfo(DAC960_Controller_T *Controller,
 
 */
 
-static boolean DAC960_V2_NewPhysicalDeviceInfo(DAC960_Controller_T *Controller,
+static bool DAC960_V2_NewPhysicalDeviceInfo(DAC960_Controller_T *Controller,
 					    unsigned char Channel,
 					    unsigned char TargetID,
 					    unsigned char LogicalUnit)
@@ -1082,7 +1082,7 @@ static void DAC960_V2_ConstructNewUnitSerialNumber(
   memory buffer.
 */
 
-static boolean DAC960_V2_NewInquiryUnitSerialNumber(DAC960_Controller_T *Controller,
+static bool DAC960_V2_NewInquiryUnitSerialNumber(DAC960_Controller_T *Controller,
 			int Channel, int TargetID, int LogicalUnit)
 {
       DAC960_Command_T *Command;
@@ -1110,7 +1110,7 @@ static boolean DAC960_V2_NewInquiryUnitSerialNumber(DAC960_Controller_T *Control
   success and false on failure.
 */
 
-static boolean DAC960_V2_DeviceOperation(DAC960_Controller_T *Controller,
+static bool DAC960_V2_DeviceOperation(DAC960_Controller_T *Controller,
 					 DAC960_V2_IOCTL_Opcode_T IOCTL_Opcode,
 					 DAC960_V2_OperationDevice_T
 					   OperationDevice)
@@ -1142,7 +1142,7 @@ static boolean DAC960_V2_DeviceOperation(DAC960_Controller_T *Controller,
   other dma mapped memory.
 */
 
-static boolean DAC960_V1_EnableMemoryMailboxInterface(DAC960_Controller_T
+static bool DAC960_V1_EnableMemoryMailboxInterface(DAC960_Controller_T
 						      *Controller)
 {
   void __iomem *ControllerBaseAddress = Controller->BaseAddress;
@@ -1348,7 +1348,7 @@ skip_mailboxes:
   the structures that are contained in that region.
 */
 
-static boolean DAC960_V2_EnableMemoryMailboxInterface(DAC960_Controller_T
+static bool DAC960_V2_EnableMemoryMailboxInterface(DAC960_Controller_T
 						      *Controller)
 {
   void __iomem *ControllerBaseAddress = Controller->BaseAddress;
@@ -1526,7 +1526,7 @@ static boolean DAC960_V2_EnableMemoryMailboxInterface(DAC960_Controller_T
   from DAC960 V1 Firmware Controllers and initializes the Controller structure.
 */
 
-static boolean DAC960_V1_ReadControllerConfiguration(DAC960_Controller_T
+static bool DAC960_V1_ReadControllerConfiguration(DAC960_Controller_T
 						     *Controller)
 {
   DAC960_V1_Enquiry2_T *Enquiry2;
@@ -1767,7 +1767,7 @@ static boolean DAC960_V1_ReadControllerConfiguration(DAC960_Controller_T
   from DAC960 V2 Firmware Controllers and initializes the Controller structure.
 */
 
-static boolean DAC960_V2_ReadControllerConfiguration(DAC960_Controller_T
+static bool DAC960_V2_ReadControllerConfiguration(DAC960_Controller_T
 						     *Controller)
 {
   DAC960_V2_ControllerInfo_T *ControllerInfo =
@@ -1898,7 +1898,7 @@ static boolean DAC960_V2_ReadControllerConfiguration(DAC960_Controller_T
   for Controller.
 */
 
-static boolean DAC960_ReportControllerConfiguration(DAC960_Controller_T
+static bool DAC960_ReportControllerConfiguration(DAC960_Controller_T
 						    *Controller)
 {
   DAC960_Info("Configuring Mylex %s PCI RAID Controller\n",
@@ -1947,7 +1947,7 @@ static boolean DAC960_ReportControllerConfiguration(DAC960_Controller_T
   Controller.
 */
 
-static boolean DAC960_V1_ReadDeviceConfiguration(DAC960_Controller_T
+static bool DAC960_V1_ReadDeviceConfiguration(DAC960_Controller_T
 						 *Controller)
 {
   struct dma_loaf local_dma;
@@ -2095,7 +2095,7 @@ static boolean DAC960_V1_ReadDeviceConfiguration(DAC960_Controller_T
   device connected to Controller.
 */
 
-static boolean DAC960_V2_ReadDeviceConfiguration(DAC960_Controller_T
+static bool DAC960_V2_ReadDeviceConfiguration(DAC960_Controller_T
 						 *Controller)
 {
   unsigned char Channel = 0, TargetID = 0, LogicalUnit = 0;
@@ -2219,7 +2219,7 @@ static void DAC960_SanitizeInquiryData(DAC960_SCSI_Inquiry_T
   Information for DAC960 V1 Firmware Controllers.
 */
 
-static boolean DAC960_V1_ReportDeviceConfiguration(DAC960_Controller_T
+static bool DAC960_V1_ReportDeviceConfiguration(DAC960_Controller_T
 						   *Controller)
 {
   int LogicalDriveNumber, Channel, TargetID;
@@ -2316,7 +2316,7 @@ static boolean DAC960_V1_ReportDeviceConfiguration(DAC960_Controller_T
   Information for DAC960 V2 Firmware Controllers.
 */
 
-static boolean DAC960_V2_ReportDeviceConfiguration(DAC960_Controller_T
+static bool DAC960_V2_ReportDeviceConfiguration(DAC960_Controller_T
 						   *Controller)
 {
   int PhysicalDeviceIndex, LogicalDriveNumber;
@@ -2501,7 +2501,7 @@ static boolean DAC960_V2_ReportDeviceConfiguration(DAC960_Controller_T
   associated with Controller.
 */
 
-static boolean DAC960_RegisterBlockDevice(DAC960_Controller_T *Controller)
+static bool DAC960_RegisterBlockDevice(DAC960_Controller_T *Controller)
 {
   int MajorNumber = DAC960_MAJOR + Controller->ControllerNumber;
   int n;
@@ -2582,7 +2582,7 @@ static void DAC960_ComputeGenericDiskInfo(DAC960_Controller_T *Controller)
   It returns true for fatal errors and false otherwise.
 */
 
-static boolean DAC960_ReportErrorStatus(DAC960_Controller_T *Controller,
+static bool DAC960_ReportErrorStatus(DAC960_Controller_T *Controller,
 					unsigned char ErrorStatus,
 					unsigned char Parameter0,
 					unsigned char Parameter1)
@@ -3048,7 +3048,7 @@ Failure:
   DAC960_InitializeController initializes Controller.
 */
 
-static boolean 
+static bool 
 DAC960_InitializeController(DAC960_Controller_T *Controller)
 {
   if (DAC960_ReadControllerConfiguration(Controller) &&
@@ -3445,8 +3445,8 @@ static void DAC960_RequestFunction(struct request_queue *RequestQueue)
   individual Buffer.
 */
 
-static inline boolean DAC960_ProcessCompletedRequest(DAC960_Command_T *Command,
-						 boolean SuccessfulIO)
+static inline bool DAC960_ProcessCompletedRequest(DAC960_Command_T *Command,
+						 bool SuccessfulIO)
 {
 	struct request *Request = Command->Request;
 	int UpToDate;
@@ -3572,7 +3572,7 @@ static void DAC960_V1_ProcessCompletedCommand(DAC960_Command_T *Command)
   else if (CommandType == DAC960_ReadRetryCommand ||
 	   CommandType == DAC960_WriteRetryCommand)
     {
-      boolean normal_completion;
+      bool normal_completion;
 #ifdef FORCE_RETRY_FAILURE_DEBUG
       static int retry_count = 1;
 #endif
@@ -4659,7 +4659,7 @@ static void DAC960_V2_ProcessCompletedCommand(DAC960_Command_T *Command)
   else if (CommandType == DAC960_ReadRetryCommand ||
 	   CommandType == DAC960_WriteRetryCommand)
     {
-      boolean normal_completion;
+      bool normal_completion;
 
 #ifdef FORCE_RETRY_FAILURE_DEBUG
       static int retry_count = 1;
@@ -5632,7 +5632,7 @@ static void DAC960_MonitoringTimerFunction(unsigned long TimerData)
 	&Controller->V2.ControllerInformation;
       unsigned int StatusChangeCounter =
 	Controller->V2.HealthStatusBuffer->StatusChangeCounter;
-      boolean ForceMonitoringCommand = false;
+      bool ForceMonitoringCommand = false;
       if (time_after(jiffies, Controller->SecondaryMonitoringTime
 	  + DAC960_SecondaryMonitoringInterval))
 	{
@@ -5696,7 +5696,7 @@ static void DAC960_MonitoringTimerFunction(unsigned long TimerData)
   necessary.  It returns true if there is enough room and false otherwise.
 */
 
-static boolean DAC960_CheckStatusBuffer(DAC960_Controller_T *Controller,
+static bool DAC960_CheckStatusBuffer(DAC960_Controller_T *Controller,
 					unsigned int ByteCount)
 {
   unsigned char *NewStatusBuffer;
@@ -5744,7 +5744,7 @@ static void DAC960_Message(DAC960_MessageLevel_T MessageLevel,
 			   ...)
 {
   static unsigned char Buffer[DAC960_LineBufferSize];
-  static boolean BeginningOfLine = true;
+  static bool BeginningOfLine = true;
   va_list Arguments;
   int Length = 0;
   va_start(Arguments, Controller);
@@ -5837,7 +5837,7 @@ static void DAC960_Message(DAC960_MessageLevel_T MessageLevel,
   Channel and TargetID and returns true on success and false on failure.
 */
 
-static boolean DAC960_ParsePhysicalDevice(DAC960_Controller_T *Controller,
+static bool DAC960_ParsePhysicalDevice(DAC960_Controller_T *Controller,
 					  char *UserCommandString,
 					  unsigned char *Channel,
 					  unsigned char *TargetID)
@@ -5870,7 +5870,7 @@ static boolean DAC960_ParsePhysicalDevice(DAC960_Controller_T *Controller,
   returns true on success and false on failure.
 */
 
-static boolean DAC960_ParseLogicalDrive(DAC960_Controller_T *Controller,
+static bool DAC960_ParseLogicalDrive(DAC960_Controller_T *Controller,
 					char *UserCommandString,
 					unsigned char *LogicalDriveNumber)
 {
@@ -5951,7 +5951,7 @@ static void DAC960_V1_SetDeviceState(DAC960_Controller_T *Controller,
   Controllers.
 */
 
-static boolean DAC960_V1_ExecuteUserCommand(DAC960_Controller_T *Controller,
+static bool DAC960_V1_ExecuteUserCommand(DAC960_Controller_T *Controller,
 					    unsigned char *UserCommand)
 {
   DAC960_Command_T *Command;
@@ -6166,7 +6166,7 @@ failure:
   on failure.
 */
 
-static boolean DAC960_V2_TranslatePhysicalDevice(DAC960_Command_T *Command,
+static bool DAC960_V2_TranslatePhysicalDevice(DAC960_Command_T *Command,
 						 unsigned char Channel,
 						 unsigned char TargetID,
 						 unsigned short
@@ -6213,7 +6213,7 @@ static boolean DAC960_V2_TranslatePhysicalDevice(DAC960_Command_T *Command,
   Controllers.
 */
 
-static boolean DAC960_V2_ExecuteUserCommand(DAC960_Controller_T *Controller,
+static bool DAC960_V2_ExecuteUserCommand(DAC960_Controller_T *Controller,
 					    unsigned char *UserCommand)
 {
   DAC960_Command_T *Command;
diff --git a/drivers/block/DAC960.h b/drivers/block/DAC960.h
index 6148073..3370564 100644
--- a/drivers/block/DAC960.h
+++ b/drivers/block/DAC960.h
@@ -68,13 +68,6 @@
 #define DAC690_V2_PciDmaMask	0xffffffffffffffffULL
 
 /*
-  Define a Boolean data type.
-*/
-
-typedef bool boolean;
-
-
-/*
   Define a 32/64 bit I/O Address data type.
 */
 
@@ -139,25 +132,25 @@ typedef struct DAC960_SCSI_Inquiry
   unsigned char PeripheralDeviceType:5;			/* Byte 0 Bits 0-4 */
   unsigned char PeripheralQualifier:3;			/* Byte 0 Bits 5-7 */
   unsigned char DeviceTypeModifier:7;			/* Byte 1 Bits 0-6 */
-  boolean RMB:1;					/* Byte 1 Bit 7 */
+  bool RMB:1;						/* Byte 1 Bit 7 */
   unsigned char ANSI_ApprovedVersion:3;			/* Byte 2 Bits 0-2 */
   unsigned char ECMA_Version:3;				/* Byte 2 Bits 3-5 */
   unsigned char ISO_Version:2;				/* Byte 2 Bits 6-7 */
   unsigned char ResponseDataFormat:4;			/* Byte 3 Bits 0-3 */
   unsigned char :2;					/* Byte 3 Bits 4-5 */
-  boolean TrmIOP:1;					/* Byte 3 Bit 6 */
-  boolean AENC:1;					/* Byte 3 Bit 7 */
+  bool TrmIOP:1;					/* Byte 3 Bit 6 */
+  bool AENC:1;						/* Byte 3 Bit 7 */
   unsigned char AdditionalLength;			/* Byte 4 */
   unsigned char :8;					/* Byte 5 */
   unsigned char :8;					/* Byte 6 */
-  boolean SftRe:1;					/* Byte 7 Bit 0 */
-  boolean CmdQue:1;					/* Byte 7 Bit 1 */
-  boolean :1;						/* Byte 7 Bit 2 */
-  boolean Linked:1;					/* Byte 7 Bit 3 */
-  boolean Sync:1;					/* Byte 7 Bit 4 */
-  boolean WBus16:1;					/* Byte 7 Bit 5 */
-  boolean WBus32:1;					/* Byte 7 Bit 6 */
-  boolean RelAdr:1;					/* Byte 7 Bit 7 */
+  bool SftRe:1;						/* Byte 7 Bit 0 */
+  bool CmdQue:1;					/* Byte 7 Bit 1 */
+  bool :1;						/* Byte 7 Bit 2 */
+  bool Linked:1;					/* Byte 7 Bit 3 */
+  bool Sync:1;						/* Byte 7 Bit 4 */
+  bool WBus16:1;					/* Byte 7 Bit 5 */
+  bool WBus32:1;					/* Byte 7 Bit 6 */
+  bool RelAdr:1;					/* Byte 7 Bit 7 */
   unsigned char VendorIdentification[8];		/* Bytes 8-15 */
   unsigned char ProductIdentification[16];		/* Bytes 16-31 */
   unsigned char ProductRevisionLevel[4];		/* Bytes 32-35 */
@@ -215,13 +208,13 @@ DAC960_SCSI_RequestSenseKey_T;
 typedef struct DAC960_SCSI_RequestSense
 {
   unsigned char ErrorCode:7;				/* Byte 0 Bits 0-6 */
-  boolean Valid:1;					/* Byte 0 Bit 7 */
+  bool Valid:1;						/* Byte 0 Bit 7 */
   unsigned char SegmentNumber;				/* Byte 1 */
   DAC960_SCSI_RequestSenseKey_T SenseKey:4;		/* Byte 2 Bits 0-3 */
   unsigned char :1;					/* Byte 2 Bit 4 */
-  boolean ILI:1;					/* Byte 2 Bit 5 */
-  boolean EOM:1;					/* Byte 2 Bit 6 */
-  boolean Filemark:1;					/* Byte 2 Bit 7 */
+  bool ILI:1;						/* Byte 2 Bit 5 */
+  bool EOM:1;						/* Byte 2 Bit 6 */
+  bool Filemark:1;					/* Byte 2 Bit 7 */
   unsigned char Information[4];				/* Bytes 3-6 */
   unsigned char AdditionalSenseLength;			/* Byte 7 */
   unsigned char CommandSpecificInformation[4];		/* Bytes 8-11 */
@@ -381,8 +374,8 @@ typedef struct DAC960_V1_Enquiry
   unsigned int LogicalDriveSizes[32];			/* Bytes 4-131 */
   unsigned short FlashAge;				/* Bytes 132-133 */
   struct {
-    boolean DeferredWriteError:1;			/* Byte 134 Bit 0 */
-    boolean BatteryLow:1;				/* Byte 134 Bit 1 */
+    bool DeferredWriteError:1;				/* Byte 134 Bit 0 */
+    bool BatteryLow:1;					/* Byte 134 Bit 1 */
     unsigned char :6;					/* Byte 134 Bits 2-7 */
   } StatusFlags;
   unsigned char :8;					/* Byte 135 */
@@ -410,7 +403,7 @@ typedef struct DAC960_V1_Enquiry
   unsigned char RebuildCount;				/* Byte 150 */
   struct {
     unsigned char :3;					/* Byte 151 Bits 0-2 */
-    boolean BatteryBackupUnitPresent:1;			/* Byte 151 Bit 3 */
+    bool BatteryBackupUnitPresent:1;			/* Byte 151 Bit 3 */
     unsigned char :3;					/* Byte 151 Bits 4-6 */
     unsigned char :1;					/* Byte 151 Bit 7 */
   } MiscFlags;
@@ -492,8 +485,8 @@ typedef struct DAC960_V1_Enquiry2
       DAC960_V1_ErrorCorrection_ECC =		0x2,
       DAC960_V1_ErrorCorrection_Last =		0x7
     } __attribute__ ((packed)) ErrorCorrection:3;	/* Byte 40 Bits 3-5 */
-    boolean FastPageMode:1;				/* Byte 40 Bit 6 */
-    boolean LowPowerMemory:1;				/* Byte 40 Bit 7 */
+    bool FastPageMode:1;				/* Byte 40 Bit 6 */
+    bool LowPowerMemory:1;				/* Byte 40 Bit 7 */
     unsigned char :8;					/* Bytes 41 */
   } MemoryType;
   unsigned short ClockSpeed;				/* Bytes 42-43 */
@@ -538,7 +531,7 @@ typedef struct DAC960_V1_Enquiry2
       DAC960_V1_Ultra =				0x1,
       DAC960_V1_Ultra2 =			0x2
     } __attribute__ ((packed)) BusSpeed:2;		/* Byte 106 Bits 2-3 */
-    boolean Differential:1;				/* Byte 106 Bit 4 */
+    bool Differential:1;				/* Byte 106 Bit 4 */
     unsigned char :3;					/* Byte 106 Bits 5-7 */
   } SCSICapability;
   unsigned char :8;					/* Byte 107 */
@@ -554,10 +547,10 @@ typedef struct DAC960_V1_Enquiry2
   } __attribute__ ((packed)) FaultManagementType;	/* Byte 114 */
   unsigned char :8;					/* Byte 115 */
   struct {
-    boolean Clustering:1;				/* Byte 116 Bit 0 */
-    boolean MylexOnlineRAIDExpansion:1;			/* Byte 116 Bit 1 */
-    boolean ReadAhead:1;				/* Byte 116 Bit 2 */
-    boolean BackgroundInitialization:1;			/* Byte 116 Bit 3 */
+    bool Clustering:1;					/* Byte 116 Bit 0 */
+    bool MylexOnlineRAIDExpansion:1;			/* Byte 116 Bit 1 */
+    bool ReadAhead:1;					/* Byte 116 Bit 2 */
+    bool BackgroundInitialization:1;			/* Byte 116 Bit 3 */
     unsigned int :28;					/* Bytes 116-119 */
   } FirmwareFeatures;
   unsigned int :32;					/* Bytes 120-123 */
@@ -589,7 +582,7 @@ typedef struct DAC960_V1_LogicalDriveInformation
   unsigned int LogicalDriveSize;			/* Bytes 0-3 */
   DAC960_V1_LogicalDriveState_T LogicalDriveState;	/* Byte 4 */
   unsigned char RAIDLevel:7;				/* Byte 5 Bits 0-6 */
-  boolean WriteBack:1;					/* Byte 5 Bit 7 */
+  bool WriteBack:1;					/* Byte 5 Bit 7 */
   unsigned short :16;					/* Bytes 6-7 */
 }
 DAC960_V1_LogicalDriveInformation_T;
@@ -630,13 +623,13 @@ typedef struct DAC960_V1_EventLogEntry
   unsigned char :2;					/* Byte 3 Bits 6-7 */
   unsigned short SequenceNumber;			/* Bytes 4-5 */
   unsigned char ErrorCode:7;				/* Byte 6 Bits 0-6 */
-  boolean Valid:1;					/* Byte 6 Bit 7 */
+  bool Valid:1;						/* Byte 6 Bit 7 */
   unsigned char SegmentNumber;				/* Byte 7 */
   DAC960_SCSI_RequestSenseKey_T SenseKey:4;		/* Byte 8 Bits 0-3 */
   unsigned char :1;					/* Byte 8 Bit 4 */
-  boolean ILI:1;					/* Byte 8 Bit 5 */
-  boolean EOM:1;					/* Byte 8 Bit 6 */
-  boolean Filemark:1;					/* Byte 8 Bit 7 */
+  bool ILI:1;						/* Byte 8 Bit 5 */
+  bool EOM:1;						/* Byte 8 Bit 6 */
+  bool Filemark:1;					/* Byte 8 Bit 7 */
   unsigned char Information[4];				/* Bytes 9-12 */
   unsigned char AdditionalSenseLength;			/* Byte 13 */
   unsigned char CommandSpecificInformation[4];		/* Bytes 14-17 */
@@ -670,7 +663,7 @@ DAC960_V1_PhysicalDeviceState_T;
 
 typedef struct DAC960_V1_DeviceState
 {
-  boolean Present:1;					/* Byte 0 Bit 0 */
+  bool Present:1;					/* Byte 0 Bit 0 */
   unsigned char :7;					/* Byte 0 Bits 1-7 */
   enum {
     DAC960_V1_OtherType =			0x0,
@@ -678,12 +671,12 @@ typedef struct DAC960_V1_DeviceState
     DAC960_V1_SequentialType =			0x2,
     DAC960_V1_CDROM_or_WORM_Type =		0x3
     } __attribute__ ((packed)) DeviceType:2;		/* Byte 1 Bits 0-1 */
-  boolean :1;						/* Byte 1 Bit 2 */
-  boolean Fast20:1;					/* Byte 1 Bit 3 */
-  boolean Sync:1;					/* Byte 1 Bit 4 */
-  boolean Fast:1;					/* Byte 1 Bit 5 */
-  boolean Wide:1;					/* Byte 1 Bit 6 */
-  boolean TaggedQueuingSupported:1;			/* Byte 1 Bit 7 */
+  bool :1;						/* Byte 1 Bit 2 */
+  bool Fast20:1;					/* Byte 1 Bit 3 */
+  bool Sync:1;						/* Byte 1 Bit 4 */
+  bool Fast:1;						/* Byte 1 Bit 5 */
+  bool Wide:1;						/* Byte 1 Bit 6 */
+  bool TaggedQueuingSupported:1;			/* Byte 1 Bit 7 */
   DAC960_V1_PhysicalDeviceState_T DeviceState;		/* Byte 2 */
   unsigned char :8;					/* Byte 3 */
   unsigned char SynchronousMultiplier;			/* Byte 4 */
@@ -765,15 +758,15 @@ DAC960_V1_ErrorTable_T;
 typedef struct DAC960_V1_Config2
 {
   unsigned char :1;					/* Byte 0 Bit 0 */
-  boolean ActiveNegationEnabled:1;			/* Byte 0 Bit 1 */
+  bool ActiveNegationEnabled:1;				/* Byte 0 Bit 1 */
   unsigned char :5;					/* Byte 0 Bits 2-6 */
-  boolean NoRescanIfResetReceivedDuringScan:1;		/* Byte 0 Bit 7 */
-  boolean StorageWorksSupportEnabled:1;			/* Byte 1 Bit 0 */
-  boolean HewlettPackardSupportEnabled:1;		/* Byte 1 Bit 1 */
-  boolean NoDisconnectOnFirstCommand:1;			/* Byte 1 Bit 2 */
+  bool NoRescanIfResetReceivedDuringScan:1;		/* Byte 0 Bit 7 */
+  bool StorageWorksSupportEnabled:1;			/* Byte 1 Bit 0 */
+  bool HewlettPackardSupportEnabled:1;			/* Byte 1 Bit 1 */
+  bool NoDisconnectOnFirstCommand:1;			/* Byte 1 Bit 2 */
   unsigned char :2;					/* Byte 1 Bits 3-4 */
-  boolean AEMI_ARM:1;					/* Byte 1 Bit 5 */
-  boolean AEMI_OFM:1;					/* Byte 1 Bit 6 */
+  bool AEMI_ARM:1;					/* Byte 1 Bit 5 */
+  bool AEMI_OFM:1;					/* Byte 1 Bit 6 */
   unsigned char :1;					/* Byte 1 Bit 7 */
   enum {
     DAC960_V1_OEMID_Mylex =			0x00,
@@ -787,13 +780,13 @@ typedef struct DAC960_V1_Config2
   unsigned char PhysicalSector;				/* Byte 4 */
   unsigned char LogicalSector;				/* Byte 5 */
   unsigned char BlockFactor;				/* Byte 6 */
-  boolean ReadAheadEnabled:1;				/* Byte 7 Bit 0 */
-  boolean LowBIOSDelay:1;				/* Byte 7 Bit 1 */
+  bool ReadAheadEnabled:1;				/* Byte 7 Bit 0 */
+  bool LowBIOSDelay:1;					/* Byte 7 Bit 1 */
   unsigned char :2;					/* Byte 7 Bits 2-3 */
-  boolean ReassignRestrictedToOneSector:1;		/* Byte 7 Bit 4 */
+  bool ReassignRestrictedToOneSector:1;			/* Byte 7 Bit 4 */
   unsigned char :1;					/* Byte 7 Bit 5 */
-  boolean ForceUnitAccessDuringWriteRecovery:1;		/* Byte 7 Bit 6 */
-  boolean EnableLeftSymmetricRAID5Algorithm:1;		/* Byte 7 Bit 7 */
+  bool ForceUnitAccessDuringWriteRecovery:1;		/* Byte 7 Bit 6 */
+  bool EnableLeftSymmetricRAID5Algorithm:1;		/* Byte 7 Bit 7 */
   unsigned char DefaultRebuildRate;			/* Byte 8 */
   unsigned char :8;					/* Byte 9 */
   unsigned char BlocksPerCacheLine;			/* Byte 10 */
@@ -805,10 +798,10 @@ typedef struct DAC960_V1_Config2
       DAC960_V1_Sync_5MHz =			0x2,
       DAC960_V1_Sync_10or20MHz =		0x3	/* Byte 11 Bits 0-1 */
     } __attribute__ ((packed)) Speed:2;
-    boolean Force8Bit:1;				/* Byte 11 Bit 2 */
-    boolean DisableFast20:1;				/* Byte 11 Bit 3 */
+    bool Force8Bit:1;					/* Byte 11 Bit 2 */
+    bool DisableFast20:1;				/* Byte 11 Bit 3 */
     unsigned char :3;					/* Byte 11 Bits 4-6 */
-    boolean EnableTaggedQueuing:1;			/* Byte 11 Bit 7 */
+    bool EnableTaggedQueuing:1;				/* Byte 11 Bit 7 */
   } __attribute__ ((packed)) ChannelParameters[6];	/* Bytes 12-17 */
   unsigned char SCSIInitiatorID;			/* Byte 18 */
   unsigned char :8;					/* Byte 19 */
@@ -819,8 +812,8 @@ typedef struct DAC960_V1_Config2
   unsigned char SimultaneousDeviceSpinUpCount;		/* Byte 21 */
   unsigned char SecondsDelayBetweenSpinUps;		/* Byte 22 */
   unsigned char Reserved1[29];				/* Bytes 23-51 */
-  boolean BIOSDisabled:1;				/* Byte 52 Bit 0 */
-  boolean CDROMBootEnabled:1;				/* Byte 52 Bit 1 */
+  bool BIOSDisabled:1;					/* Byte 52 Bit 0 */
+  bool CDROMBootEnabled:1;				/* Byte 52 Bit 1 */
   unsigned char :3;					/* Byte 52 Bits 2-4 */
   enum {
     DAC960_V1_Geometry_128_32 =			0x0,
@@ -849,7 +842,7 @@ typedef struct DAC960_V1_DCDB
     DAC960_V1_DCDB_DataTransferSystemToDevice = 2,
     DAC960_V1_DCDB_IllegalDataTransfer =	3
   } __attribute__ ((packed)) Direction:2;		 /* Byte 1 Bits 0-1 */
-  boolean EarlyStatus:1;				 /* Byte 1 Bit 2 */
+  bool EarlyStatus:1;					 /* Byte 1 Bit 2 */
   unsigned char :1;					 /* Byte 1 Bit 3 */
   enum {
     DAC960_V1_DCDB_Timeout_24_hours =		0,
@@ -857,8 +850,8 @@ typedef struct DAC960_V1_DCDB
     DAC960_V1_DCDB_Timeout_60_seconds =		2,
     DAC960_V1_DCDB_Timeout_10_minutes =		3
   } __attribute__ ((packed)) Timeout:2;			 /* Byte 1 Bits 4-5 */
-  boolean NoAutomaticRequestSense:1;			 /* Byte 1 Bit 6 */
-  boolean DisconnectPermitted:1;			 /* Byte 1 Bit 7 */
+  bool NoAutomaticRequestSense:1;			 /* Byte 1 Bit 6 */
+  bool DisconnectPermitted:1;				 /* Byte 1 Bit 7 */
   unsigned short TransferLength;			 /* Bytes 2-3 */
   DAC960_BusAddress32_T BusAddress;			 /* Bytes 4-7 */
   unsigned char CDBLength:4;				 /* Byte 8 Bits 0-3 */
@@ -920,7 +913,7 @@ typedef union DAC960_V1_CommandMailbox
     DAC960_V1_CommandIdentifier_T CommandIdentifier;	/* Byte 1 */
     unsigned char Dummy1[5];				/* Bytes 2-6 */
     unsigned char LogicalDriveNumber:6;			/* Byte 7 Bits 0-6 */
-    boolean AutoRestore:1;				/* Byte 7 Bit 7 */
+    bool AutoRestore:1;					/* Byte 7 Bit 7 */
     unsigned char Dummy2[8];				/* Bytes 8-15 */
   } __attribute__ ((packed)) Type3C;
   struct {
@@ -1070,9 +1063,9 @@ typedef struct DAC960_V2_MemoryType
     DAC960_V2_MemoryType_SDRAM =		0x04,
     DAC960_V2_MemoryType_Last =			0x1F
   } __attribute__ ((packed)) MemoryType:5;		/* Byte 0 Bits 0-4 */
-  boolean :1;						/* Byte 0 Bit 5 */
-  boolean MemoryParity:1;				/* Byte 0 Bit 6 */
-  boolean MemoryECC:1;					/* Byte 0 Bit 7 */
+  bool :1;						/* Byte 0 Bit 5 */
+  bool MemoryParity:1;					/* Byte 0 Bit 6 */
+  bool MemoryECC:1;					/* Byte 0 Bit 7 */
 }
 DAC960_V2_MemoryType_T;
 
@@ -1187,13 +1180,13 @@ typedef struct DAC960_V2_ControllerInfo
   unsigned char OEM_Code;				/* Byte 131 */
   unsigned char VendorName[16];				/* Bytes 132-147 */
   /* Other Physical/Controller/Operation Information */
-  boolean BBU_Present:1;				/* Byte 148 Bit 0 */
-  boolean ActiveActiveClusteringMode:1;			/* Byte 148 Bit 1 */
+  bool BBU_Present:1;					/* Byte 148 Bit 0 */
+  bool ActiveActiveClusteringMode:1;			/* Byte 148 Bit 1 */
   unsigned char :6;					/* Byte 148 Bits 2-7 */
   unsigned char :8;					/* Byte 149 */
   unsigned short :16;					/* Bytes 150-151 */
   /* Physical Device Scan Information */
-  boolean PhysicalScanActive:1;				/* Byte 152 Bit 0 */
+  bool PhysicalScanActive:1;				/* Byte 152 Bit 0 */
   unsigned char :7;					/* Byte 152 Bits 1-7 */
   unsigned char PhysicalDeviceChannelNumber;		/* Byte 153 */
   unsigned char PhysicalDeviceTargetID;			/* Byte 154 */
@@ -1305,8 +1298,8 @@ typedef struct DAC960_V2_ControllerInfo
   unsigned int FreeIOP;					/* Bytes 468-471 */
   unsigned short MaximumCombLengthInBlocks;		/* Bytes 472-473 */
   unsigned short NumberOfConfigurationGroups;		/* Bytes 474-475 */
-  boolean InstallationAbortStatus:1;			/* Byte 476 Bit 0 */
-  boolean MaintenanceModeStatus:1;			/* Byte 476 Bit 1 */
+  bool InstallationAbortStatus:1;			/* Byte 476 Bit 0 */
+  bool MaintenanceModeStatus:1;				/* Byte 476 Bit 1 */
   unsigned int :24;					/* Bytes 476-479 */
   unsigned char Reserved10[32];				/* Bytes 480-511 */
   unsigned char Reserved11[512];			/* Bytes 512-1023 */
@@ -1357,33 +1350,33 @@ typedef struct DAC960_V2_LogicalDeviceInfo
       DAC960_V2_IntelligentWriteCacheEnabled =	0x3,
       DAC960_V2_WriteCache_Last =		0x7
     } __attribute__ ((packed)) WriteCache:3;		/* Byte 8 Bits 3-5 */
-    boolean :1;						/* Byte 8 Bit 6 */
-    boolean LogicalDeviceInitialized:1;			/* Byte 8 Bit 7 */
+    bool :1;						/* Byte 8 Bit 6 */
+    bool LogicalDeviceInitialized:1;			/* Byte 8 Bit 7 */
   } LogicalDeviceControl;				/* Byte 8 */
   /* Logical Device Operations Status */
-  boolean ConsistencyCheckInProgress:1;			/* Byte 9 Bit 0 */
-  boolean RebuildInProgress:1;				/* Byte 9 Bit 1 */
-  boolean BackgroundInitializationInProgress:1;		/* Byte 9 Bit 2 */
-  boolean ForegroundInitializationInProgress:1;		/* Byte 9 Bit 3 */
-  boolean DataMigrationInProgress:1;			/* Byte 9 Bit 4 */
-  boolean PatrolOperationInProgress:1;			/* Byte 9 Bit 5 */
+  bool ConsistencyCheckInProgress:1;			/* Byte 9 Bit 0 */
+  bool RebuildInProgress:1;				/* Byte 9 Bit 1 */
+  bool BackgroundInitializationInProgress:1;		/* Byte 9 Bit 2 */
+  bool ForegroundInitializationInProgress:1;		/* Byte 9 Bit 3 */
+  bool DataMigrationInProgress:1;			/* Byte 9 Bit 4 */
+  bool PatrolOperationInProgress:1;			/* Byte 9 Bit 5 */
   unsigned char :2;					/* Byte 9 Bits 6-7 */
   unsigned char RAID5WriteUpdate;			/* Byte 10 */
   unsigned char RAID5Algorithm;				/* Byte 11 */
   unsigned short LogicalDeviceNumber;			/* Bytes 12-13 */
   /* BIOS Info */
-  boolean BIOSDisabled:1;				/* Byte 14 Bit 0 */
-  boolean CDROMBootEnabled:1;				/* Byte 14 Bit 1 */
-  boolean DriveCoercionEnabled:1;			/* Byte 14 Bit 2 */
-  boolean WriteSameDisabled:1;				/* Byte 14 Bit 3 */
-  boolean HBA_ModeEnabled:1;				/* Byte 14 Bit 4 */
+  bool BIOSDisabled:1;					/* Byte 14 Bit 0 */
+  bool CDROMBootEnabled:1;				/* Byte 14 Bit 1 */
+  bool DriveCoercionEnabled:1;				/* Byte 14 Bit 2 */
+  bool WriteSameDisabled:1;				/* Byte 14 Bit 3 */
+  bool HBA_ModeEnabled:1;				/* Byte 14 Bit 4 */
   enum {
     DAC960_V2_Geometry_128_32 =			0x0,
     DAC960_V2_Geometry_255_63 =			0x1,
     DAC960_V2_Geometry_Reserved1 =		0x2,
     DAC960_V2_Geometry_Reserved2 =		0x3
   } __attribute__ ((packed)) DriveGeometry:2;		/* Byte 14 Bits 5-6 */
-  boolean SuperReadAheadEnabled:1;			/* Byte 14 Bit 7 */
+  bool SuperReadAheadEnabled:1;				/* Byte 14 Bit 7 */
   unsigned char :8;					/* Byte 15 */
   /* Error Counters */
   unsigned short SoftErrors;				/* Bytes 16-17 */
@@ -1446,13 +1439,13 @@ typedef struct DAC960_V2_PhysicalDeviceInfo
   unsigned char TargetID;				/* Byte 2 */
   unsigned char LogicalUnit;				/* Byte 3 */
   /* Configuration Status Bits */
-  boolean PhysicalDeviceFaultTolerant:1;		/* Byte 4 Bit 0 */
-  boolean PhysicalDeviceConnected:1;			/* Byte 4 Bit 1 */
-  boolean PhysicalDeviceLocalToController:1;		/* Byte 4 Bit 2 */
+  bool PhysicalDeviceFaultTolerant:1;			/* Byte 4 Bit 0 */
+  bool PhysicalDeviceConnected:1;			/* Byte 4 Bit 1 */
+  bool PhysicalDeviceLocalToController:1;		/* Byte 4 Bit 2 */
   unsigned char :5;					/* Byte 4 Bits 3-7 */
   /* Multiple Host/Controller Status Bits */
-  boolean RemoteHostSystemDead:1;			/* Byte 5 Bit 0 */
-  boolean RemoteControllerDead:1;			/* Byte 5 Bit 1 */
+  bool RemoteHostSystemDead:1;				/* Byte 5 Bit 0 */
+  bool RemoteControllerDead:1;				/* Byte 5 Bit 1 */
   unsigned char :6;					/* Byte 5 Bits 2-7 */
   DAC960_V2_PhysicalDeviceState_T PhysicalDeviceState;	/* Byte 6 */
   unsigned char NegotiatedDataWidthBits;		/* Byte 7 */
@@ -1464,12 +1457,12 @@ typedef struct DAC960_V2_PhysicalDeviceInfo
   unsigned char NetworkAddress[16];			/* Bytes 16-31 */
   unsigned short MaximumTags;				/* Bytes 32-33 */
   /* Physical Device Operations Status */
-  boolean ConsistencyCheckInProgress:1;			/* Byte 34 Bit 0 */
-  boolean RebuildInProgress:1;				/* Byte 34 Bit 1 */
-  boolean MakingDataConsistentInProgress:1;		/* Byte 34 Bit 2 */
-  boolean PhysicalDeviceInitializationInProgress:1;	/* Byte 34 Bit 3 */
-  boolean DataMigrationInProgress:1;			/* Byte 34 Bit 4 */
-  boolean PatrolOperationInProgress:1;			/* Byte 34 Bit 5 */
+  bool ConsistencyCheckInProgress:1;			/* Byte 34 Bit 0 */
+  bool RebuildInProgress:1;				/* Byte 34 Bit 1 */
+  bool MakingDataConsistentInProgress:1;		/* Byte 34 Bit 2 */
+  bool PhysicalDeviceInitializationInProgress:1;	/* Byte 34 Bit 3 */
+  bool DataMigrationInProgress:1;			/* Byte 34 Bit 4 */
+  bool PatrolOperationInProgress:1;			/* Byte 34 Bit 5 */
   unsigned char :2;					/* Byte 34 Bits 6-7 */
   unsigned char LongOperationStatus;			/* Byte 35 */
   unsigned char ParityErrors;				/* Byte 36 */
@@ -1555,14 +1548,14 @@ DAC960_V2_Event_T;
 
 typedef struct DAC960_V2_CommandControlBits
 {
-  boolean ForceUnitAccess:1;				/* Byte 0 Bit 0 */
-  boolean DisablePageOut:1;				/* Byte 0 Bit 1 */
-  boolean :1;						/* Byte 0 Bit 2 */
-  boolean AdditionalScatterGatherListMemory:1;		/* Byte 0 Bit 3 */
-  boolean DataTransferControllerToHost:1;		/* Byte 0 Bit 4 */
-  boolean :1;						/* Byte 0 Bit 5 */
-  boolean NoAutoRequestSense:1;				/* Byte 0 Bit 6 */
-  boolean DisconnectProhibited:1;			/* Byte 0 Bit 7 */
+  bool ForceUnitAccess:1;				/* Byte 0 Bit 0 */
+  bool DisablePageOut:1;				/* Byte 0 Bit 1 */
+  bool :1;						/* Byte 0 Bit 2 */
+  bool AdditionalScatterGatherListMemory:1;		/* Byte 0 Bit 3 */
+  bool DataTransferControllerToHost:1;			/* Byte 0 Bit 4 */
+  bool :1;						/* Byte 0 Bit 5 */
+  bool NoAutoRequestSense:1;				/* Byte 0 Bit 6 */
+  bool DisconnectProhibited:1;				/* Byte 0 Bit 7 */
 }
 DAC960_V2_CommandControlBits_T;
 
@@ -1825,8 +1818,8 @@ typedef union DAC960_V2_CommandMailbox
     DAC960_V2_CommandTimeout_T CommandTimeout;		/* Byte 19 */
     unsigned char RequestSenseSize;			/* Byte 20 */
     unsigned char IOCTL_Opcode;				/* Byte 21 */
-    boolean RestoreConsistency:1;			/* Byte 22 Bit 0 */
-    boolean InitializedAreaOnly:1;			/* Byte 22 Bit 1 */
+    bool RestoreConsistency:1;				/* Byte 22 Bit 0 */
+    bool InitializedAreaOnly:1;				/* Byte 22 Bit 1 */
     unsigned char :6;					/* Byte 22 Bits 2-7 */
     unsigned char Reserved[9];				/* Bytes 23-31 */
     DAC960_V2_DataTransferMemoryAddress_T
@@ -2190,7 +2183,7 @@ typedef union DAC960_V1_StatusMailbox
   struct {
     DAC960_V1_CommandIdentifier_T CommandIdentifier;	/* Byte 0 */
     unsigned char :7;					/* Byte 1 Bits 0-6 */
-    boolean Valid:1;					/* Byte 1 Bit 7 */
+    bool Valid:1;					/* Byte 1 Bit 7 */
     DAC960_V1_CommandStatus_T CommandStatus;		/* Bytes 2-3 */
   } Fields;
 }
@@ -2322,12 +2315,12 @@ typedef struct DAC960_Controller
   unsigned long ShutdownMonitoringTimer;
   unsigned long LastProgressReportTime;
   unsigned long LastCurrentStatusTime;
-  boolean ControllerInitialized;
-  boolean MonitoringCommandDeferred;
-  boolean EphemeralProgressMessage;
-  boolean DriveSpinUpMessageDisplayed;
-  boolean MonitoringAlertMode;
-  boolean SuppressEnclosureMessages;
+  bool ControllerInitialized;
+  bool MonitoringCommandDeferred;
+  bool EphemeralProgressMessage;
+  bool DriveSpinUpMessageDisplayed;
+  bool MonitoringAlertMode;
+  bool SuppressEnclosureMessages;
   struct timer_list MonitoringTimer;
   struct gendisk *disks[DAC960_MaxLogicalDrives];
   struct pci_pool *ScatterGatherPool;
@@ -2342,11 +2335,11 @@ typedef struct DAC960_Controller
   DAC960_Command_T InitialCommand;
   DAC960_Command_T *Commands[DAC960_MaxDriverQueueDepth];
   struct proc_dir_entry *ControllerProcEntry;
-  boolean LogicalDriveInitiallyAccessible[DAC960_MaxLogicalDrives];
+  bool LogicalDriveInitiallyAccessible[DAC960_MaxLogicalDrives];
   void (*QueueCommand)(DAC960_Command_T *Command);
-  boolean (*ReadControllerConfiguration)(struct DAC960_Controller *);
-  boolean (*ReadDeviceConfiguration)(struct DAC960_Controller *);
-  boolean (*ReportDeviceConfiguration)(struct DAC960_Controller *);
+  bool (*ReadControllerConfiguration)(struct DAC960_Controller *);
+  bool (*ReadDeviceConfiguration)(struct DAC960_Controller *);
+  bool (*ReportDeviceConfiguration)(struct DAC960_Controller *);
   void (*QueueReadWriteCommand)(DAC960_Command_T *Command);
   union {
     struct {
@@ -2359,21 +2352,21 @@ typedef struct DAC960_Controller
       unsigned short OldEventLogSequenceNumber;
       unsigned short DeviceStateChannel;
       unsigned short DeviceStateTargetID;
-      boolean DualModeMemoryMailboxInterface;
-      boolean BackgroundInitializationStatusSupported;
-      boolean SAFTE_EnclosureManagementEnabled;
-      boolean NeedLogicalDriveInformation;
-      boolean NeedErrorTableInformation;
-      boolean NeedDeviceStateInformation;
-      boolean NeedDeviceInquiryInformation;
-      boolean NeedDeviceSerialNumberInformation;
-      boolean NeedRebuildProgress;
-      boolean NeedConsistencyCheckProgress;
-      boolean NeedBackgroundInitializationStatus;
-      boolean StartDeviceStateScan;
-      boolean RebuildProgressFirst;
-      boolean RebuildFlagPending;
-      boolean RebuildStatusPending;
+      bool DualModeMemoryMailboxInterface;
+      bool BackgroundInitializationStatusSupported;
+      bool SAFTE_EnclosureManagementEnabled;
+      bool NeedLogicalDriveInformation;
+      bool NeedErrorTableInformation;
+      bool NeedDeviceStateInformation;
+      bool NeedDeviceInquiryInformation;
+      bool NeedDeviceSerialNumberInformation;
+      bool NeedRebuildProgress;
+      bool NeedConsistencyCheckProgress;
+      bool NeedBackgroundInitializationStatus;
+      bool StartDeviceStateScan;
+      bool RebuildProgressFirst;
+      bool RebuildFlagPending;
+      bool RebuildStatusPending;
 
       dma_addr_t	FirstCommandMailboxDMA;
       DAC960_V1_CommandMailbox_T *FirstCommandMailbox;
@@ -2432,17 +2425,17 @@ typedef struct DAC960_Controller
       dma_addr_t NewInquiryUnitSerialNumberDMA;
 
       int DeviceResetCount[DAC960_V1_MaxChannels][DAC960_V1_MaxTargets];
-      boolean DirectCommandActive[DAC960_V1_MaxChannels][DAC960_V1_MaxTargets];
+      bool DirectCommandActive[DAC960_V1_MaxChannels][DAC960_V1_MaxTargets];
     } V1;
     struct {
       unsigned int StatusChangeCounter;
       unsigned int NextEventSequenceNumber;
       unsigned int PhysicalDeviceIndex;
-      boolean NeedLogicalDeviceInformation;
-      boolean NeedPhysicalDeviceInformation;
-      boolean NeedDeviceSerialNumberInformation;
-      boolean StartLogicalDeviceInformationScan;
-      boolean StartPhysicalDeviceInformationScan;
+      bool NeedLogicalDeviceInformation;
+      bool NeedPhysicalDeviceInformation;
+      bool NeedDeviceSerialNumberInformation;
+      bool StartLogicalDeviceInformationScan;
+      bool StartPhysicalDeviceInformationScan;
       struct pci_pool *RequestSensePool;
 
       dma_addr_t	FirstCommandMailboxDMA;
@@ -2487,7 +2480,7 @@ typedef struct DAC960_Controller
 
       DAC960_V2_PhysicalDevice_T
 	LogicalDriveToVirtualDevice[DAC960_MaxLogicalDrives];
-      boolean LogicalDriveFoundDuringScan[DAC960_MaxLogicalDrives];
+      bool LogicalDriveFoundDuringScan[DAC960_MaxLogicalDrives];
     } V2;
   } FW;
   unsigned char ProgressBuffer[DAC960_ProgressBufferSize];
@@ -2572,17 +2565,17 @@ typedef union DAC960_GEM_InboundDoorBellRegister
   unsigned int All;
   struct {
     unsigned int :24;
-    boolean HardwareMailboxNewCommand:1;
-    boolean AcknowledgeHardwareMailboxStatus:1;
-    boolean GenerateInterrupt:1;
-    boolean ControllerReset:1;
-    boolean MemoryMailboxNewCommand:1;
+    bool HardwareMailboxNewCommand:1;
+    bool AcknowledgeHardwareMailboxStatus:1;
+    bool GenerateInterrupt:1;
+    bool ControllerReset:1;
+    bool MemoryMailboxNewCommand:1;
     unsigned int :3;
   } Write;
   struct {
     unsigned int :24;
-    boolean HardwareMailboxFull:1;
-    boolean InitializationInProgress:1;
+    bool HardwareMailboxFull:1;
+    bool InitializationInProgress:1;
     unsigned int :6;
   } Read;
 }
@@ -2596,14 +2589,14 @@ typedef union DAC960_GEM_OutboundDoorBellRegister
   unsigned int All;
   struct {
     unsigned int :24;
-    boolean AcknowledgeHardwareMailboxInterrupt:1;
-    boolean AcknowledgeMemoryMailboxInterrupt:1;
+    bool AcknowledgeHardwareMailboxInterrupt:1;
+    bool AcknowledgeMemoryMailboxInterrupt:1;
     unsigned int :6;
   } Write;
   struct {
     unsigned int :24;
-    boolean HardwareMailboxStatusAvailable:1;
-    boolean MemoryMailboxStatusAvailable:1;
+    bool HardwareMailboxStatusAvailable:1;
+    bool MemoryMailboxStatusAvailable:1;
     unsigned int :6;
   } Read;
 }
@@ -2635,7 +2628,7 @@ typedef union DAC960_GEM_ErrorStatusRegister
   struct {
     unsigned int :24;
     unsigned int :5;
-    boolean ErrorStatusPending:1;
+    bool ErrorStatusPending:1;
     unsigned int :2;
   } Bits;
 }
@@ -2697,7 +2690,7 @@ void DAC960_GEM_MemoryMailboxNewCommand(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_GEM_HardwareMailboxFullP(void __iomem *ControllerBaseAddress)
+bool DAC960_GEM_HardwareMailboxFullP(void __iomem *ControllerBaseAddress)
 {
   DAC960_GEM_InboundDoorBellRegister_T InboundDoorBellRegister;
   InboundDoorBellRegister.All =
@@ -2707,7 +2700,7 @@ boolean DAC960_GEM_HardwareMailboxFullP(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_GEM_InitializationInProgressP(void __iomem *ControllerBaseAddress)
+bool DAC960_GEM_InitializationInProgressP(void __iomem *ControllerBaseAddress)
 {
   DAC960_GEM_InboundDoorBellRegister_T InboundDoorBellRegister;
   InboundDoorBellRegister.All =
@@ -2748,7 +2741,7 @@ void DAC960_GEM_AcknowledgeInterrupt(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_GEM_HardwareMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
+bool DAC960_GEM_HardwareMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
 {
   DAC960_GEM_OutboundDoorBellRegister_T OutboundDoorBellRegister;
   OutboundDoorBellRegister.All =
@@ -2758,7 +2751,7 @@ boolean DAC960_GEM_HardwareMailboxStatusAvailableP(void __iomem *ControllerBaseA
 }
 
 static inline
-boolean DAC960_GEM_MemoryMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
+bool DAC960_GEM_MemoryMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
 {
   DAC960_GEM_OutboundDoorBellRegister_T OutboundDoorBellRegister;
   OutboundDoorBellRegister.All =
@@ -2790,7 +2783,7 @@ void DAC960_GEM_DisableInterrupts(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_GEM_InterruptsEnabledP(void __iomem *ControllerBaseAddress)
+bool DAC960_GEM_InterruptsEnabledP(void __iomem *ControllerBaseAddress)
 {
   DAC960_GEM_InterruptMaskRegister_T InterruptMaskRegister;
   InterruptMaskRegister.All =
@@ -2834,7 +2827,7 @@ DAC960_GEM_ReadCommandStatus(void __iomem *ControllerBaseAddress)
   return readw(ControllerBaseAddress + DAC960_GEM_CommandStatusOffset + 2);
 }
 
-static inline boolean
+static inline bool
 DAC960_GEM_ReadErrorStatus(void __iomem *ControllerBaseAddress,
 			  unsigned char *ErrorStatus,
 			  unsigned char *Parameter0,
@@ -2882,16 +2875,16 @@ typedef union DAC960_BA_InboundDoorBellRegister
 {
   unsigned char All;
   struct {
-    boolean HardwareMailboxNewCommand:1;		/* Bit 0 */
-    boolean AcknowledgeHardwareMailboxStatus:1;		/* Bit 1 */
-    boolean GenerateInterrupt:1;			/* Bit 2 */
-    boolean ControllerReset:1;				/* Bit 3 */
-    boolean MemoryMailboxNewCommand:1;			/* Bit 4 */
+    bool HardwareMailboxNewCommand:1;			/* Bit 0 */
+    bool AcknowledgeHardwareMailboxStatus:1;		/* Bit 1 */
+    bool GenerateInterrupt:1;				/* Bit 2 */
+    bool ControllerReset:1;				/* Bit 3 */
+    bool MemoryMailboxNewCommand:1;			/* Bit 4 */
     unsigned char :3;					/* Bits 5-7 */
   } Write;
   struct {
-    boolean HardwareMailboxEmpty:1;			/* Bit 0 */
-    boolean InitializationNotInProgress:1;		/* Bit 1 */
+    bool HardwareMailboxEmpty:1;			/* Bit 0 */
+    bool InitializationNotInProgress:1;			/* Bit 1 */
     unsigned char :6;					/* Bits 2-7 */
   } Read;
 }
@@ -2906,13 +2899,13 @@ typedef union DAC960_BA_OutboundDoorBellRegister
 {
   unsigned char All;
   struct {
-    boolean AcknowledgeHardwareMailboxInterrupt:1;	/* Bit 0 */
-    boolean AcknowledgeMemoryMailboxInterrupt:1;	/* Bit 1 */
+    bool AcknowledgeHardwareMailboxInterrupt:1;		/* Bit 0 */
+    bool AcknowledgeMemoryMailboxInterrupt:1;		/* Bit 1 */
     unsigned char :6;					/* Bits 2-7 */
   } Write;
   struct {
-    boolean HardwareMailboxStatusAvailable:1;		/* Bit 0 */
-    boolean MemoryMailboxStatusAvailable:1;		/* Bit 1 */
+    bool HardwareMailboxStatusAvailable:1;		/* Bit 0 */
+    bool MemoryMailboxStatusAvailable:1;		/* Bit 1 */
     unsigned char :6;					/* Bits 2-7 */
   } Read;
 }
@@ -2928,8 +2921,8 @@ typedef union DAC960_BA_InterruptMaskRegister
   unsigned char All;
   struct {
     unsigned int :2;					/* Bits 0-1 */
-    boolean DisableInterrupts:1;			/* Bit 2 */
-    boolean DisableInterruptsI2O:1;			/* Bit 3 */
+    bool DisableInterrupts:1;				/* Bit 2 */
+    bool DisableInterruptsI2O:1;			/* Bit 3 */
     unsigned int :4;					/* Bits 4-7 */
   } Bits;
 }
@@ -2945,7 +2938,7 @@ typedef union DAC960_BA_ErrorStatusRegister
   unsigned char All;
   struct {
     unsigned int :2;					/* Bits 0-1 */
-    boolean ErrorStatusPending:1;			/* Bit 2 */
+    bool ErrorStatusPending:1;				/* Bit 2 */
     unsigned int :5;					/* Bits 3-7 */
   } Bits;
 }
@@ -3008,7 +3001,7 @@ void DAC960_BA_MemoryMailboxNewCommand(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_BA_HardwareMailboxFullP(void __iomem *ControllerBaseAddress)
+bool DAC960_BA_HardwareMailboxFullP(void __iomem *ControllerBaseAddress)
 {
   DAC960_BA_InboundDoorBellRegister_T InboundDoorBellRegister;
   InboundDoorBellRegister.All =
@@ -3017,7 +3010,7 @@ boolean DAC960_BA_HardwareMailboxFullP(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_BA_InitializationInProgressP(void __iomem *ControllerBaseAddress)
+bool DAC960_BA_InitializationInProgressP(void __iomem *ControllerBaseAddress)
 {
   DAC960_BA_InboundDoorBellRegister_T InboundDoorBellRegister;
   InboundDoorBellRegister.All =
@@ -3057,7 +3050,7 @@ void DAC960_BA_AcknowledgeInterrupt(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_BA_HardwareMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
+bool DAC960_BA_HardwareMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
 {
   DAC960_BA_OutboundDoorBellRegister_T OutboundDoorBellRegister;
   OutboundDoorBellRegister.All =
@@ -3066,7 +3059,7 @@ boolean DAC960_BA_HardwareMailboxStatusAvailableP(void __iomem *ControllerBaseAd
 }
 
 static inline
-boolean DAC960_BA_MemoryMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
+bool DAC960_BA_MemoryMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
 {
   DAC960_BA_OutboundDoorBellRegister_T OutboundDoorBellRegister;
   OutboundDoorBellRegister.All =
@@ -3097,7 +3090,7 @@ void DAC960_BA_DisableInterrupts(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_BA_InterruptsEnabledP(void __iomem *ControllerBaseAddress)
+bool DAC960_BA_InterruptsEnabledP(void __iomem *ControllerBaseAddress)
 {
   DAC960_BA_InterruptMaskRegister_T InterruptMaskRegister;
   InterruptMaskRegister.All =
@@ -3140,7 +3133,7 @@ DAC960_BA_ReadCommandStatus(void __iomem *ControllerBaseAddress)
   return readw(ControllerBaseAddress + DAC960_BA_CommandStatusOffset + 2);
 }
 
-static inline boolean
+static inline bool
 DAC960_BA_ReadErrorStatus(void __iomem *ControllerBaseAddress,
 			  unsigned char *ErrorStatus,
 			  unsigned char *Parameter0,
@@ -3188,16 +3181,16 @@ typedef union DAC960_LP_InboundDoorBellRegister
 {
   unsigned char All;
   struct {
-    boolean HardwareMailboxNewCommand:1;		/* Bit 0 */
-    boolean AcknowledgeHardwareMailboxStatus:1;		/* Bit 1 */
-    boolean GenerateInterrupt:1;			/* Bit 2 */
-    boolean ControllerReset:1;				/* Bit 3 */
-    boolean MemoryMailboxNewCommand:1;			/* Bit 4 */
+    bool HardwareMailboxNewCommand:1;			/* Bit 0 */
+    bool AcknowledgeHardwareMailboxStatus:1;		/* Bit 1 */
+    bool GenerateInterrupt:1;				/* Bit 2 */
+    bool ControllerReset:1;				/* Bit 3 */
+    bool MemoryMailboxNewCommand:1;			/* Bit 4 */
     unsigned char :3;					/* Bits 5-7 */
   } Write;
   struct {
-    boolean HardwareMailboxFull:1;			/* Bit 0 */
-    boolean InitializationInProgress:1;			/* Bit 1 */
+    bool HardwareMailboxFull:1;				/* Bit 0 */
+    bool InitializationInProgress:1;			/* Bit 1 */
     unsigned char :6;					/* Bits 2-7 */
   } Read;
 }
@@ -3212,13 +3205,13 @@ typedef union DAC960_LP_OutboundDoorBellRegister
 {
   unsigned char All;
   struct {
-    boolean AcknowledgeHardwareMailboxInterrupt:1;	/* Bit 0 */
-    boolean AcknowledgeMemoryMailboxInterrupt:1;	/* Bit 1 */
+    bool AcknowledgeHardwareMailboxInterrupt:1;		/* Bit 0 */
+    bool AcknowledgeMemoryMailboxInterrupt:1;		/* Bit 1 */
     unsigned char :6;					/* Bits 2-7 */
   } Write;
   struct {
-    boolean HardwareMailboxStatusAvailable:1;		/* Bit 0 */
-    boolean MemoryMailboxStatusAvailable:1;		/* Bit 1 */
+    bool HardwareMailboxStatusAvailable:1;		/* Bit 0 */
+    bool MemoryMailboxStatusAvailable:1;		/* Bit 1 */
     unsigned char :6;					/* Bits 2-7 */
   } Read;
 }
@@ -3234,7 +3227,7 @@ typedef union DAC960_LP_InterruptMaskRegister
   unsigned char All;
   struct {
     unsigned int :2;					/* Bits 0-1 */
-    boolean DisableInterrupts:1;			/* Bit 2 */
+    bool DisableInterrupts:1;				/* Bit 2 */
     unsigned int :5;					/* Bits 3-7 */
   } Bits;
 }
@@ -3250,7 +3243,7 @@ typedef union DAC960_LP_ErrorStatusRegister
   unsigned char All;
   struct {
     unsigned int :2;					/* Bits 0-1 */
-    boolean ErrorStatusPending:1;			/* Bit 2 */
+    bool ErrorStatusPending:1;				/* Bit 2 */
     unsigned int :5;					/* Bits 3-7 */
   } Bits;
 }
@@ -3313,7 +3306,7 @@ void DAC960_LP_MemoryMailboxNewCommand(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_LP_HardwareMailboxFullP(void __iomem *ControllerBaseAddress)
+bool DAC960_LP_HardwareMailboxFullP(void __iomem *ControllerBaseAddress)
 {
   DAC960_LP_InboundDoorBellRegister_T InboundDoorBellRegister;
   InboundDoorBellRegister.All =
@@ -3322,7 +3315,7 @@ boolean DAC960_LP_HardwareMailboxFullP(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_LP_InitializationInProgressP(void __iomem *ControllerBaseAddress)
+bool DAC960_LP_InitializationInProgressP(void __iomem *ControllerBaseAddress)
 {
   DAC960_LP_InboundDoorBellRegister_T InboundDoorBellRegister;
   InboundDoorBellRegister.All =
@@ -3362,7 +3355,7 @@ void DAC960_LP_AcknowledgeInterrupt(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_LP_HardwareMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
+bool DAC960_LP_HardwareMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
 {
   DAC960_LP_OutboundDoorBellRegister_T OutboundDoorBellRegister;
   OutboundDoorBellRegister.All =
@@ -3371,7 +3364,7 @@ boolean DAC960_LP_HardwareMailboxStatusAvailableP(void __iomem *ControllerBaseAd
 }
 
 static inline
-boolean DAC960_LP_MemoryMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
+bool DAC960_LP_MemoryMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
 {
   DAC960_LP_OutboundDoorBellRegister_T OutboundDoorBellRegister;
   OutboundDoorBellRegister.All =
@@ -3400,7 +3393,7 @@ void DAC960_LP_DisableInterrupts(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_LP_InterruptsEnabledP(void __iomem *ControllerBaseAddress)
+bool DAC960_LP_InterruptsEnabledP(void __iomem *ControllerBaseAddress)
 {
   DAC960_LP_InterruptMaskRegister_T InterruptMaskRegister;
   InterruptMaskRegister.All =
@@ -3442,7 +3435,7 @@ DAC960_LP_ReadCommandStatus(void __iomem *ControllerBaseAddress)
   return readw(ControllerBaseAddress + DAC960_LP_CommandStatusOffset + 2);
 }
 
-static inline boolean
+static inline bool
 DAC960_LP_ReadErrorStatus(void __iomem *ControllerBaseAddress,
 			  unsigned char *ErrorStatus,
 			  unsigned char *Parameter0,
@@ -3502,16 +3495,16 @@ typedef union DAC960_LA_InboundDoorBellRegister
 {
   unsigned char All;
   struct {
-    boolean HardwareMailboxNewCommand:1;		/* Bit 0 */
-    boolean AcknowledgeHardwareMailboxStatus:1;		/* Bit 1 */
-    boolean GenerateInterrupt:1;			/* Bit 2 */
-    boolean ControllerReset:1;				/* Bit 3 */
-    boolean MemoryMailboxNewCommand:1;			/* Bit 4 */
+    bool HardwareMailboxNewCommand:1;			/* Bit 0 */
+    bool AcknowledgeHardwareMailboxStatus:1;		/* Bit 1 */
+    bool GenerateInterrupt:1;				/* Bit 2 */
+    bool ControllerReset:1;				/* Bit 3 */
+    bool MemoryMailboxNewCommand:1;			/* Bit 4 */
     unsigned char :3;					/* Bits 5-7 */
   } Write;
   struct {
-    boolean HardwareMailboxEmpty:1;			/* Bit 0 */
-    boolean InitializationNotInProgress:1;		/* Bit 1 */
+    bool HardwareMailboxEmpty:1;			/* Bit 0 */
+    bool InitializationNotInProgress:1;		/* Bit 1 */
     unsigned char :6;					/* Bits 2-7 */
   } Read;
 }
@@ -3526,13 +3519,13 @@ typedef union DAC960_LA_OutboundDoorBellRegister
 {
   unsigned char All;
   struct {
-    boolean AcknowledgeHardwareMailboxInterrupt:1;	/* Bit 0 */
-    boolean AcknowledgeMemoryMailboxInterrupt:1;	/* Bit 1 */
+    bool AcknowledgeHardwareMailboxInterrupt:1;		/* Bit 0 */
+    bool AcknowledgeMemoryMailboxInterrupt:1;		/* Bit 1 */
     unsigned char :6;					/* Bits 2-7 */
   } Write;
   struct {
-    boolean HardwareMailboxStatusAvailable:1;		/* Bit 0 */
-    boolean MemoryMailboxStatusAvailable:1;		/* Bit 1 */
+    bool HardwareMailboxStatusAvailable:1;		/* Bit 0 */
+    bool MemoryMailboxStatusAvailable:1;		/* Bit 1 */
     unsigned char :6;					/* Bits 2-7 */
   } Read;
 }
@@ -3548,7 +3541,7 @@ typedef union DAC960_LA_InterruptMaskRegister
   unsigned char All;
   struct {
     unsigned char :2;					/* Bits 0-1 */
-    boolean DisableInterrupts:1;			/* Bit 2 */
+    bool DisableInterrupts:1;				/* Bit 2 */
     unsigned char :5;					/* Bits 3-7 */
   } Bits;
 }
@@ -3564,7 +3557,7 @@ typedef union DAC960_LA_ErrorStatusRegister
   unsigned char All;
   struct {
     unsigned int :2;					/* Bits 0-1 */
-    boolean ErrorStatusPending:1;			/* Bit 2 */
+    bool ErrorStatusPending:1;				/* Bit 2 */
     unsigned int :5;					/* Bits 3-7 */
   } Bits;
 }
@@ -3627,7 +3620,7 @@ void DAC960_LA_MemoryMailboxNewCommand(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_LA_HardwareMailboxFullP(void __iomem *ControllerBaseAddress)
+bool DAC960_LA_HardwareMailboxFullP(void __iomem *ControllerBaseAddress)
 {
   DAC960_LA_InboundDoorBellRegister_T InboundDoorBellRegister;
   InboundDoorBellRegister.All =
@@ -3636,7 +3629,7 @@ boolean DAC960_LA_HardwareMailboxFullP(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_LA_InitializationInProgressP(void __iomem *ControllerBaseAddress)
+bool DAC960_LA_InitializationInProgressP(void __iomem *ControllerBaseAddress)
 {
   DAC960_LA_InboundDoorBellRegister_T InboundDoorBellRegister;
   InboundDoorBellRegister.All =
@@ -3676,7 +3669,7 @@ void DAC960_LA_AcknowledgeInterrupt(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_LA_HardwareMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
+bool DAC960_LA_HardwareMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
 {
   DAC960_LA_OutboundDoorBellRegister_T OutboundDoorBellRegister;
   OutboundDoorBellRegister.All =
@@ -3685,7 +3678,7 @@ boolean DAC960_LA_HardwareMailboxStatusAvailableP(void __iomem *ControllerBaseAd
 }
 
 static inline
-boolean DAC960_LA_MemoryMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
+bool DAC960_LA_MemoryMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
 {
   DAC960_LA_OutboundDoorBellRegister_T OutboundDoorBellRegister;
   OutboundDoorBellRegister.All =
@@ -3714,7 +3707,7 @@ void DAC960_LA_DisableInterrupts(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_LA_InterruptsEnabledP(void __iomem *ControllerBaseAddress)
+bool DAC960_LA_InterruptsEnabledP(void __iomem *ControllerBaseAddress)
 {
   DAC960_LA_InterruptMaskRegister_T InterruptMaskRegister;
   InterruptMaskRegister.All =
@@ -3763,7 +3756,7 @@ DAC960_LA_ReadStatusRegister(void __iomem *ControllerBaseAddress)
   return readw(ControllerBaseAddress + DAC960_LA_StatusRegisterOffset);
 }
 
-static inline boolean
+static inline bool
 DAC960_LA_ReadErrorStatus(void __iomem *ControllerBaseAddress,
 			  unsigned char *ErrorStatus,
 			  unsigned char *Parameter0,
@@ -3822,16 +3815,16 @@ typedef union DAC960_PG_InboundDoorBellRegister
 {
   unsigned int All;
   struct {
-    boolean HardwareMailboxNewCommand:1;		/* Bit 0 */
-    boolean AcknowledgeHardwareMailboxStatus:1;		/* Bit 1 */
-    boolean GenerateInterrupt:1;			/* Bit 2 */
-    boolean ControllerReset:1;				/* Bit 3 */
-    boolean MemoryMailboxNewCommand:1;			/* Bit 4 */
+    bool HardwareMailboxNewCommand:1;			/* Bit 0 */
+    bool AcknowledgeHardwareMailboxStatus:1;		/* Bit 1 */
+    bool GenerateInterrupt:1;				/* Bit 2 */
+    bool ControllerReset:1;				/* Bit 3 */
+    bool MemoryMailboxNewCommand:1;			/* Bit 4 */
     unsigned int :27;					/* Bits 5-31 */
   } Write;
   struct {
-    boolean HardwareMailboxFull:1;			/* Bit 0 */
-    boolean InitializationInProgress:1;			/* Bit 1 */
+    bool HardwareMailboxFull:1;				/* Bit 0 */
+    bool InitializationInProgress:1;			/* Bit 1 */
     unsigned int :30;					/* Bits 2-31 */
   } Read;
 }
@@ -3846,13 +3839,13 @@ typedef union DAC960_PG_OutboundDoorBellRegister
 {
   unsigned int All;
   struct {
-    boolean AcknowledgeHardwareMailboxInterrupt:1;	/* Bit 0 */
-    boolean AcknowledgeMemoryMailboxInterrupt:1;	/* Bit 1 */
+    bool AcknowledgeHardwareMailboxInterrupt:1;		/* Bit 0 */
+    bool AcknowledgeMemoryMailboxInterrupt:1;		/* Bit 1 */
     unsigned int :30;					/* Bits 2-31 */
   } Write;
   struct {
-    boolean HardwareMailboxStatusAvailable:1;		/* Bit 0 */
-    boolean MemoryMailboxStatusAvailable:1;		/* Bit 1 */
+    bool HardwareMailboxStatusAvailable:1;		/* Bit 0 */
+    bool MemoryMailboxStatusAvailable:1;		/* Bit 1 */
     unsigned int :30;					/* Bits 2-31 */
   } Read;
 }
@@ -3868,7 +3861,7 @@ typedef union DAC960_PG_InterruptMaskRegister
   unsigned int All;
   struct {
     unsigned int MessageUnitInterruptMask1:2;		/* Bits 0-1 */
-    boolean DisableInterrupts:1;			/* Bit 2 */
+    bool DisableInterrupts:1;				/* Bit 2 */
     unsigned int MessageUnitInterruptMask2:5;		/* Bits 3-7 */
     unsigned int Reserved0:24;				/* Bits 8-31 */
   } Bits;
@@ -3885,7 +3878,7 @@ typedef union DAC960_PG_ErrorStatusRegister
   unsigned char All;
   struct {
     unsigned int :2;					/* Bits 0-1 */
-    boolean ErrorStatusPending:1;			/* Bit 2 */
+    bool ErrorStatusPending:1;				/* Bit 2 */
     unsigned int :5;					/* Bits 3-7 */
   } Bits;
 }
@@ -3948,7 +3941,7 @@ void DAC960_PG_MemoryMailboxNewCommand(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_PG_HardwareMailboxFullP(void __iomem *ControllerBaseAddress)
+bool DAC960_PG_HardwareMailboxFullP(void __iomem *ControllerBaseAddress)
 {
   DAC960_PG_InboundDoorBellRegister_T InboundDoorBellRegister;
   InboundDoorBellRegister.All =
@@ -3957,7 +3950,7 @@ boolean DAC960_PG_HardwareMailboxFullP(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_PG_InitializationInProgressP(void __iomem *ControllerBaseAddress)
+bool DAC960_PG_InitializationInProgressP(void __iomem *ControllerBaseAddress)
 {
   DAC960_PG_InboundDoorBellRegister_T InboundDoorBellRegister;
   InboundDoorBellRegister.All =
@@ -3997,7 +3990,7 @@ void DAC960_PG_AcknowledgeInterrupt(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_PG_HardwareMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
+bool DAC960_PG_HardwareMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
 {
   DAC960_PG_OutboundDoorBellRegister_T OutboundDoorBellRegister;
   OutboundDoorBellRegister.All =
@@ -4006,7 +3999,7 @@ boolean DAC960_PG_HardwareMailboxStatusAvailableP(void __iomem *ControllerBaseAd
 }
 
 static inline
-boolean DAC960_PG_MemoryMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
+bool DAC960_PG_MemoryMailboxStatusAvailableP(void __iomem *ControllerBaseAddress)
 {
   DAC960_PG_OutboundDoorBellRegister_T OutboundDoorBellRegister;
   OutboundDoorBellRegister.All =
@@ -4039,7 +4032,7 @@ void DAC960_PG_DisableInterrupts(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_PG_InterruptsEnabledP(void __iomem *ControllerBaseAddress)
+bool DAC960_PG_InterruptsEnabledP(void __iomem *ControllerBaseAddress)
 {
   DAC960_PG_InterruptMaskRegister_T InterruptMaskRegister;
   InterruptMaskRegister.All =
@@ -4088,7 +4081,7 @@ DAC960_PG_ReadStatusRegister(void __iomem *ControllerBaseAddress)
   return readw(ControllerBaseAddress + DAC960_PG_StatusRegisterOffset);
 }
 
-static inline boolean
+static inline bool
 DAC960_PG_ReadErrorStatus(void __iomem *ControllerBaseAddress,
 			  unsigned char *ErrorStatus,
 			  unsigned char *Parameter0,
@@ -4147,15 +4140,15 @@ typedef union DAC960_PD_InboundDoorBellRegister
 {
   unsigned char All;
   struct {
-    boolean NewCommand:1;				/* Bit 0 */
-    boolean AcknowledgeStatus:1;			/* Bit 1 */
-    boolean GenerateInterrupt:1;			/* Bit 2 */
-    boolean ControllerReset:1;				/* Bit 3 */
+    bool NewCommand:1;					/* Bit 0 */
+    bool AcknowledgeStatus:1;				/* Bit 1 */
+    bool GenerateInterrupt:1;				/* Bit 2 */
+    bool ControllerReset:1;				/* Bit 3 */
     unsigned char :4;					/* Bits 4-7 */
   } Write;
   struct {
-    boolean MailboxFull:1;				/* Bit 0 */
-    boolean InitializationInProgress:1;			/* Bit 1 */
+    bool MailboxFull:1;					/* Bit 0 */
+    bool InitializationInProgress:1;			/* Bit 1 */
     unsigned char :6;					/* Bits 2-7 */
   } Read;
 }
@@ -4170,11 +4163,11 @@ typedef union DAC960_PD_OutboundDoorBellRegister
 {
   unsigned char All;
   struct {
-    boolean AcknowledgeInterrupt:1;			/* Bit 0 */
+    bool AcknowledgeInterrupt:1;			/* Bit 0 */
     unsigned char :7;					/* Bits 1-7 */
   } Write;
   struct {
-    boolean StatusAvailable:1;				/* Bit 0 */
+    bool StatusAvailable:1;				/* Bit 0 */
     unsigned char :7;					/* Bits 1-7 */
   } Read;
 }
@@ -4189,7 +4182,7 @@ typedef union DAC960_PD_InterruptEnableRegister
 {
   unsigned char All;
   struct {
-    boolean EnableInterrupts:1;				/* Bit 0 */
+    bool EnableInterrupts:1;				/* Bit 0 */
     unsigned char :7;					/* Bits 1-7 */
   } Bits;
 }
@@ -4205,7 +4198,7 @@ typedef union DAC960_PD_ErrorStatusRegister
   unsigned char All;
   struct {
     unsigned int :2;					/* Bits 0-1 */
-    boolean ErrorStatusPending:1;			/* Bit 2 */
+    bool ErrorStatusPending:1;				/* Bit 2 */
     unsigned int :5;					/* Bits 3-7 */
   } Bits;
 }
@@ -4258,7 +4251,7 @@ void DAC960_PD_ControllerReset(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_PD_MailboxFullP(void __iomem *ControllerBaseAddress)
+bool DAC960_PD_MailboxFullP(void __iomem *ControllerBaseAddress)
 {
   DAC960_PD_InboundDoorBellRegister_T InboundDoorBellRegister;
   InboundDoorBellRegister.All =
@@ -4267,7 +4260,7 @@ boolean DAC960_PD_MailboxFullP(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_PD_InitializationInProgressP(void __iomem *ControllerBaseAddress)
+bool DAC960_PD_InitializationInProgressP(void __iomem *ControllerBaseAddress)
 {
   DAC960_PD_InboundDoorBellRegister_T InboundDoorBellRegister;
   InboundDoorBellRegister.All =
@@ -4286,7 +4279,7 @@ void DAC960_PD_AcknowledgeInterrupt(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_PD_StatusAvailableP(void __iomem *ControllerBaseAddress)
+bool DAC960_PD_StatusAvailableP(void __iomem *ControllerBaseAddress)
 {
   DAC960_PD_OutboundDoorBellRegister_T OutboundDoorBellRegister;
   OutboundDoorBellRegister.All =
@@ -4315,7 +4308,7 @@ void DAC960_PD_DisableInterrupts(void __iomem *ControllerBaseAddress)
 }
 
 static inline
-boolean DAC960_PD_InterruptsEnabledP(void __iomem *ControllerBaseAddress)
+bool DAC960_PD_InterruptsEnabledP(void __iomem *ControllerBaseAddress)
 {
   DAC960_PD_InterruptEnableRegister_T InterruptEnableRegister;
   InterruptEnableRegister.All =
@@ -4350,7 +4343,7 @@ DAC960_PD_ReadStatusRegister(void __iomem *ControllerBaseAddress)
   return readw(ControllerBaseAddress + DAC960_PD_StatusRegisterOffset);
 }
 
-static inline boolean
+static inline bool
 DAC960_PD_ReadErrorStatus(void __iomem *ControllerBaseAddress,
 			  unsigned char *ErrorStatus,
 			  unsigned char *Parameter0,


