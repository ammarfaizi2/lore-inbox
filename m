Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268564AbTGIThg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 15:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268566AbTGIThg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 15:37:36 -0400
Received: from pat.uio.no ([129.240.130.16]:38533 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S268564AbTGIThe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 15:37:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16140.29271.365874.304823@charged.uio.no>
Date: Wed, 9 Jul 2003 21:51:51 +0200
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: ->direct_IO API change in current 2.4 BK
In-Reply-To: <20030709191739.GH15293@gtf.org>
References: <20030709133109.A23587@infradead.org>
	<Pine.LNX.4.55L.0307091506180.27004@freak.distro.conectiva>
	<16140.24595.438954.609504@charged.uio.no>
	<200307092041.42608.m.c.p@wolk-project.de>
	<16140.25619.963866.474510@charged.uio.no>
	<20030709190531.GF15293@gtf.org>
	<16140.26693.72927.451259@charged.uio.no>
	<20030709191739.GH15293@gtf.org>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Jeff Garzik <jgarzik@pobox.com> writes:

     > Having the stable API change, conditional on a define, is
     > really nasty and IMO will create maintenance and support
     > headaches down the line.  I do not recall Linux VFS _ever_
     > having a hook's definition conditional.  We should not start
     > now...

direct_IO() was precisely such a conditional hook definition. It
appeared in 2.4.15, and anybody who does not check for
KERNEL_HAS_O_DIRECT is not backward compatible.

To comment further: There is at least one example I can think of which
was exactly equivalent to the proposed change, namely the redefinition
of the filldir_t type in 2.4.9. It was admittedly not documented using
a define...

Note: We could at the same time replace the name direct_IO() with
direct_IO2() (that has several precedents).  There are currently only
a small number of filesystems that provide O_DIRECT, and converting
them all is (as has been pointed out before) trivial...

The problem with read_inode2() was rather that it overloaded the the
existing iget4() interface...

Cheers,
  Trond


