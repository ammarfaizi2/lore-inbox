Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbUL1XV4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUL1XV4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 18:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbUL1XV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 18:21:56 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:41500 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261161AbUL1XVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 18:21:33 -0500
Date: Wed, 29 Dec 2004 00:23:06 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Georg Prenner <georg.prenner@aon.at>, linux-kernel@vger.kernel.org
Subject: Re: make errors (make clean, make menuconfig) make -C /usr/src/linux-2.6.10 O=/usr/src/linux-2.6.10 menuconfig
Message-ID: <20041228232306.GA29461@mars.ravnborg.org>
Mail-Followup-To: Georg Prenner <georg.prenner@aon.at>,
	linux-kernel@vger.kernel.org
References: <41D08472.6010404@aon.at> <20041227224833.GA8206@mars.ravnborg.org> <20041227231934.GA9251@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041227231934.GA9251@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2004 at 12:19:34AM +0100, Sam Ravnborg wrote:
> ...
> 
> It is the following code snippet that causes the troubles:
> ---
> outputmakefile:
>         $(Q)if /usr/bin/env test ! $(srctree) -ef $(objtree); then \
>         $(CONFIG_SHELL) $(srctree)/scripts/mkmakefile
> ---

env was behaving different in some setups - and located in other places.
Since I cannot remeber why it is there I the fix was simple - remove it.

	Sam

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/12/28 19:12:15+01:00 sam@mars.ravnborg.org 
#   kbuild: drop use of /usr/bin/env in top-level Makefile
#   
#   The use of env is not needed, and caused the output makefile to be
#   created in some setups where it was not supposed to.
#   Seems to be an issue with GNU sh-utils version of env.
#   
#   One user also reported env to be located in another place (/usr/local/bin/..).
#   This patch fixes bug: http://bugme.osdl.org/show_bug.cgi?id=3953
#   
#   Thanks to "Mark Williams (MWP)" <mwp@internode.on.net> for helping tracking this down.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# Makefile
#   2004/12/28 19:11:36+01:00 sam@mars.ravnborg.org +1 -1
#   Drop usage of /usr/bin/env
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-12-29 00:20:21 +01:00
+++ b/Makefile	2004-12-29 00:20:21 +01:00
@@ -389,7 +389,7 @@
 # using a seperate output directory. This allows convinient use
 # of make in output directory
 outputmakefile:
-	$(Q)if /usr/bin/env test ! $(srctree) -ef $(objtree); then \
+	$(Q)if test ! $(srctree) -ef $(objtree); then \
 	$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile              \
 	    $(srctree) $(objtree) $(VERSION) $(PATCHLEVEL)         \
 	    > $(objtree)/Makefile;                                 \
