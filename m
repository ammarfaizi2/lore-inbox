Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129043AbQKDWQl>; Sat, 4 Nov 2000 17:16:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129114AbQKDWQc>; Sat, 4 Nov 2000 17:16:32 -0500
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:16398 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id <S129043AbQKDWQU>;
	Sat, 4 Nov 2000 17:16:20 -0500
To: linux-kernel@vger.kernel.org
Subject: What protects f_pos?
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 04 Nov 2000 22:16:18 +0000
Message-ID: <y7r8zqzqt71.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since f_pos of struct file is a loff_t, on 32-bit architectures it
needs a lock to make accesses atomic (or some more sophisticated form
of protection).  But looking in 2.4.0-test10, there doesn't seem to be
any such lock.

The llseek op is called with the Big Kernel Lock, but unlike in 2.2,
the read and write ops are called without any locks held, and so
generic_file_{read|write} make unprotected accesses to f_pos (through
their ppos argument).

Is this something for Ted's todo list?

David
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
