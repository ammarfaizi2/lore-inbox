Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbTEHVWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTEHVWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:22:08 -0400
Received: from [212.97.163.22] ([212.97.163.22]:38900 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262120AbTEHVWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:22:03 -0400
Date: Thu, 8 May 2003 23:34:01 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-hfsplus-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] HFS+ driver
Message-ID: <20030508213401.GA3458@werewolf.able.es>
References: <Pine.LNX.4.44.0305071643030.5042-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0305071643030.5042-100000@serv>; from zippel@linux-m68k.org on Wed, May 07, 2003 at 17:06:59 +0200
X-Mailer: Balsa 2.0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.07, Roman Zippel wrote:
> Hi,
> 
> I'm proud to announce a complete new version of the HFS+ fs driver. This 
> work was made possible by Ardis Technologies (www.ardistech.com). It's 
> based on the driver by Brad Boyer (http://sf.net/projects/linux-hfsplus).
> 

How about this ?

--- fs/hfsplus/options.c.orig	2003-05-08 23:28:09.000000000 +0200
+++ fs/hfsplus/options.c	2003-05-08 23:30:28.000000000 +0200
@@ -47,23 +47,6 @@
 }
 #endif
 
-/* My own little ultra-paranoid version of strtok (yes, there is strtok...) */
-static char *my_strtok(char *input, char **next, char delim)
-{
-	char *d;
-
-	if (!input || !*input || !next)
-		return NULL;
-
-	*next = NULL;
-	d = strchr(input, delim);
-	if (d) {
-		*d = '\0';
-		*next = d+1;
-	}
-	return input;
-}
-
 /* convert a "four byte character" to a 32 bit int with error checks */
 static int fill_fourchar(u32 *result, char *input)
 {
@@ -102,14 +85,16 @@
 /* input is the options passed to mount() as a string */
 int parse_options(char *input, struct hfsplus_sb_info *results)
 {
-	char *next, *curropt, *value;
+	char *curropt, *value;
 	int tmp;
 
 	if (!input)
 		return 1;
 
-	for (curropt = my_strtok(input, &next, ','); curropt != NULL;
-	     curropt = my_strtok(next, &next, ',')) {
+	while ((curropt = strsep(&input,",")) != NULL) {
+		if (!*curropt)
+			continue;
+
 		if ((value = strchr(curropt, '=')) != NULL)
 			*value++ = '\0';
 


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc1-jam2 (gcc 3.2.2 (Mandrake Linux 9.2 3.2.2-5mdk))
