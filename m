Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUA3SUv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 13:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbUA3SUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 13:20:50 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:29906 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S263228AbUA3SSQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 13:18:16 -0500
Date: Fri, 30 Jan 2004 11:18:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BitKeeper repo for KGDB
Message-ID: <20040130181811.GU6577@stop.crashing.org>
References: <20040127184029.GI32525@stop.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040127184029.GI32525@stop.crashing.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 11:40:29AM -0700, Tom Rini wrote:

> Hello everybody.  Since I've been talking with George off-list about
> trying to merge the various versions of KGDB around, and I just read the
> thread between Andy and Jim about conflicting on KGDB work, I've put up
> a BitKeeper repository[1] to try and coordinate things.

Since then, here's the highlights of what I've done so far:
ChangeSet@1.1510, 2004-01-30 11:14:44-07:00, trini@kernel.crashing.org
  Lots of changes to the serial stub driver.
  In sum, it's got many of the features (but not all) of George
  Anzginer's version (+ fix or two), and fully flushed out and tested
  support for SERIAL_IOMEM.

ChangeSet@1.1509, 2004-01-30 11:10:03-07:00, trini@kernel.crashing.org
  Change *kgdb_serial into kgdb_serial_driver.  We will now have
  only one serial driver.

ChangeSet@1.1508, 2004-01-30 10:44:55-07:00, trini@kernel.crashing.org
  Convert the kgdb ethernet driver over to netpoll.
  Patch from Pavel Machek <pavel@suse.cz>, who warns this probably
  doesn't work.

ChangeSet@1.1505, 2004-01-29 14:30:47-07:00, trini@kernel.crashing.org
  Move all KGDB questions into kernel/Kconfig.kgdb.

ChangeSet@1.1504, 2004-01-27 16:59:06-07:00, trini@kernel.crashing.org
  - PPC32: Add KGDB support for PRePs (part of MULTIPLATFORM).
  - PPC32: Add a choice of baud rate for the gen550 backend.

ChangeSet@1.1503, 2004-01-27 14:44:54-07:00, trini@kernel.crashing.org
  Remove the function pointers from kgdb_ops.
  Most have become kgdb_foo, instead of foo.  The exceptions
  are the gdb/kgdb register fiddling functions.
  kgdb_gdb_regs_to_regs makes my head hurt.

ChangeSet@1.1502, 2004-01-27 11:46:13-07:00, trini@kernel.crashing.org
  Merge by hand to current 2.6 bk.
  --- UNTESTED, x86_64 might be broken ---

ChangeSet@1.1474.149.3, 2004-01-27 11:32:54-07:00, trini@kernel.crashing.org
  - Send a 'T' packet initially, not an 'S' followed by 'p'
  - On PPC32, try to pass in the correct signal back.

I'm mostly happy with the serial changes (and I'll set aside the user
console bits from George's version for now), but comments and criticisms
would be welcome.  And as a reminder the BitKeeper version is
bk://ppc.bkbits.net/linux-2.6-kgdb and there's snapshots (thanks Dave!)
at http://www.codemonkey.org.uk/projects/bitkeeper/kgdb

-- 
Tom Rini
http://gate.crashing.org/~trini/
