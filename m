Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266689AbUGVE0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266689AbUGVE0x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 00:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266693AbUGVE0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 00:26:53 -0400
Received: from dsl081-055-019.sfo1.dsl.speakeasy.net ([64.81.55.19]:20369 "EHLO
	mail.fountainbay.com") by vger.kernel.org with ESMTP
	id S266689AbUGVE0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 00:26:50 -0400
Message-ID: <4411.24.6.231.172.1090470409.squirrel@24.6.231.172>
In-Reply-To: <20040721230044.20fdc5ec.akpm@osdl.org>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
    <20040721230044.20fdc5ec.akpm@osdl.org>
Date: Wed, 21 Jul 2004 21:26:49 -0700 (PDT)
Subject: Re: [PATCH] Delete cryptoloop
From: dpf-lkml@fountainbay.com
To: "Andrew Morton" <akpm@osdl.org>
Cc: "James Morris" <jmorris@redhat.com>, linux-kernel@vger.kernel.org
Reply-To: dpf-lkml@fountainbay.com
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello James and Andrew,

Hopefully someone else will follow up, but I hope I'm somewhat convincing:

Andrew Morton said:
> James Morris <jmorris@redhat.com> wrote:
>>
>> This patch deletes cryptoloop,
>
> OK - if nobody complains convincingly we'll drop cryptoloop out of 2.6.9.
>

Cryptoloop is deprecated (since 2.6.4), but that doesn't mean it should be
deleted. As is the case with many deprecated APIs, they usually hang
around for a long time (until the next major rev) so that people have a
chance to transition their tools. Is no one else using cryptoloop? Are 5
minor revs really enough time (so far about 5 months)?

>> which is buggy, unmaintained, and
>> reportedly has mutliple security weaknesses.
>
> Doesn't dm-crypt have the same security weaknesses?
>

I don't doubt the superiority of dm-crypt. But most people using a
_deprecated_ feature would know that means "buggy, unmaintained" and with
possible weaknesses.

Perhaps a better way to communicate deprecation, instead of pulling the
rug out from under people by deleting so soon, is to inject warnings
during compilation, or even during use. Or, split off the new code into a
differently named module -- leaving a clean way to throw out the old
method.

>From the cryptoloop HOWTO website:
(http://www.tldp.org/HOWTO/Cryptoloop-HOWTO/cryptoloop-introduction.html)

"Dm-crypt is available in the main kernel since 2.6.4. Cryptoloop will
still be available in the main kernel for a long time, but dm-crypt will
be the method of choice for disk encryption in the future."

And then it goes on to say:

"It is still very new and there are no easy-to-use userspace tools
available yet. Dm-crypt is considered to be much cleaner code than
Cryptoloop, but there are some important differences. For example,
creating an ecrypted filesystem within a file will still require to go
through a loop device, but this support is still in development."

So it looks like dm-crypt is still up in the air on feature compatibility
with cryptoloop.

Deleting cryptoloop in 2.6.9 seems too soon -- even the cryptoloop HOWTO
maintainer (Ralph Hölzer) seems to expect it to hang around.

In February, lkml had essentially the same discussion.
(http://kerneltrap.org/node/view/2433)

Ditching cryptoloop completely in 2.7 after dm-crypt matures would be a
better idea.

Regards,

Dale Fountain


