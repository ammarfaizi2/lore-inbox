Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263365AbREXHUo>; Thu, 24 May 2001 03:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263391AbREXHUf>; Thu, 24 May 2001 03:20:35 -0400
Received: from smtp1.Stanford.EDU ([171.64.14.23]:56546 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263365AbREXHUW>; Thu, 24 May 2001 03:20:22 -0400
Message-Id: <200105240720.f4O7KJ403429@smtp1.Stanford.EDU>
Content-Type: text/plain; charset=US-ASCII
From: Praveen Srinivasan <praveens@stanford.edu>
Organization: Stanford University
To: torvalds@transmeta.com
Subject: [PATCH] DAC960.c - Null ptr fixes
Date: Thu, 24 May 2001 00:21:25 -0700
X-Mailer: KMail [version 1.2.2]
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Using the Stanford checker, we searched for null-pointer bugs in the linux 
kernel code. This patch fixes numerous unchecked pointers in the DAC960 
driver (DAC960.c).

Praveen Srinivasan and Frederick Akalin


--- ../linux/./drivers/block/DAC960.c	Tue Feb 20 21:26:22 2001
+++ ./drivers/block/DAC960.c	Mon May  7 21:56:30 2001
@@ -508,6 +508,9 @@
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
   DAC960_V1_CommandMailbox_T *CommandMailbox = &Command->V1.CommandMailbox;
   DAC960_V1_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+    return 0;
+  }
   DAC960_V1_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->Type3.CommandOpcode = CommandOpcode;
@@ -534,6 +537,9 @@
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
   DAC960_V1_CommandMailbox_T *CommandMailbox = &Command->V1.CommandMailbox;
   DAC960_V1_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+    return 0;
+  }
   DAC960_V1_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->Type3D.CommandOpcode = CommandOpcode;
@@ -561,6 +567,9 @@
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
   DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
   DAC960_V2_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+    return 0;
+  }
   DAC960_V2_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->Common.CommandOpcode = DAC960_V2_IOCTL;
@@ -599,6 +608,9 @@
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
   DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
   DAC960_V2_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+    return 0;
+  }
   DAC960_V2_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->ControllerInfo.CommandOpcode = DAC960_V2_IOCTL;
@@ -641,6 +653,9 @@
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
   DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
   DAC960_V2_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+    return 0;
+  }
   DAC960_V2_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->LogicalDeviceInfo.CommandOpcode = DAC960_V2_IOCTL;
@@ -685,6 +700,9 @@
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
   DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
   DAC960_V2_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+    return 0;
+  }
   DAC960_V2_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->PhysicalDeviceInfo.CommandOpcode = DAC960_V2_IOCTL;
@@ -726,6 +744,9 @@
   DAC960_Command_T *Command = DAC960_AllocateCommand(Controller);
   DAC960_V2_CommandMailbox_T *CommandMailbox = &Command->V2.CommandMailbox;
   DAC960_V2_CommandStatus_T CommandStatus;
+  if(Command == NULL) {
+    return 0;
+  }
   DAC960_V2_ClearCommand(Command);
   Command->CommandType = DAC960_ImmediateCommand;
   CommandMailbox->DeviceOperation.CommandOpcode = DAC960_V2_IOCTL;
@@ -1435,8 +1456,12 @@
 	InquiryUnitSerialNumber;
       memset(InquiryUnitSerialNumber, 0,
 	     sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T));
-      InquiryUnitSerialNumber->PeripheralDeviceType = 0x1F;
+      InquiryUnitSerialNumber->PeripheralDeviceType = 0x1F;	
       Command = DAC960_AllocateCommand(Controller);
+      if(Command == NULL) {
+	return 0;
+      }
+
       CommandMailbox = &Command->V2.CommandMailbox;
       DAC960_V2_ClearCommand(Command);
       Command->CommandType = DAC960_ImmediateCommand;
@@ -6594,6 +6619,10 @@
 	create_proc_read_entry("user_command", S_IWUSR | S_IRUSR,
 			       ControllerProcEntry, DAC960_ProcReadUserCommand,
 			       Controller);
+      if(UserCommandProcEntry == NULL) {
+	return 0;
+      }
+
       UserCommandProcEntry->write_proc = DAC960_ProcWriteUserCommand;
       Controller->ControllerProcEntry = ControllerProcEntry;
     }
