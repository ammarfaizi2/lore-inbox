Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261862AbUKVXWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUKVXWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbUKVXUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:20:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27619 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261862AbUKVXS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:18:58 -0500
Date: Mon, 22 Nov 2004 18:18:30 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: var args in kernel?
Message-ID: <20041122231828.GX10340@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20041122113328.GQ10340@devserv.devel.redhat.com> <41A25D53.9050909@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A25D53.9050909@tmr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 04:42:43PM -0500, Bill Davidsen wrote:
> Assignment of struct to struct has been a 
> part of C since earliest times. I used it in ~1990 in code which ran on 
> Z80, Multics, M68k, VAX and Cray2, and it worked without any ifdefs (for 
> that, there were "just a few" for other issues like 8 vs. 9 bit char, etc).

It is not a struct on those arches, but array of structs.
Just try:
#include <stdarg.h>

void foo (int x, ...)
{
  va_list ap, ap2;
  va_start (ap, x);
  ap2 = ap;
  va_end (ap);
}
on say x86_64 or ppc32 and you'll see what I mean:
test.c:7: error: incompatible types in assignment

That's why the standard has va_copy so that you can do the
copying portably.

	Jakub
