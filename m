Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVFBREN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVFBREN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 13:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261207AbVFBREN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 13:04:13 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:20765 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S261206AbVFBREH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 13:04:07 -0400
Message-ID: <429F3C05.2010007@suse.com>
Date: Thu, 02 Jun 2005 13:04:05 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Antonio_Larrosa_Jim=E9nez?= <antlarr@tedial.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SCSI I/O error generating a kernel (parport? reiserfs?) bug (2.4.21-99)
References: <200503311106.52574.antlarr@tedial.com>
In-Reply-To: <200503311106.52574.antlarr@tedial.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Antonio Larrosa Jiménez wrote:
> Hello,
> 
> Last night I saw an I/O error in a RAID device on a SuSE 9.0 system (with the 
> stock 2.4.21-99 kernel, not tainted). I don't know if it's useful for anyone 
> given that the kernel has changed much since then, but I report it just in 
> case the problem is still in there.
> 
> I find strange that the backtrace (below) talks about parport being a SCSI I/O 
> error, so maybe it's not related to the SCSI problem, but since at the end it 
> mentions reiserfs, it makes me wonder.
> 
> Btw, the RAID is on a cciss controller.
> 
> Greetings,
> 
> These are the contents of the syslog:
> Mar 31 04:34:01 baja1 kernel: journal-601, buffer write failed
> Mar 31 04:34:01 baja1 kernel: kernel BUG at prints.c:334!

Although it's unclear by the kernel output, this is a reiserfs panic due
to an i/o error in the journal, not a BUG. Kernels prior to 2.6.10,
unless specifically patched, could not handle i/o errors in the journal.
This functionality has not been backported to 2.4 kernels.

I suspect that perhaps klogd was matched against the wrong kernel symbol
table, and that's why you're seeing odd output in your syslog. The
entire call chain, after sync_supers, should be in reiserfs if you're
getting that panic.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCnzwFLPWxlyuTD7IRAkIMAJwJ6c99kqoenFH+joLytWmUa7vS7ACeNKAc
z2REA+4/g6QB0cAA4XiHIAE=
=Jk7H
-----END PGP SIGNATURE-----
