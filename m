Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTLNJcG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 04:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263541AbTLNJcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 04:32:06 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:1669 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S263298AbTLNJcD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 04:32:03 -0500
Date: Sun, 14 Dec 2003 10:28:02 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: In fs/proc/array.c error in function proc_pid_stat
Message-ID: <20031214092802.GA1481@localhost>
References: <20031213192516.4897.qmail@linuxmail.org> <20031213193040.GD11665@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20031213193040.GD11665@holomorphy.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday December 13th 2003 William Lee Irwin III wrote:

> A quick reading of the patch (BTW, your MUA is mangling whitespace)
> reveals it's merely creating a local variable, which should have no
> bearing on code generation.

It shouldn't indeed, but it does anyway. The main fault here is some
bug that RedHat's gcc 2.96 has with dealing with 'unsigned long long'
variables. It seems to be partly triggered by the relative complexity
of the very long printf statement it's part of in this file. An earlier
patch that *only* broke up the printf (so without the local variable)
also fixed compilation for some people, though not for all. Changing
some random local variable to 'volatile' also fixed compilation.

> i.e. the compiler is broken.

It's a known *bug*, and seems to be triggered in the current 2.6.0-test
series for gcc 2.96 only in this particular function. Perhaps 'broken'
is a bit too harsh!

> Bad code generation can cause runtime problems too; upgrading to a
> bugfixed compiler is the only sound course of action.

Perhaps. But older (server) platforms with this compiler are still in
wide use, if a simple patch can make use of an otherwise reasonable
compiler again, what's the big deal. And on these platforms dual
installing two versions of gcc (and especially g++ for userspace) can
lead to other mistakes and very hard to debug artifacts from mixed
object code.
-- 
Marco Roeland, who strangely enough only uses Debian unstable himself!
