Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbUAaM21 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 07:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264558AbUAaM21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 07:28:27 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:50382 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S264553AbUAaM20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 07:28:26 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: "H. Peter Anvin" <hpa@zytor.com>, Paul Mackerras <paulus@samba.org>
Subject: Re: [klibc] Re: long long on 32-bit machines
Date: Sat, 31 Jan 2004 13:23:40 +0100
User-Agent: KMail/1.5.4
Cc: klibc list <klibc@zytor.com>, linux-kernel <linux-kernel@vger.kernel.org>
References: <4017F991.2090604@zytor.com> <16408.59474.427408.682002@cargo.ozlabs.ibm.com> <401B464C.50004@zytor.com>
In-Reply-To: <401B464C.50004@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401311323.40399.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 January 2004 07:08, H. Peter Anvin wrote:
> Does system calls follow the same convention?

I have just looked up in glibc what architectures need this kind
of handling and found that there is no easy rule. The good news
is that none of (hppa m68k s390 sparc x86_64 alpha cris i386 sparc64 
arm ia64) are doing this. 

AFAICS, the padding is done for exactly these system calls:

ppc: truncate64, ftruncate64, pread64, pwrite64
mips: truncate64, ftruncate64, pread64, pwrite64
sh: pread64, pwrite64

fadvise64_64 is another story: 
mips does no padding, ppc32 reorders the arguments (int fd, int advise,
off64_t offset, off64_t len) and s390 passes a struct, for the
reason Uli already explained.

	Arnd <><

