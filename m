Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317805AbSGPWQq>; Tue, 16 Jul 2002 18:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317991AbSGPWQp>; Tue, 16 Jul 2002 18:16:45 -0400
Received: from hoemail2.lucent.com ([192.11.226.163]:38362 "EHLO
	hoemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id <S317805AbSGPWQo>; Tue, 16 Jul 2002 18:16:44 -0400
From: stoffel@lucent.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15668.39927.923118.516621@gargle.gargle.HOWL>
Date: Tue, 16 Jul 2002 18:19:35 -0400
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Backups done right (was [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
In-Reply-To: <20020716210639.GC30235@merlin.emma.line.org>
References: <20020716193831.GC22053@merlin.emma.line.org>
	<Pine.LNX.4.44.0207161408270.3452-100000@hawkeye.luckynet.adm>
	<20020716210639.GC30235@merlin.emma.line.org>
X-Mailer: VM 6.95 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It's really quite simple in theory to do proper backups.  But you need
to have application support to make it work in most cases.  It would
flow like this:

  1. lock application(s), flush any outstanding transactions.
  2. lock filesystems, flush any outstanding transactions.

  3a. lock mirrored volume, flush any outstanding transactions, break
      mirror.
                --or--
  3b. snapshot filesystem to another volume.

  4. unlock volume

  5. unlock filesystem

  6. unlock application(s).

  7. do backup against quiescent volume/filesystem.

In reality, people didn't lock filesystems (remount R/O) unless they
had too (ClearCase, Oracle, any DBMS, etc are the exceptions), since
the time hit was too much.  The chances of getting a bad backup on
user home directories or mail spools wasn't worth the extra cost to be
sure to get a clean backup.  For the exceptions, that's why god made
backup windows and such.  These days, those windows are miniscule, so
the seven steps outlined above are what needs to happen these days for
a trully reliable backup of important data.

John
   John Stoffel - Senior Unix Systems Administrator - Lucent Technologies
	 stoffel@lucent.com - http://www.lucent.com - 978-399-0479



