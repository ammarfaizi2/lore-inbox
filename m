Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVC2Wlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVC2Wlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVC2WkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:40:25 -0500
Received: from smtpout.mac.com ([17.250.248.70]:30928 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261617AbVC2Whm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:37:42 -0500
In-Reply-To: <20050329142248.GA32455@nevyn.them.org>
References: <20050327205014.GD4285@stusta.de> <20050327232158.46146243.khali@linux-fr.org> <20050328222348.4c05e85c.akpm@osdl.org> <20050329142248.GA32455@nevyn.them.org>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <125c71877e5ad9e625336709874ced54@mac.com>
Content-Transfer-Encoding: 7bit
Cc: bunk@stusta.de, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Do not misuse Coverity please (Was: sound/oss/cs46xx.c: fix a check after use)
Date: Tue, 29 Mar 2005 17:37:19 -0500
To: Daniel Jacobowitz <dan@debian.org>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 29, 2005, at 09:22, Daniel Jacobowitz wrote:
> The thing GCC is most likely to do with this code is discard the NULL
> check entirely and leave only the oops; the "if (!card)" can not be
> reached without passing through "card->amplifier", and a pointer which
> is dereferenced can not be NULL in a valid program.

Not true!  It is perfectly legal on a large number of platforms to
explicitly mmap something at the address 0, at which point dereferencing
a null pointer is exactly like dereferencing any other pointer on the
heap.  Doing so is not recommended except in a few special cases for
emulators and such, but it works to some extent.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


