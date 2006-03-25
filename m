Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWCYUHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWCYUHt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 15:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWCYUHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 15:07:49 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:33953 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751068AbWCYUHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 15:07:48 -0500
Date: Sat, 25 Mar 2006 15:08:45 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 12/16] UML - Memory hotplug
Message-ID: <20060325200845.GA4143@ccure.user-mode-linux.org>
References: <200603241814.k2OIExNn005555@ccure.user-mode-linux.org> <20060324144535.37b3daf7.akpm@osdl.org> <Pine.LNX.4.61.0603252021330.29793@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603252021330.29793@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 08:26:08PM +0100, Jan Engelhardt wrote:
> 
> >> +	char buf[sizeof("18446744073709551615\0")];
> 
> And this one seems wrong[*] to me too (making it a rofl??).
> It is two chars (or one[*]) too long.

One - it needs to be NULL-terminated.
> 
> Consider this test:
> 
> 	#include <stdio.h>
> 	#include <string.h>
> 	int main(void) {
> 	    printf("%d\n", sizeof("18446744073709551615\0"));
> 	    printf("%d\n", sizeof("18446744073709551615"));
> 	    printf("%d\n", strlen("18446744073709551615"));
> 	}
> 
> Which will print, when executed,
> 
> 	22
> 	21
> 	20	(the "pure string" length)
> 

Oops, I was basing this on a hazy (too hazy, apparently) recollection
that the C standard specified sizeof("literal string") as being the
pure string length.  Now that I'm actually thinking about it, the
actual behavior makes much more sense.

Thanks for checking this out in time for me to fix it in my revised
patch.

				Jeff
