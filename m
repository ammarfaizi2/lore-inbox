Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVCaGCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVCaGCo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 01:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbVCaGCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 01:02:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:12495 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262013AbVCaGCT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 01:02:19 -0500
Date: Wed, 30 Mar 2005 22:02:01 -0800
From: Greg KH <greg@kroah.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, sean <seandarcy2@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: BK snapshots removed from kernel.org?
Message-ID: <20050331060201.GB25365@kroah.com>
References: <200503271414.33415.nbensa@gmx.net> <20050327210218.GA1236@ip68-4-98-123.oc.oc.cox.net> <200503281226.48146.nbensa@gmx.net> <4248258A.1060604@osdl.org> <d2fr2e$lvo$1@sea.gmane.org> <424B72CC.8030801@osdl.org> <424B79E6.90300@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424B79E6.90300@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 11:17:42PM -0500, Jeff Garzik wrote:
> 
> Should hopefully just be changing get-version.pl ...

Nah, this simple patch to snapshot fixes it.

I've also generated the 2.6.12-rc1-bk3 snapshot and fixed up the
directory on kernel.org so it should now work properly if you apply the
patch.

Sorry about this issue, I never thought that tags in the bk tree would
cause such a mess...

thanks,

greg k-h

--------------


--- snapshot.orig	2005-03-30 21:44:16.869023655 -0800
+++ snapshot	2005-03-30 21:45:30.410153125 -0800
@@ -39,9 +39,12 @@
 #
 # discover most recent kernel version
 #
-tmptagver=`bk changes | grep 'TAG: v' | head -1 | awk '{print $2}'`
-kmicro=`echo $tmptagver | $getver -m`
-kextra=`echo $tmptagver | $getver -e`
+bk get -q Makefile 
+for TAG in SUBLEVEL EXTRAVERSION ; do
+	eval `sed -ne "/^$TAG/s/ //gp" Makefile`
+done
+kmicro="$SUBLEVEL"
+kextra="$EXTRAVERSION"
 kversion="$kmajor.$kminor.$kmicro$kextra"
 snapdir="$snapbase"		# /$kversion
 echo "found kernel version $kversion" >> $log
