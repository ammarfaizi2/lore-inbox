Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWGXWUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWGXWUq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 18:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWGXWUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 18:20:46 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:27581
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932278AbWGXWUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 18:20:45 -0400
Message-ID: <44C547B0.1090304@lsrfire.ath.cx>
Date: Tue, 25 Jul 2006 00:20:32 +0200
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       Wolfgang Draxinger <Wolfgang.Draxinger@campus.lmu.de>,
       Bodo Eggert <7eggert@gmx.de>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [RFC][PATCH] procfs: add privacy options
References: <44C50A2B.3040203@lsrfire.ath.cx> <m18xmiogp3.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m18xmiogp3.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman schrieb:
> I don't really like filesystem magic options as kernel boot time options.
> Mount time or runtime options are probably more interesting.
> 
> How is it expected that users will use this?

I don't expect admins to switch "privacy" on and off very often.  Once
would be enough, I hope.

Mount options would be easier to use, I agree, but I doubt the added
complexity is worth it.  Kernel options for procfs are not _that_
magical because the kernel mounts it internally, so it's a kernel part,
not a real filesystem ;-)

One question I couldn't find a good answer for regarding remount
options: what to do with processes that have cd'd into a /proc/<pid> dir
belonging to another user when the privacy option is being turned on?
Letting them keep their access is counter-intuitive and taking it away
would need quite invasive changes compared to my patch, I think.

> A lot of the privacy you are talking about is provided by the may_ptrace
> checks in the more sensitive parts of proc so we may want to extend
> that.

You mean using ptrace_may_attach() and/or MAY_PTRACE() for determining
access to all (or at least more) files in /proc/<pid> instead of my
proposed "chmod 500"?  What are the advantages?

Thanks,
René
