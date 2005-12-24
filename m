Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVLXSNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVLXSNp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 13:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbVLXSNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 13:13:45 -0500
Received: from lixom.net ([66.141.50.11]:58803 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S932199AbVLXSNo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 13:13:44 -0500
Date: Sat, 24 Dec 2005 12:13:26 -0600
To: Jack Steiner <steiner@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] - Fix memory ordering problem in wake_futex()
Message-ID: <20051224181325.GH24601@pb15.lixom.net>
References: <20051223163816.GA30906@sgi.com> <20051224134523.GA7187@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051224134523.GA7187@sgi.com>
User-Agent: Mutt/1.5.9i
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Dec 24, 2005 at 07:45:23AM -0600, Jack Steiner wrote:
> This patch is identical to the first patch except I used smp_wmb() instead
> of wmb(). Ordering doen't matter on non-SMP kernels.

Ok, I guess I was wrong -- there's no guarantee that protects stuff from
bleeding into a critical region from after it. Comments in line 54-58 of
kernel/wait.c seems to imply this. Nevermind the fact that most other
architectures seem to protect it anyway. :-)

However, please do fix the comment earlier in the function that implies
that the unlock does indeed do enough barriers while you're at it,
since it seems to be incorrect and misleading.


-Olof
