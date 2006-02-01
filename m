Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423038AbWBAX4e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423038AbWBAX4e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 18:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423039AbWBAX4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 18:56:34 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:6342 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1423038AbWBAX4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 18:56:34 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Andrew Morton <akpm@osdl.org>, Gerd Hoffman <kraxel@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.16-rc1-mm4 
In-reply-to: Your message of "Tue, 31 Jan 2006 21:44:20 CDT."
             <200601312146_MC3-1-B74E-D5C4@compuserve.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 02 Feb 2006 10:56:31 +1100
Message-ID: <20901.1138838191@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert (on Tue, 31 Jan 2006 21:44:20 -0500) wrote:
>In-Reply-To: <20060129144533.128af741.akpm@osdl.org>
>
> $ perl scripts/reference_init.pl | grep smp_locks
> Error: ./arch/i386/kernel/alternative.o .smp_locks refers to 00000008 R_386_32          .init.text
> ...
>
>Caused by x86_smp_alternatives.patch
>
>Does this mean that the SMP lock-switching could write all over discarded
>__init code?

Looking at the patch, it builds tables that can refer to .init.text but
then it excludes table entries that do not fall between _text and
_etext.  Which makes the reference from .smp_locks to .init.text a
false positive.  Gerd, is that the way that smp_alternatives is meant
to work?  If so, I will update reference_*.pl.

+		alternatives_smp_module_add(NULL, "core kernel",
+					    __smp_locks, __smp_locks_end,
+					    _text, _etext);

