Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030206AbWAIR25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbWAIR25 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWAIR25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:28:57 -0500
Received: from locomotive.csh.rit.edu ([129.21.60.149]:13654 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S964883AbWAIR24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:28:56 -0500
Message-ID: <43C29E43.8030405@suse.com>
Date: Mon, 09 Jan 2006 12:32:51 -0500
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ia64: including <asm/signal.h> alone causes compilation
 errors
References: <20060109171514.GA25096@locomotive.unixthugs.org> <20060109172554.GA3026@infradead.org>
In-Reply-To: <20060109172554.GA3026@infradead.org>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christoph Hellwig wrote:
> On Mon, Jan 09, 2006 at 12:15:14PM -0500, Jeff Mahoney wrote:
>>  Including *just* <asm/signal.h> on ia64 will result in a compilation failure,
>>  where it will succeed on every other architecture.
>>
>>  Every other arch includes <linux/compiler.h> either directly or via
>>  <linux/types.h> at the top of <asm-*/signal.h>. ia64 includes
>>  <linux/types.h> after including <asm-generic/signal.h>, which causes
>>  the __user in <asm-generic/signal.h> to get passed through untouched, causing
>>  compilation errors.
>>
>>  This patch moves the #include <linux/types.h> up to the beginning of signal.h,
>>  as found on every other arch.
>>
>>  A specific example of where this behavior is observed is the recent addition
>>  of OCFS2. fs/ocfs2/cluster/userdlm.c seems alone in only including
>>  <asm/signal.h>, which seems to be perfectly valid.
> 
> Generally you should only include <asm/signal.h> via <linux/signal.h>, which gets
> <linux/compiler.h> via <linux/spinlock.h>

Ok. I just did a quick grep and saw a number of places where
<asm/signal.h> was included. A closer look reveals most of those are in
arch/.

Ignore the noise.

- -Jeff

- --
Jeff Mahoney
SUSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDwp5DLPWxlyuTD7IRAoZBAKCf4MMQNC/rfcdXOH0Dto3RTa32qgCfSeFf
pX68kyrbj2ZdH23Mo+EmUZ4=
=y7xp
-----END PGP SIGNATURE-----
