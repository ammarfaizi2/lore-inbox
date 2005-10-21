Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbVJUMHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbVJUMHK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 08:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbVJUMHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 08:07:10 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:47367 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964912AbVJUMHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 08:07:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Rp+epNESBrDrloA7WhhpgER+XTyxqbaq1FOQ5PPl9qKD7Cz2I5/xxyKIff3oY6dkFU6hBORjaDUQVWdQqmVDi0TfpAYy/KAaPeAnuPzT+k8qSjKuo9zRlFkpMiA6gH5sbed62AXasqLQRR4GVAoH0ncNZlb8bL8hwwGCRbeExa0=
Message-ID: <4358F638.1030907@gmail.com>
Date: Fri, 21 Oct 2005 14:07:52 +0000
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org, keyrings@linux-nfs.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Keys: Get rid of warning in kmod.c if keys disabled
References: <6bffcb0e0510201124t66284e7ct@mail.gmail.com>  <Pine.LNX.4.64.0510192328360.5909@g5.osdl.org> <7369.1129890691@warthog.cambridge.redhat.com>
In-Reply-To: <7369.1129890691@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

David Howells napisa³(a):

>The attached patch gets rid of a "statement without effect" warning when
>CONFIG_KEYS is disabled by making use of the return value of key_get(). The
>compiler will optimise all of this away when keys are disabled.
>
>Signed-Off-By: David Howells <dhowells@redhat.com>
>---
>warthog>diffstat -p1 keys-kmodwarn-2614rc1mm1.diff
> kernel/kmod.c |    6 +++---
> 1 files changed, 3 insertions(+), 3 deletions(-)
>
>diff -uNrp linux-2.6.14-rc4-mm1/kernel/kmod.c linux-2.6.14-rc4-michal/kernel/kmod.c
>--- linux-2.6.14-rc4-mm1/kernel/kmod.c	2005-08-30 13:56:39.000000000 +0100
>+++ linux-2.6.14-rc4-michal/kernel/kmod.c	2005-10-21 11:13:16.000000000 +0100
>@@ -131,14 +131,14 @@ struct subprocess_info {
> static int ____call_usermodehelper(void *data)
> {
> 	struct subprocess_info *sub_info = data;
>-	struct key *old_session;
>+	struct key *new_session, *old_session;
> 	int retval;
> 
> 	/* Unblock all signals and set the session keyring. */
>-	key_get(sub_info->ring);
>+	new_session = key_get(sub_info->ring);
> 	flush_signals(current);
> 	spin_lock_irq(&current->sighand->siglock);
>-	old_session = __install_session_keyring(current, sub_info->ring);
>+	old_session = __install_session_keyring(current, new_session);
> 	flush_signal_handlers(current, 1);
> 	sigemptyset(&current->blocked);
> 	recalc_sigpending();
>
>  
>
Thanks, patch fixed warning.

Regards,
Michal Piotrowski
