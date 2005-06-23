Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263110AbVFWITJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263110AbVFWITJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbVFWIOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:14:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2770 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262363AbVFWGtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:49:39 -0400
Date: Wed, 22 Jun 2005 23:51:40 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <greg@kroah.com>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Updated git HOWTO for kernel hackers
In-Reply-To: <20050623062045.GA11638@kroah.com>
Message-ID: <Pine.LNX.4.58.0506222338290.11175@ppc970.osdl.org>
References: <42B9FCAE.1000607@pobox.com> <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org>
 <42BA14B8.2020609@pobox.com> <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org>
 <42BA1B68.9040505@pobox.com> <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org>
 <42BA271F.6080505@pobox.com> <Pine.LNX.4.58.0506222014000.11175@ppc970.osdl.org>
 <42BA45B1.7060207@pobox.com> <Pine.LNX.4.58.0506222225010.11175@ppc970.osdl.org>
 <20050623062045.GA11638@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Jun 2005, Greg KH wrote:
> 
> Hm, that doesn't work right now.

Yeah, my suggested mod sucks.

Try the following slightly modified version instead, with

	git fetch rsync://rsync.kernel.org/pub/scm/linux/kernel/git/chrisw/linux-2.6.12.y.git tag v2.6.12.1

and now it should work.

		Linus

---
diff --git a/git-fetch-script b/git-fetch-script
--- a/git-fetch-script
+++ b/git-fetch-script
@@ -1,7 +1,13 @@
 #!/bin/sh
 #
+destination=FETCH_HEAD
+
 merge_repo=$1
 merge_name=${2:-HEAD}
+if [ "$2" = "tag" ]; then
+	merge_name="refs/tags/$3"
+	destination="$merge_name"
+fi
 
 : ${GIT_DIR=.git}
 : ${GIT_OBJECT_DIRECTORY="${SHA1_FILE_DIRECTORY-"$GIT_DIR/objects"}"}
@@ -35,7 +41,7 @@ download_objects () {
 }
 
 echo "Getting remote $merge_name"
-download_one "$merge_repo/$merge_name" "$GIT_DIR"/FETCH_HEAD || exit 1
+download_one "$merge_repo/$merge_name" "$GIT_DIR/$destination" || exit 1
 
 echo "Getting object database"
-download_objects "$merge_repo" "$(cat "$GIT_DIR"/FETCH_HEAD)" || exit 1
+download_objects "$merge_repo" "$(cat "$GIT_DIR/$destination")" || exit 1
