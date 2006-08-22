Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWHVKH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWHVKH6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 06:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWHVKH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 06:07:58 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:16601 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932153AbWHVKH5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 06:07:57 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] introduce kernel_execve function to replace __KERNEL_SYSCALLS__
Date: Tue, 22 Aug 2006 12:06:59 +0200
User-Agent: KMail/1.9.1
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
References: <20060819073031.GA25711@atjola.homenet> <1156231742.21752.101.camel@localhost.localdomain> <20060822080046.GA22572@atjola.homenet>
In-Reply-To: <20060822080046.GA22572@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608221207.00344.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 August 2006 10:00, Björn Steinbrink wrote:
> I'm working on a patch loosely based on Arnd's that changes the
> in-kernel syscall macros to directly return the error codes.

I think that is still going in the wrong direction. Traditionally,
the macros in unistd.h were meant for user space, but we're now
discouraging that strongly (i.e. they are inside of #ifdef __KERNEL__).
The only in-kernel users on the _syscall macros used to by the
__KERNEL_SYSCALLS__ that we're trying to kill.

The logical consequence should be that we remove the _syscall macros
entirely, for all architectures.
UML can be converted to use the syscall function provided by libc
in order to call the host OS.

	Arnd <><
