Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263457AbUESKjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbUESKjR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 06:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUESKjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 06:39:17 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:17608 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S263457AbUESKjQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 06:39:16 -0400
Date: Wed, 19 May 2004 12:38:56 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sendfile -EOVERFLOW on AMD64
Message-ID: <20040519103855.GF18896@fi.muni.cz>
References: <1XuW9-3G0-23@gated-at.bofh.it> <m3d650wys1.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3d650wys1.fsf@averell.firstfloor.org>
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
: Jan Kasprzak <kas@informatics.muni.cz> writes:
: >
: > The image (FC2-i386-DVD.iso) has 4370640896 bytes. The FTP server is native
: > x86_64 binary, not a 32-bit one.
: 
: sys_sendfile limits itself dumbly to 2GB even on 64bit architectures.
: This patch should fix it on x86-64, although other 64bit ports may 
: need a similar patch. Just removing the limit in read_write 
: is not easy, because it would need fixes in all the 32bit emulation
: layers.
: 
	It partly helped, thanks. But there is still one more problem
- it looks like sendfile() returns 32-bit value instead of 64-bit.
My debug info looks like this:

sendfile(offset=0, count=4370640896)
    = -767073160, offset=3527894136

where I do

	long val = sendfile(...); printf(...%ld..., val);

-Yenya


-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
 Any compiler or language that likes to hide things like memory allocations
 behind your back just isn't a good choice for a kernel.   --Linus Torvalds
