Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315893AbSFPE2c>; Sun, 16 Jun 2002 00:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315883AbSFPE2b>; Sun, 16 Jun 2002 00:28:31 -0400
Received: from web14204.mail.yahoo.com ([216.136.172.146]:14389 "HELO
	web14204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315893AbSFPE23>; Sun, 16 Jun 2002 00:28:29 -0400
Message-ID: <20020616042831.19489.qmail@web14204.mail.yahoo.com>
Date: Sat, 15 Jun 2002 21:28:31 -0700 (PDT)
From: Erik McKee <camhanaich99@yahoo.com>
Subject: [ERROR][PATCH] smbfs compilation in 2.5.21
To: linux-kernel@vger.kernel.org, torvalde@transmeta.com,
        kernel-newbies@vger.kernel.org, davej@suse.de
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attatched patch fixes smbfs compilation in 2.5.  The problem was that the
paranoia macro required a format string, and one or more substitution elements.
 4 callers only used the string with no substitution.  This patch defines a
paranoia2 which allows for not substitutions ;)

Compilation tested only, as i can not run latest 2.5 due to raid5 not
compiling, but this has to be ok, since it doesn't change any code paths.

Erik McKee

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.484   -> 1.485  
#	fs/smbfs/smb_debug.h	1.2     -> 1.3    
#	     fs/smbfs/proc.c	1.20    -> 1.21   
#	     fs/smbfs/sock.c	1.7     -> 1.8    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/06/15	root@camhanaich.local	1.485
# sock.c:
#   Same edit as proc.c
# proc.c:
#   This makes use of the PARANOIA2 to allow compilation
# smb_debug.h:
#   Added PARANOIA2 to handle cases where there are no
#   format specifiers in the string
# --------------------------------------------
#
diff -Nru a/fs/smbfs/proc.c b/fs/smbfs/proc.c
--- a/fs/smbfs/proc.c	Sat Jun 15 23:12:04 2002
+++ b/fs/smbfs/proc.c	Sat Jun 15 23:12:05 2002
@@ -872,7 +872,7 @@
 		goto out;
 	}
 	if (smb_valid_packet(s->packet) != 0) {
-		PARANOIA("invalid packet!\n");
+		PARANOIA2("invalid packet!\n");
 		goto out;
 	}
 
diff -Nru a/fs/smbfs/smb_debug.h b/fs/smbfs/smb_debug.h
--- a/fs/smbfs/smb_debug.h	Sat Jun 15 23:12:04 2002
+++ b/fs/smbfs/smb_debug.h	Sat Jun 15 23:12:04 2002
@@ -12,8 +12,10 @@
  */
 #ifdef SMBFS_PARANOIA
 # define PARANOIA(f, a...) printk(KERN_NOTICE "%s: " f, __FUNCTION__, ## a)
+# define PARANOIA2(f) printk(KERN_NOTICE "%s: "f, __FUNCTION__)
 #else
 # define PARANOIA(f, a...) do { ; } while(0)
+# defind PARANOIA2(f) do { ; } while(0)
 #endif
 
 /* lots of debug messages */
diff -Nru a/fs/smbfs/sock.c b/fs/smbfs/sock.c
--- a/fs/smbfs/sock.c	Sat Jun 15 23:12:05 2002
+++ b/fs/smbfs/sock.c	Sat Jun 15 23:12:05 2002
@@ -125,7 +125,7 @@
 
 		result = -EIO;
 		if (job->sk->dead) {
-			PARANOIA("sock dead!\n");
+			PARANOIA2("sock dead!\n");
 			break;
 		}
 
@@ -189,7 +189,7 @@
 	{
 #ifdef SMBFS_PARANOIA
 		if (!smb_valid_socket(file->f_dentry->d_inode))
-			PARANOIA("bad socket!\n");
+			PARANOIA2("bad socket!\n");
 #endif
 		return SOCKET_I(file->f_dentry->d_inode);
 	}
@@ -299,7 +299,7 @@
 		VERBOSE("closing socket %p\n", server_sock(server));
 #ifdef SMBFS_PARANOIA
 		if (server_sock(server)->sk->data_ready == smb_data_ready)
-			PARANOIA("still catching keepalives!\n");
+			PARANOIA2("still catching keepalives!\n");
 #endif
 		server->sock_file = NULL;
 		fput(file);
@@ -585,7 +585,7 @@
 	return result;
 
 out_no_mem:
-	PARANOIA("couldn't allocate data area\n");
+	PARANOIA2("couldn't allocate data area\n");
 	result = -ENOMEM;
 	goto out;
 out_too_long:



__________________________________________________
Do You Yahoo!?
Yahoo! - Official partner of 2002 FIFA World Cup
http://fifaworldcup.yahoo.com
