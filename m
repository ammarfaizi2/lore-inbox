Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264080AbTDOVQR (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 17:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbTDOVQO 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 17:16:14 -0400
Received: from pop.gmx.de ([213.165.64.20]:26963 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264080AbTDOVQG 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 17:16:06 -0400
Message-ID: <3E9C7955.7070605@gmx.net>
Date: Tue, 15 Apr 2003 23:27:49 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.5] include/asm-generic/bitops.h {set,clear}_bit return
  void
References: <20030415174010$3e7e@gated-at.bofh.it> <200304152007.h3FK72sD003180@post.webmailer.de>
In-Reply-To: <200304152007.h3FK72sD003180@post.webmailer.de>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:
> Carl-Daniel Hailfinger wrote:
> 
> 
>>+     mask = 1 << (nr & 0x1f);
>>+     cli();
>>+     *addr |= mask;
>>+     sti();
> 
> 
> cli() and sti() are no more. Moreover, the file you are trying to fix is

What is the preferred way to achieve atomicity in an operation now that
cli() and sti() are gone?

> not even used anywhere. Better submit a patch to remove it completely.

The point of asm-generic is not to use the files, but to give porters a
hint about the functionality. Quoting asm-generic/bitops.h:

/* For the benefit of those who are trying to port Linux to another
 * architecture, here are some C-language equivalents.  You should
 * recode these in the native assembly language, if at all possible.
 * To guarantee atomicity, these routines call cli() and sti() to
 * disable interrupts while they operate.  (You have to provide inline
 * routines to cli() and sti().) */

Or is this comment wrong, too?

Regards,
Carl-Daniel

-- 
http://www.hailfinger.org/

