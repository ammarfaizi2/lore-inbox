Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262563AbSJBTxt>; Wed, 2 Oct 2002 15:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262565AbSJBTxt>; Wed, 2 Oct 2002 15:53:49 -0400
Received: from p028.as-l031.contactel.cz ([212.65.234.220]:4992 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S262563AbSJBTxr>;
	Wed, 2 Oct 2002 15:53:47 -0400
Date: Wed, 2 Oct 2002 21:32:52 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Peter L Jones <peter@drealm.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at slab.c:1292
Message-ID: <20021002193252.GA1883@ppc.vc.cvut.cz>
References: <200210021935.51996@advent.drealm.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210021935.51996@advent.drealm.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 07:35:51PM +0100, Peter L Jones wrote:
> Hi all,
> 
> I asked on #kernelnewbies what I should do with this and was told to check the 
> mailing list archive at http://marc.theaimsgroup.com/ - which I've done.
> 
> The following was produced during boot.  I _looks_ like it was during a 
> modprobe, but I'm not entirely sure what - it could be that binfmt_misc but I 
> couldn't find any docs in the tree for BUG() tracebacks (and I probably 
> wouldn't have understood the source).
> 
> I'm not subscribed to the list: if anyone wants more info, drop me private 
> mail and I'll see what I can do.

Try this. I just sent it to Linus.
						Petr Vandrovec

diff -urdN linux/fs/fat/inode.c linux/fs/fat/inode.c
--- linux/fs/fat/inode.c	2002-10-02 13:20:19.000000000 +0200
+++ linux/fs/fat/inode.c	2002-10-02 19:54:59.000000000 +0200
@@ -228,8 +228,6 @@
 	save = 0;
 	savep = NULL;
 	while ((this_char = strsep(&options,",")) != NULL) {
-		if (!*this_char)
-			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			save = *value;
 			savep = value;
@@ -351,7 +349,7 @@
 			strncpy(cvf_options,value,100);
 		}
 
-		if (this_char != options) *(this_char-1) = ',';
+		if (options) *(options-1) = ',';
 		if (value) *savep = save;
 		if (ret == 0)
 			break;
diff -urdN linux/fs/vfat/namei.c linux/fs/vfat/namei.c
--- linux/fs/vfat/namei.c	2002-10-02 13:20:27.000000000 +0200
+++ linux/fs/vfat/namei.c	2002-10-02 19:54:28.000000000 +0200
@@ -117,8 +117,6 @@
 	savep = NULL;
 	ret = 1;
 	while ((this_char = strsep(&options,",")) != NULL) {
-		if (!*this_char)
-			continue;
 		if ((value = strchr(this_char,'=')) != NULL) {
 			save = *value;
 			savep = value;
@@ -154,8 +152,8 @@
 			else
 				ret = 0;
 		}
-		if (this_char != options)
-			*(this_char-1) = ',';
+		if (options)
+			*(options-1) = ',';
 		if (value) {
 			*savep = save;
 		}
