Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751379AbWIYRmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbWIYRmK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 13:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWIYRmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 13:42:09 -0400
Received: from mail.aknet.ru ([82.179.72.26]:4615 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751379AbWIYRmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 13:42:07 -0400
Message-ID: <45181548.8010202@aknet.ru>
Date: Mon, 25 Sep 2006 21:43:36 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
References: <45150CD7.4010708@aknet.ru> <1159059219.3093.276.camel@laptopd505.fenrus.org>
In-Reply-To: <1159059219.3093.276.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi **David, please CC me next time, if possible.

David Wagner wrote:
> Makes sense.  Of course, nothing prevents an attacker from
> introducing malicious loaders, since the loader is an unprivileged
> user-level program.
I think having all the user-writable partitions
noexec actually does prevent an attacker from
introducing a malicious loader, or at least to
invoke it. That's why I think a simple "do not
use noexec whenever it hurts" is a bad option.

>>/filesystem. Think VFAT partition here, where all/
>>/files have execute bits set./
Not strictly related to the topic, but Denis, have
you tried "fmask" option to get rid of this?

> That suggests that the question to Stas should be: Do these programs that
> you're trying to make work count as example of accidental execution of
> binaries on the tmpfs, or are they deliberate execution knowing full well
> that the noexec flag is set and damn the consequences?
This is not at all about executing the *binaries*
on tmpfs, and this is very important. What these
progs need is only to mmap a piece of a shared
memory with the PROT_EXEC permission. Nothing more.
Previously, noexec did not prevent this. Now it does.
What is worse, it prevents this also for MAP_PRIVATE.
This is really something I cannot understand.
The "ro" option doesn't prevent PROT_WRITE for MAP_PRIVATE,
thats the known fact.

