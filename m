Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTFKP6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 11:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbTFKP6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 11:58:35 -0400
Received: from ns.suse.de ([213.95.15.193]:4614 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262598AbTFKP6Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 11:58:25 -0400
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling kernel with SuSE 8.2/gcc 3.3
References: <3EE6B7A2.3000606@austin.rr.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: --Hello, POLICE?  I"ve got ABBOTT & COSTELLO here on suspicion of
 HIGHWAY ROBBERY!!
Date: Wed, 11 Jun 2003 18:12:04 +0200
In-Reply-To: <3EE6B7A2.3000606@austin.rr.com> (Steve French's message of
 "Wed, 11 Jun 2003 00:01:22 -0500")
Message-ID: <jeu1awzj8r.fsf@sykes.suse.de>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French <smfrench@austin.rr.com> writes:

|> I also noticed lots of compiler warnings with gcc 3.3, now default in
|> SuSE, and cleaned up most of them for the cifs vfs but there are a few
|> that just
|> look wrong for gcc to spit out warnings on.   For example the following
|> local variable definition and the similar ones in the same file
|> (fs/cifs/inode.c):
|> 
|> 	__u64 uid = 0xFFFFFFFFFFFFFFFF;
|> 
|> generates a warning saying the value is too long for a long on x86 SuSE
|> 8.2 with gcc 3.3 - which makes no sense.  Any value
|> above 0xFFFFFFFFF generates the same warning (intuitively
|> 36 bits should fit in an unsigned 64 bit local variable).

An expression is evaluated independent of the context, ie. the fact that
the left side of the assignment is a 64 bit variable has no significance
at all.  But I agree that the warning should only occur in c89 mode, not
in the default gnu89 mode, where long long is available.  And in fact the
generated code will be correct.

|> Defining the literal with the UL suffix didn't seem to help

Yes, since you need a long long literal.

|> rebelled against the solutions that work for this case ie casting the
|> local variable which is already __u64 to __u64 but that presumably would
|> work for those three, as would a (__u64)cast of -1 which seems equally
|> ugly).

You can just use -1.  The implicit conversion to __u64 will DTRT.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
