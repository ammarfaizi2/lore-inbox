Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTI3GEP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 02:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263130AbTI3GEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 02:04:15 -0400
Received: from pat.uio.no ([129.240.130.16]:9719 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S263129AbTI3GEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 02:04:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16249.7381.602508.450922@charged.uio.no>
Date: Tue, 30 Sep 2003 02:04:05 -0400
To: Frank Cusack <fcusack@fcusack.com>
Cc: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: effect of nfs blocksize on I/O ?
In-Reply-To: <20030929222345.A3043@google.com>
References: <20030928234236.A16924@google.com>
	<16247.56578.861224.328086@charged.uio.no>
	<20030929005250.A9110@google.com>
	<16247.60679.415937.295532@charged.uio.no>
	<20030929222345.A3043@google.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:

     > Then it sounds like the current wtmult/512 value for f_bsize is
     > a bug.  Until such time as you get f_frsize going, just
     > directly plugging wsize into s_blocksize seems like a win.
     > Doesn't it?

No "until such time" solutions please... Let's do it right the first
time, or not at all!

s_blocksize should remain set to wtmult. It is only f_bsize and
f_frsize that are currently set to the wrong values.

     > ISTM that f_frsize is pretty useless for NFS.  Even if the
     > server gives you this value (as wtmult), what use besides
     > conversion of tbytes/abytes values does it have?

As I told you, the main use is for 'df' and friends. Get it wrong, and
the result will be rounding errors when reporting disk sizes etc. This
is currently the case in 2.4.x where we confuse f_bsize and f_frsize.

Cheers,
  Trond
