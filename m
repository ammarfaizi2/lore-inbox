Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129352AbQLMBsA>; Tue, 12 Dec 2000 20:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129361AbQLMBrv>; Tue, 12 Dec 2000 20:47:51 -0500
Received: from uberbox.mesatop.com ([208.164.122.11]:22288 "EHLO
	uberbox.mesatop.com") by vger.kernel.org with ESMTP
	id <S129352AbQLMBrl>; Tue, 12 Dec 2000 20:47:41 -0500
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: linux-kernel@vger.kernel.org
Subject: Re: Possible patch for reiserfs-3.6.22 against 2.4.0-test12
Date: Tue, 12 Dec 2000 18:18:01 -0700
X-Mailer: KMail [version 1.1.95.2]
Content-Type: text/plain
Cc: atsl@ukc.ac.uk, mason@suse.com
MIME-Version: 1.0
Message-Id: <00121218180100.04636@localhost.localdomain>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Sampson wrote:
>The latest reiserfs patch on ftp.namesys.com causes compilation errors
>against test12 due to the task queue changes. Does this look correct?
[patch snipped]
> 
>It does at least compile with these changes, but I haven't yet tested
>it. Looking at run_task_queue, it would appear that the while() is now
>redundant, but could someone who knows confirm/deny this?

Chris Mason is working on this.  In an earlier exchange on reiserfs-list:

Chris Mason wrote:
>I'll try to hack out a patch while I'm waiting, but the task struct changes
>are the least of our problems.  They've changed ll_rw_block to always set
>the end_io handler to the default one.  Since the journal code relies on
>being able to use its own end_io handler, this isn't good for us.  There is
>a new func we need to use instead, so I'm migrating over.
>
>Thew new stuff should be faster, so I won't complain ;-)

Your patch will probably let journal.c get compiled, but it might be dangerous
to use considering what Chris said.

Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
