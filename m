Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVDUXHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVDUXHt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 19:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVDUXHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 19:07:49 -0400
Received: from ore.jhcloos.com ([64.240.156.239]:5899 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id S261660AbVDUXHf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 19:07:35 -0400
To: linux-kernel@vger.kernel.org
Subject: from line script for git commits
From: James Cloos <cloos@jhcloos.com>
X-Hashcash: 1:21:050421:linux-kernel@vger.kernel.org::aOspmEf02n8iu+51:0000000000000000000000000000000001rjD
Date: Thu, 21 Apr 2005 16:47:18 -0400
Message-ID: <m3ekd326y1.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

I've been using a script grabbed from here for some time to alter
the From: line on mail sent to bk-head-commits and bk-24-commits
to show the author's name and email rather than LKML's address.

Below is my script for doing the same with git commit emails.

-JimC


--=-=-=
Content-Type: application/x-perl
Content-Disposition: inline; filename=set-git-from.pl

#!/usr/bin/perl
#
# Set the From: line in an LK git commit email to the author's address
#
# Copyright 2005 James Cloos <cloos@jhcloos.com>
#
# This Perl  is free software; you can redistribute it
# and/or modify it under the same terms as Perl itself.
#

$from = '';
@msg = ();

while(<STDIN>) {
    push @msg, $_;
    next if length($from);
    next unless /^author/;
    s/^author ([^@]+[^ ]+)/$from=$1/e;
}

unless (length($from)) {
    print @msg;
    exit;
}

$done = 0;

foreach $l (@msg) {
    if (($done == 0) && ($l =~ /^From:/)) {
	$l = "From:\t" . $from . "\n";
	$done = 1;
    }
    print $l;
}

--=-=-=--
