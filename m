Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbUCAJty (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 04:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbUCAJty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 04:49:54 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:39158 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S261195AbUCAJtu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 04:49:50 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: finding unused globals in the kernel
Date: Mon, 1 Mar 2004 10:42:09 +0100
User-Agent: KMail/1.6.1
Cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
References: <5138.1078121472@kao2.melbourne.sgi.com>
In-Reply-To: <5138.1078121472@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403011042.10099.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 March 2004 07:11, Keith Owens wrote:
> It is a bit harder than a simple compare.  EXPORT_SYMBOL(foo) generates
> a reference to foo even if nothing uses it, which hides unused
> variables.  Certain symbols appear as unused but are really used by the
> 2.4 version of insmod.  Your script does not handle modules at all.
> 
> namespace.pl below handles all the special cases on kernels from 2.0
> through 2.4.  It needs updating for 2.6 kernels, enjoy.

Well, your script is about a related, but still different question.
namespace.pl apparently gives a list of symbols that could/should have 
been marked static because they are not referenced outside of their
files. I have another script that does this as well, though yours
is a lot better at it.

The question that my checkunused.sh is trying to answer is which symbols 
are never referenced at all and therefore could be removed from the 
kernel binary. I intentionally kept the references from EXPORT_SYMBOL,
because I didn't want to think about whether there might be modules
using them.

Finding exported symbols that no module in the tree uses is yet
another problem. Your namespace.pl does this on object files, but
using cscope at source level could perhaps do this better.

	Arnd <><
