Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTEVN6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 09:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTEVN6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 09:58:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26897 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261868AbTEVN6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 09:58:54 -0400
Date: Thu, 22 May 2003 15:11:56 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: LW@KARO-electronics.de
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >= 2.5.30(at least))
Message-ID: <20030522151156.C12171@flint.arm.linux.org.uk>
Mail-Followup-To: LW@KARO-electronics.de, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <16076.50160.67366.435042@ipc1.karo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16076.50160.67366.435042@ipc1.karo>; from LW@KARO-electronics.de on Thu, May 22, 2003 at 02:34:56PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 02:34:56PM +0200, LW@KARO-electronics.de wrote:
> in file 'mm/filemap.c' a call to 'flush_dcache_page' is missing as a
> replacement for the obsoleted 'flush_page_to_ram' call that was
> present there in older kernels.
> 
> This missing macro call produces data errors when randomly reading an
> 'mmap'ed file (e.g. leading to segfaults, when a program is executed).
> 
> In kernels < 2.5.46 the deprecated macro call was still present
> (defined to do nothing), while in later kernels the call has been
> removed.
> 
> Below are two patches generated against kernel versions 2.5.30 and
> 2.5.68 which should also be applicable to other kernels (with a hunk
> offset).

We seem to have flush_icache_page() in install_page() - I wonder whether
we should also have flush_dcache_page() in there as well.

I've always been confused about what flush_icache_page() is there for,
and its a no-op on ARM.  Whether it should or shouldn't be is an
unanswered question, and will probably remain unanswered until I can
sit down and go through the whole of the VM layer, working out exactly
what it requires and where today.

Maybe someone more knowledgeable of the VM layer can comment.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

