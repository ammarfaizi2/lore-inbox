Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131925AbRAKSXA>; Thu, 11 Jan 2001 13:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131674AbRAKSW2>; Thu, 11 Jan 2001 13:22:28 -0500
Received: from mons.uio.no ([129.240.130.14]:55940 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S130006AbRAKSWM>;
	Thu, 11 Jan 2001 13:22:12 -0500
To: Russell King <rmk@arm.linux.org.uk>
Cc: Manfred Spraul <manfred@colorfullife.com>,
        Andrea Arcangeli <andrea@suse.de>, Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Compatibility issue with 2.2.19pre7
In-Reply-To: <20010110013755.D13955@suse.de> <200101100654.f0A6sjJ02453@flint.arm.linux.org.uk> <20010110163158.F19503@athlon.random> <shszogy2jmr.fsf@charged.uio.no> <3A5DDD09.C8C70D36@colorfullife.com> <14941.61668.697523.866481@charged.uio.no>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 11 Jan 2001 19:22:03 +0100
In-Reply-To: Trond Myklebust's message of "Thu, 11 Jan 2001 18:44:04 +0100 (CET)"
Message-ID: <shsae8y2blg.fsf@charged.uio.no>
X-Mailer: Gnus v5.6.45/XEmacs 21.1 - "Channel Islands"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Trond Myklebust <trond.myklebust@fys.uio.no> writes:

     > - if (file->f_handle.fh_dcookie == fh->fh_dcookie &&
     > - !memcmp(&file->f_handle, fh, sizeof(*fh)))
     > + if (file->f_handle.fh_dcookie == fh.fh_dcookie &&
     > + !memcmp(&file->f_handle, &fh, sizeof(fh)))
     >  			goto found;

Come to think of it, this line looks pretty insane. Why on earth are
we testing fh_dcookie twice?

I suspect that just the elimination of the redundant comparison in the
above line would eliminate Russell's problem entirely, given that it's
the only place in the entire routine where we actually reference
fh->fh_base.fb_dentry.

In all other cases, we're referencing ordinary integers. Are there any
alignment requirements on them?

Cheers,
  Trond
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
