Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261664AbULBP6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbULBP6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 10:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbULBP5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 10:57:44 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:24452 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261664AbULBP4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 10:56:08 -0500
Date: Thu, 2 Dec 2004 16:56:00 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Andreas Schwab <schwab@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cosa.h ioctl numbers
Message-ID: <20041202155559.GR11992@fi.muni.cz>
References: <20041202124456.GF11992@fi.muni.cz> <200412021358.00844.arnd@arndb.de> <20041202131224.GI11992@fi.muni.cz> <jeu0r4ajl4.fsf@sykes.suse.de> <20041202141132.GO11992@fi.muni.cz> <jellcgag2v.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jellcgag2v.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab wrote:
: Jan Kasprzak <kas@fi.muni.cz> writes:
: 
: > Andreas Schwab wrote:
: > : If you want real compatibility you should use size_t, which is what 2.4 is
: > : effectively using.
: > : 
: > 	I assume that sizeof(struct .. *) == sizeof(size_t) on i386.
: 
: This has nothing to do with this, but everything to do with
: sizeof(sizeof(foo)) == sizeof(size_t).  And COSAIODOWNLD does not expect a
: pointer to a pointer but a pointer to struct cosa_download, which means
: that _IOW('C',0xf2,struct cosa_download *) would be completely wrong
: anyway.

	I do not understand. The _IOW() macro just uses sizeof(_third_argument)
both on 2.4 and 2.6. And nothing else than sizeof() is done with the third
argument of _IOW(). So it does not matter what you put into the third
argument anyway, provided that you make sure the ABI (i.e. the type
and layout of the last argument to ioctl()) remains the same. The third
argument to _IOW() is just a (rather weak) helper which helps you to detect
the unwanted ABI change.

	Yes, I made a (small) mistake when writing cosa.h during the
Linux 2.1 development cycle, but since nobody cared and I am pretty
sure I did not change the layout of struct cosa_download at all since
Linux 2.1, I would rather have the 2.6 ioctl numbers the same
as in 2.1-2.4.
 
-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
