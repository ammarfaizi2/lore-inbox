Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264912AbTGGL1o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 07:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264939AbTGGL1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 07:27:44 -0400
Received: from dp.samba.org ([66.70.73.150]:10979 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264912AbTGGL1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 07:27:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16137.23193.530130.847522@nanango.paulus.ozlabs.org>
Date: Mon, 7 Jul 2003 21:33:45 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: benh@kernel.crashing.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
In-Reply-To: <20030706101754.GA23341@wohnheim.fh-wedel.de>
References: <20030703202410.GA32008@wohnheim.fh-wedel.de>
	<20030704174339.GB22152@wohnheim.fh-wedel.de>
	<20030704174558.GC22152@wohnheim.fh-wedel.de>
	<20030704175439.GE22152@wohnheim.fh-wedel.de>
	<16134.2877.577780.35071@cargo.ozlabs.ibm.com>
	<20030705073946.GD32363@wohnheim.fh-wedel.de>
	<16135.57910.936187.611245@cargo.ozlabs.ibm.com>
	<20030706101754.GA23341@wohnheim.fh-wedel.de>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?Q?J=81=F6rn?= Engel writes:

> A core dump is graceful, a do_exit(SIGSEGV),
> as it was in the ppc code is not, and an inifite loop is anything but
> graceful.

It just occurred to me that the simplest and best fix for the specific
problem you mention is for you to set the SA_ONESHOT flag when you
install the SIGSEGV handler.  That way, if you get another
segmentation violation while you are already in the SIGSEGV handler,
it will just dump core straight away.

Paul.
