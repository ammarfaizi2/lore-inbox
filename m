Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVDBXn3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVDBXn3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 18:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVDBXn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 18:43:29 -0500
Received: from mail.autoweb.net ([198.172.237.26]:7305 "EHLO mail")
	by vger.kernel.org with ESMTP id S261352AbVDBXnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 18:43:24 -0500
Date: Sat, 2 Apr 2005 18:43:23 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Automatically append a semi-random version for BK users
Message-ID: <20050402234322.GA21122@mythryan2.michonline.com>
References: <20050309080638.GW7828@mythryan2.michonline.com> <20050314224317.GB31437@mars.ravnborg.org> <20050315014235.GD5318@mythryan2.michonline.com> <20050315015521.GE5318@mythryan2.michonline.com> <20050318062341.GH5318@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318062341.GH5318@mythryan2.michonline.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam, my patch to automatically include a random value based upon the
BitKeeper or CVS version in the kernel version had one, rather minor,
bug related to building in seperate object and source trees.

This patch fixes that up.

Signed-Off-By: Ryan Anderson <ryan@michonline.com>

Index: local-quilt/scripts/setlocalversion
===================================================================
--- local-quilt.orig/scripts/setlocalversion	2005-04-02 18:29:21.000000000 -0500
+++ local-quilt/scripts/setlocalversion	2005-04-02 18:29:54.000000000 -0500
@@ -14,6 +14,7 @@ EOT
 }
 
 my ($srctree) = @ARGV;
+chdir($srctree);
 
 my @LOCALVERSIONS = ();
 
@@ -39,7 +40,6 @@ my @LOCALVERSIONS = ();
 # -BK and the above 8 characters to the end of the version.
 
 sub do_bk_checks {
-	chdir($srctree);
 	my $changeset = `bk changes -r+ -k`;
 	chomp $changeset; # strip trailing \n safely
 	my $tag = `bk prs -h -d':TAG:' -r'$changeset'`;
@@ -69,7 +69,6 @@ sub do_bk_checks {
 # On this check, there is no real need for a MD5 hash, so
 # the revision number is used directly.
 sub do_cvs_checks {
-	chdir($srctree);
 	my $status = `LANG=C cvs status -v ChangeSet`;
 	my @lines = split /\n/, $status;
 


-- 

Ryan Anderson
  sometimes Pug Majere
