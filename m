Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263541AbTLNKAA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 05:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbTLNKAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 05:00:00 -0500
Received: from holomorphy.com ([199.26.172.102]:50307 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263541AbTLNJ76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 04:59:58 -0500
Date: Sun, 14 Dec 2003 01:59:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Marco Roeland <marco.roeland@xs4all.nl>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: In fs/proc/array.c error in function proc_pid_stat
Message-ID: <20031214095953.GV8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Marco Roeland <marco.roeland@xs4all.nl>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <20031213192516.4897.qmail@linuxmail.org> <20031213193040.GD11665@holomorphy.com> <20031214092802.GA1481@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031214092802.GA1481@localhost>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday December 13th 2003 William Lee Irwin III wrote:
>> A quick reading of the patch (BTW, your MUA is mangling whitespace)
>> reveals it's merely creating a local variable, which should have no
>> bearing on code generation.

On Sun, Dec 14, 2003 at 10:28:02AM +0100, Marco Roeland wrote:
> It shouldn't indeed, but it does anyway. The main fault here is some
> bug that RedHat's gcc 2.96 has with dealing with 'unsigned long long'
> variables. It seems to be partly triggered by the relative complexity
> of the very long printf statement it's part of in this file. An earlier
> patch that *only* broke up the printf (so without the local variable)
> also fixed compilation for some people, though not for all. Changing
> some random local variable to 'volatile' also fixed compilation.

s/fixed compilation/appeared to work around a compiler bug/


On Saturday December 13th 2003 William Lee Irwin III wrote:
>> i.e. the compiler is broken.

On Sun, Dec 14, 2003 at 10:28:02AM +0100, Marco Roeland wrote:
> It's a known *bug*, and seems to be triggered in the current 2.6.0-test
> series for gcc 2.96 only in this particular function. Perhaps 'broken'
> is a bit too harsh!

It breaks elsewhere in various ways (or has broken; maybe they update
things they still call 2.96).


On Saturday December 13th 2003 William Lee Irwin III wrote:
>> Bad code generation can cause runtime problems too; upgrading to a
>> bugfixed compiler is the only sound course of action.

On Sun, Dec 14, 2003 at 10:28:02AM +0100, Marco Roeland wrote:
> Perhaps. But older (server) platforms with this compiler are still in
> wide use, if a simple patch can make use of an otherwise reasonable
> compiler again, what's the big deal. And on these platforms dual
> installing two versions of gcc (and especially g++ for userspace) can
> lead to other mistakes and very hard to debug artifacts from mixed
> object code.

(1) I don't trust it for runtime code either; there have been problems.
(2) These idiotic rearrangements of code to work around compiler bugs
	are worthless since you'll eventually end up eventually needing
	contradictory changes to work around different compilers' bugs.
	They're also total crap changes, worthless code churn, and even
	uglify the code.
(3) 2.96? You must be kidding. Current is bordering on 3.4 if it's not
	there already. Do you think anyone's still taking patches for
	2.2.8 Linux kernels? Now apply the same reasoning to gcc. Some
	backport TLC from a distro is not going to be able to bring it
	up to modern standards.
(4) 2 versions of gcc is nothing and has zero bearing on the C++ ABI
	braindamage that went around a couple of years ago as it's not
	a C++ compiler.


-- wli
