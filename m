Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263751AbTJ0Cvm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 21:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTJ0Cvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 21:51:42 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:33993 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263751AbTJ0Cvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 21:51:40 -0500
Date: Mon, 27 Oct 2003 03:51:37 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 <-> 2.6 compatibility
Message-ID: <20031027025137.GA6207@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org> <20031026150544.GJ15838@merlin.emma.line.org> <yw1xvfqcf2nq.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xvfqcf2nq.fsf@kth.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Oct 2003, Måns Rullgård wrote:

> Matthias Andree <matthias.andree@gmx.de> writes:
> 
> > To enlarge the testing base, it would be good if people could just drop
> > a 2.6 kernel, some user-space updates and then dual-boot 2.4 and 2.6
> > hassle free at will without worrying about a dozen 2.4 kernel patches to
> > make it compatible with the new user space.
> 
> I've been doing that for months.

OK, my SuSE 8.2 box is running LVM2 (with some 2.4 kernel still) now,
two minor pitfalls I encountered:

1. make install mandir=/usr/share/man (automake should really be updated
   to know *that*, most systems use that) - I've just scribbled over
   LVM1 to have the boot scripts in place

2. /etc/init.d/boot.lvm remounts root read-only before using vgchange,
   which no longer works. Patch against SuSE 8.2's lvm-1.0.6-34:

--- /etc/init.d/boot.lvm	2003-10-27 03:49:33.000000000 +0100
+++ /etc/init.d/boot.lvm	2003-10-27 03:05:33.000000000 +0100
@@ -89,12 +89,12 @@
 		test $FSCK_RETURN -gt 0 && touch /fsck_corrected_errors
 		echo "Scanning for LVM volume groups..."
 		/sbin/vgscan
-		mount -n -o remount,ro /
 		echo "Activating LVM volume groups..."
 		/sbin/vgchange -a y $LVM_VGS_ACTIVATED_ON_BOOT
 	        if test -s /etc/pvpath.cfg -a -x /sbin/pvpathrestore; then
 		    /sbin/pvpathrestore
 	        fi
+		mount -n -o remount,ro /
 		rc_status -v -r
 	    fi
 	fi
