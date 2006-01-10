Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWAJPLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWAJPLp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWAJPLp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:11:45 -0500
Received: from rtr.ca ([64.26.128.89]:48351 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751108AbWAJPLo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:11:44 -0500
Message-ID: <43C3CEAE.4030905@rtr.ca>
Date: Tue, 10 Jan 2006 10:11:42 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, Byron Stanoszek <gandalf@winds.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Address space split configuration
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <20060110144412.GA9295@elte.hu> <20060110150331.GN3389@suse.de>
In-Reply-To: <20060110150331.GN3389@suse.de>
Content-Type: multipart/mixed;
 boundary="------------000806050201040206090308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000806050201040206090308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This (below) is NOT a kernel patch, but anyone running VMware
will need something like it when using the 2G-2G split:

Cheers



--- vmware-config.pl.orig	2006-01-10 10:05:55.000000000 -0500
+++ vmware-config.pl	2006-01-10 10:07:29.000000000 -0500
@@ -2593,7 +2593,9 @@
          my $first;

          $first = lc(substr($fields[0], 0, 1));
-        if ($first =~ /^[4567]$/) {
+        if (lc(substr($fields[0],0,2)) =~ /^78$/) {
+          $first = '78000000';
+        } elsif ($first =~ /^[4567]$/) {
            $first = '40000000';
          } elsif ($first =~ /^[89ab]$/) {
            $first = '80000000';

--------------000806050201040206090308
Content-Type: text/x-patch;
 name="vmware-config.pl.2gig_ram.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vmware-config.pl.2gig_ram.patch"

--- vmware-config.pl.orig	2006-01-10 10:05:55.000000000 -0500
+++ vmware-config.pl	2006-01-10 10:07:29.000000000 -0500
@@ -2593,7 +2593,9 @@
         my $first;
 
         $first = lc(substr($fields[0], 0, 1));
-        if ($first =~ /^[4567]$/) {
+        if (lc(substr($fields[0],0,2)) =~ /^78$/) {
+          $first = '78000000';
+        } elsif ($first =~ /^[4567]$/) {
           $first = '40000000';
         } elsif ($first =~ /^[89ab]$/) {
           $first = '80000000';

--------------000806050201040206090308--
