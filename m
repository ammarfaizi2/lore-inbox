Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276743AbRJYXuD>; Thu, 25 Oct 2001 19:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276761AbRJYXty>; Thu, 25 Oct 2001 19:49:54 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33286 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276743AbRJYXtl>; Thu, 25 Oct 2001 19:49:41 -0400
Subject: Re: [RFC] New Driver Model for 2.5
To: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 26 Oct 2001 00:53:15 +0100 (BST)
Cc: xavier.bestel@free.fr (Xavier Bestel), alan@lxorguk.ukuu.org.uk (Alan Cox),
        torvalds@transmeta.com (Linus Torvalds),
        mochel@osdl.org (Patrick Mochel),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20011025235359.12066@smtp.adsl.oleane.com> from "Benjamin Herrenschmidt" at Oct 26, 2001 01:53:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wuJH-0006lB-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The cdrecord case is a high level issue, and scsi is a mess ;)

Grin

> We are not yet at a point where we can be more constructive
> than what was already said. Ultimately we need to move a bit
> forward with the real implementation and see how some problems
> show up. The architecture as it was designed so far is light,
> and most of the debate is not around it, it's around how it
> should be used by drivers & kernel subsystems ;)

I think I understand how to handle this and avoid races. Linus idea of
/proc files so you can ask "what is busy" solves most of it. Then the
policy daemon can make a choice about suspending or not.

If we make the proc file a large bitmask of events then the policy daemon
call to kernel becomes

	"suspend even if [event-mask] set"

This means that a daemon call that races the start of say a CD burn will
fail and the daemon can rescan, rethink and if need be reissue the request
sanely.

