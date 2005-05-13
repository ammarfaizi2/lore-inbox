Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVEMBIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVEMBIK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 21:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVEMBFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 21:05:18 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43019 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262203AbVEMArl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 20:47:41 -0400
Date: Fri, 13 May 2005 02:47:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/ip2*: cleanups
Message-ID: <20050513004740.GW3603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- i2cmd.c: #if 0 the unused function i2cmdUnixFlags
- i2cmd.c: make the needlessly global funciton i2cmdBaudDef static
- ip2main.c: remove dead code that wasn't reachable due to an #ifdef

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 30 Apr 2005

 drivers/char/ip2/i2cmd.c |    6 ++++--
 drivers/char/ip2/i2cmd.h |   12 ++----------
 drivers/char/ip2main.c   |   10 ----------
 3 files changed, 6 insertions(+), 22 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/char/ip2/i2cmd.h.old	2005-04-17 18:04:22.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/ip2/i2cmd.h	2005-04-17 19:08:54.000000000 +0200
@@ -64,16 +64,6 @@
 						// directly from user-level
 #define VAR 0x10        // This command is of variable length!
 
-//-----------------------------------
-// External declarations for i2cmd.c
-//-----------------------------------
-// Routine to set up parameters for the "define hot-key sequence" command. Since
-// there is more than one parameter to assign, we must use a function rather
-// than a macro (used usually).
-//
-extern cmdSyntaxPtr i2cmdUnixFlags(USHORT iflag,USHORT cflag,USHORT lflag);
-extern cmdSyntaxPtr i2cmdBaudDef(int which, USHORT rate);
-
 // Declarations for the global arrays used to bear the commands and their
 // arguments.
 //
@@ -433,6 +423,7 @@
 #define CMD_HOT_ENAB (cmdSyntaxPtr)(ct45) // Enable Hot-key checking
 #define CMD_HOT_DSAB (cmdSyntaxPtr)(ct46) // Disable Hot-key checking
 
+#if 0
 // COMMAND 47: Send Protocol info via Unix flags:
 // iflag = Unix tty t_iflag
 // cflag = Unix tty t_cflag
@@ -441,6 +432,7 @@
 // within these flags
 //
 #define CMD_UNIX_FLAGS(iflag,cflag,lflag) i2cmdUnixFlags(iflag,cflag,lflag)
+#endif  /*  0  */
 
 #define CMD_DSRFL_ENAB  (cmdSyntaxPtr)(ct48) // Enable  DSR receiver ctrl
 #define CMD_DSRFL_DSAB  (cmdSyntaxPtr)(ct49) // Disable DSR receiver ctrl
--- linux-2.6.12-rc2-mm3-full/drivers/char/ip2main.c.old	2005-04-17 19:09:40.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/ip2main.c	2005-04-17 19:09:53.000000000 +0200
@@ -2691,16 +2691,6 @@
 		pCh->flags	|= ASYNC_CHECK_CD;
 	}
 
-#ifdef XXX
-do_flags_thing:	// This is a test, we don't do the flags thing
-	
-	if ( (cflag & CRTSCTS) ) {
-		cflag |= 014000000000;
-	}
-	i2QueueCommands(PTYPE_BYPASS, pCh, 100, 1, 
-				CMD_UNIX_FLAGS(iflag,cflag,lflag));
-#endif
-		
 service_it:
 	i2DrainOutput( pCh, 100 );		
 }

--- linux-2.6.12-rc3-mm1-full/drivers/char/ip2/i2cmd.c.old	2005-04-30 21:08:41.000000000 +0200
+++ linux-2.6.12-rc3-mm1-full/drivers/char/ip2/i2cmd.c	2005-04-30 21:10:14.000000000 +0200
@@ -97,7 +97,7 @@
 //static UCHAR ct44[]={ 2, BTH,     0x2C,0                   }; // MS PING
 //static UCHAR ct45[]={ 1, BTH,     0x2D                     }; // HOTENAB
 //static UCHAR ct46[]={ 1, BTH,     0x2E                     }; // HOTDSAB
-static UCHAR ct47[] = { 7, BTH,     0x2F,0,0,0,0,0,0         }; // UNIX FLAGS
+//static UCHAR ct47[]={ 7, BTH,     0x2F,0,0,0,0,0,0         }; // UNIX FLAGS
 //static UCHAR ct48[]={ 1, BTH,     0x30                     }; // DSRFLOWENAB
 //static UCHAR ct49[]={ 1, BTH,     0x31                     }; // DSRFLOWDSAB
 //static UCHAR ct50[]={ 1, BTH,     0x32                     }; // DTRFLOWENAB
@@ -162,6 +162,7 @@
 // This routine sets the parameters of command 47 and returns a pointer to the
 // appropriate structure.
 //******************************************************************************
+#if 0
 cmdSyntaxPtr
 i2cmdUnixFlags(unsigned short iflag,unsigned short cflag,unsigned short lflag)
 {
@@ -175,6 +176,7 @@
 	pCM->cmd[6] = (unsigned char) (lflag >> 8);
 	return pCM;
 }
+#endif  /*  0  */
 
 //******************************************************************************
 // Function:   i2cmdBaudDef(which, rate)
@@ -187,7 +189,7 @@
 // This routine sets the parameters of commands 54 or 55 (according to the
 // argument which), and returns a pointer to the appropriate structure.
 //******************************************************************************
-cmdSyntaxPtr
+static cmdSyntaxPtr
 i2cmdBaudDef(int which, unsigned short rate)
 {
 	cmdSyntaxPtr pCM;
