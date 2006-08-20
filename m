Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbWHTQwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbWHTQwo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWHTQwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:52:44 -0400
Received: from mother.openwall.net ([195.42.179.200]:32449 "HELO
	mother.openwall.net") by vger.kernel.org with SMTP id S1750945AbWHTQwn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:52:43 -0400
Date: Sun, 20 Aug 2006 20:48:41 +0400
From: Solar Designer <solar@openwall.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Alex Riesen <fork0@users.sourceforge.net>,
       Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
Message-ID: <20060820164841.GA20433@openwall.com>
References: <20060820003840.GA17249@openwall.com> <20060820100706.GB6003@steel.home> <20060820153037.GA20007@openwall.com> <1156089203.23756.46.camel@laptopd505.fenrus.org> <44E88DC3.7000708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E88DC3.7000708@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Arjan van de Ven wrote:
> > sounds like a good argument to get the setuid functions marked
> > __must_check in glibc...

I agree.

On Sun, Aug 20, 2006 at 09:28:51AM -0700, Ulrich Drepper wrote:
> There are too many false positives.  E.g., in a SUID binaries switching
> back from a non-root UID to root will not fail.  Very common.

I wouldn't call those false positives.  They're warnings of poorly
written code that might fail with further changes to the kernel or with
custom security modules, or on another Unix-like platform.

Of course, the kernel or security modules must not change the semantics
arbitrarily yet expect old apps to work, however expecting that apps
honor return value from set*[ug]id() would be reasonable.  (The only
reason why it is not is that there are so many broken apps out there and
more are being developed.)

Alexander
