Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVDQUIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVDQUIn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 16:08:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVDQUGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 16:06:54 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10515 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261460AbVDQUFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 16:05:25 -0400
Date: Sun, 17 Apr 2005 22:05:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/ip2*: cleanups
Message-ID: <20050417200523.GI3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- i2cmd.c: #if 0 the unused function i2cmdUnixFlags
- i2cmd.c: make the needlessly global funciton i2cmdBaudDef static
- ip2main.c: remove dead code that wasn't reachable due to an #ifdef

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/ip2/i2cmd.c |    4 +++-
 drivers/char/ip2/i2cmd.h |   12 ++----------
 drivers/char/ip2main.c   |   10 ----------
 3 files changed, 5 insertions(+), 21 deletions(-)

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
--- linux-2.6.12-rc2-mm3-full/drivers/char/ip2/i2cmd.c.old	2005-04-17 18:04:42.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/char/ip2/i2cmd.c	2005-04-17 19:09:27.000000000 +0200
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

