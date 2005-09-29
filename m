Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932067AbVI2BCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbVI2BCn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 21:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932069AbVI2BCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 21:02:43 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:17814 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932067AbVI2BCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 21:02:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kXx22yGtwu/W7+cBzqC05l5/YG+7jqyx6qN1RdpJMxW8WbYAFc2yLsMFEef9hxiKYtxGXXk+2fVA4/uzd5CSdPRtA3MCqW8Myem0ZxoH71ITdz12DYZ7ctQA6FNAx1CQ3bh9ZxqCPcwHkIVYsZMKj8tRqb7BS3GtydB5G8MDcFI=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Documentation: getting and installing git
Date: Thu, 29 Sep 2005 03:05:01 +0200
User-Agent: KMail/1.8.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@gmail.com>, Petr Baudis <pasky@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509290305.01625.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

As I promised almost a week ago in the "Hang during rm on ext2 mounted sync (2.6.14-rc2+)"
thread, here's a document describing how to obtain and install git.
The document refers people to the git-bisect.txt document in the git source
tree for doing bisection searches (no reason to duplicate the info, and if
people have git they probably have the source and the document around , or can
easily obtain it).
I believe this document matches what you asked for and what I promised to provide.

Please apply or provide comments telling me what should be changed.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 Documentation/get-and-install-git.txt |  130 ++++++++++++++++++++++++++++++++++
 1 files changed, 130 insertions(+)

--- /dev/null	2005-09-28 20:05:57.000000000 +0200
+++ linux-2.6.14-rc2-git3/Documentation/get-and-install-git.txt	2005-09-29 02:57:59.000000000 +0200
@@ -0,0 +1,130 @@
+	Getting and installing `git` and pulling your first tree
+	--------------------------------------------------------
+	
+		(Writen by Jesper Juhl, September 2005)
+
+
+This document describes how to obtain and install the `git` tool used (among
+other things) to manage the Linux kernel source tree. It also shows you how
+to use git to pull down your first copy of the vanilla Linux kernel source
+(current git head version).
+
+The first order of business is to get a copy of git.
+You can either obtain the source and compile and install that, or you can use a
+binary package for your distribution (if any).
+This document will focus on a source install of the latest git snapshot. Binary
+packages for some distros can be found at 
+	http://www.kernel.org/pub/software/scm/git/
+Those who already have an older version of git can grab a newer version with
+	it clone http://www.kernel.org/pub/scm/git/git.git LOCALDIR
+
+To obtain the latest git source snapshot go to this URL: 
+	http://www.codemonkey.org.uk/projects/git-snapshots/git/
+and download the latest version (at the time of this writing the exact filename
+is git-2005-09-29.tar.gz, but a symlink called git-latest.tar.gz is also
+provided that will always pull the latest git source regardless of its actual
+filename).
+
+So, now that you have downloaded the file git-2005-09-29.tar.gz (replace with
+whatever version you actually downloaded), you need to extract the source
+tarball - do the following :
+
+	$ tar zxf git-2005-09-29.tar.gz
+
+This should leave you with a new directory called "git-snapshot-20050929"
+(again, actual name will differ depending on the version you download).
+Change into the new directory : 
+
+	$ cd git-snapshot-20050929
+
+Now it's time to build the source : 
+
+	$ make
+
+This will build a version of git that will install into your own homedir 
+(~/bin subdir - instructions for building a git that will install globally can
+be found in the INSTALL document, but basically it's just "make prefix=/usr").
+
+Once the compile finishes it's time to install git :
+
+	$ make install
+
+(or, if you build a git for global use, su to root first)
+
+Now git is installed and ready for use. If you build a git for global use
+(prefix=/usr), then it should already be in your PATH. If you build git for
+just your normal user account (by just typing "make" followed by "make install"
+then it may or may not be in your PATH depending on your distribution (not all
+distros add ~/bin to the default PATH). If ~/bin is not in your PATH you should
+add it (or do a global git install).
+Adding ~/bin to your PATH is easy, but slightly distribution (and shell) dependant.
+I'll show you a few  ways to do it with my distro of choice, Slackware, assuming
+you are using the bash shell.
+
+The first way is to add ~/bin to just your users PATH by adding the following
+line to ~/.bash_profile (the personal initialization file, executed for login
+shells) :
+
+	export PATH="~/bin:$PATH"
+
+The second way is adding the same line to ~/.bashrc (the individual
+per-interactive-shell startup file).
+What file you choose depends on whether you want to make this change only for
+login shells.
+
+The third way is to add ~/bin to the systemwide PATH by adding it to the
+existing systemwide PATH set from /etc/profile
+The default system PATH set in /etc/profile on a Slackware system looks like
+this:
+
+	PATH="/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/usr/games"
+
+You want to modify that line from /etc/profile to look something like this :
+
+	PATH="~/bin:/usr/local/bin:/usr/bin:/bin:/usr/X11R6/bin:/usr/games"
+
+Remember to re-login, manually  export PATH="~/bin:$PATH"  or otherwise update
+your current shell environment after making these changes. Do a  echo $PATH  to
+verify that the current effective PATH actually includes ~/bin before
+proceeding.
+
+At this point you should have git installed and available in your PATH.
+
+Now it's time to download your first kernel source tree. To do that you should
+first change into the directory where you want to store the kernel source in a
+subdir. I'll assume you want to keep kernel source in ~/linux-kernel, so do
+this : 
+
+	$ mkdir ~/linux-kernel ; cd ~/linux-kernel
+
+Now let's use git to download the latest git HEAD (the current head of Linus'
+development tree). Execute these commands to do this :
+
+	$ git clone \
+	  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
+	  linux-2.6
+	$ cd linux-2.6
+	$ rsync -a --verbose --stats --progress \
+	  rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/ \
+	  .git/
+
+The kernel tree is very large. This constitutes downloading several hundred
+megabytes of data, so be patient.
+When the download finishes you'll have a brand sparkling new git HEAD linux
+kernel source tree in ~/linux-kernel/linux-2.6
+
+
+Finally, a few links that you may want to visit for more info.
+
+The main git homepage is at :
+	http://git.or.cz/
+The Kernel Hackers' Guide to git can be found at :
+	http://linux.yyz.us/git-howto.html
+There's a git manual at :
+	http://www.kernel.org/pub/software/scm/git/docs/
+A page with links to various descriptions of git use is at :
+	http://www.kernel.org/pub/software/scm/git/docs/howto-index.html
+
+If you want to do a git bisection search to find what patch caused a problem,
+please see the Documentation/git-bisect.txt document in the git source tree.
+You may also want to read and/or use Documentation/git-bisect-script.txt
