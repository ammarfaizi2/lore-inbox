Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135200AbRDRPVW>; Wed, 18 Apr 2001 11:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135204AbRDRPVN>; Wed, 18 Apr 2001 11:21:13 -0400
Received: from ns.suse.de ([213.95.15.193]:780 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135200AbRDRPVC>;
	Wed, 18 Apr 2001 11:21:02 -0400
To: Chris Evans <chris@scary.beasts.org>
Cc: David Schleef <ds@schleef.org>, Dawson Engler <engler@csl.Stanford.EDU>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] copy_*_user length bugs?
In-Reply-To: <Pine.LNX.4.30.0104181206130.28455-100000@ferret.lmh.ox.ac.uk>
X-Yow: Has everybody got HALVAH spread all over their ANKLES??...
 Now, it's time to ``HAVE A NAGEELA''!!
From: Andreas Schwab <schwab@suse.de>
Date: 18 Apr 2001 17:21:00 +0200
In-Reply-To: <Pine.LNX.4.30.0104181206130.28455-100000@ferret.lmh.ox.ac.uk> (Chris Evans's message of "Wed, 18 Apr 2001 12:14:56 +0100 (BST)")
Message-ID: <jeeluqz12b.fsf@hawking.suse.de>
User-Agent: Gnus/5.090002 (Oort Gnus v0.02) Emacs/21.0.103
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Evans <chris@scary.beasts.org> writes:

|> To justify this, consider if len were set to minus 2 billion. This will
|> pass the sanity check, and pass the value straight on to copy_to_user. The
|> copy_to_user parameter is unsigned, so this value because approximately
|> +2Gb.
|> 
|> Now, providing the malicious user passes a low user space pointer (e.g.
|> just above 0), the kernel's virtual address space wrap check will not
|> trigger because ~0 + ~2Gb does not exceed 4G. And the result is the user
|> being able to read kernel memory.

On m68k this is not a problem, since kernel and user address space are
strictly distinct, even in the kernel.  The luser will get an EFAULT
eventually.

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
