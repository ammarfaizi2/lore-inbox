Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbVLNWs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVLNWs3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbVLNWs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:48:29 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:63409 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965053AbVLNWs2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:48:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KOr/70JQX61m7o0aH01jLt5Jk6YaFIgZR+tsZEzy4HCge5XwT2aGuPGcDmmn629SUzlBcoX5ISdNMk3eRLGOVGEs+QA2X9f+Nr5vJr87TYLiinh9VVTqQG2DEKBWw3Bi2x4r42tu1Lhg5PaHq8k4T7UPxKrDzBU0/rxBm9dPrSk=
Message-ID: <5b5833aa0512141448o1014e7a5vdfd62cfdc61c7d11@mail.gmail.com>
Date: Wed, 14 Dec 2005 18:48:27 -0400
From: Anderson Lizardo <anderson.lizardo@gmail.com>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 0/5] Add MMC password protection (lock/unlock) support
Cc: Anderson Lizardo <anderson.lizardo@indt.org.br>,
       linux-omap-open-source@linux.omap.com,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       Anderson Briglia <anderson.briglia@indt.org.br>,
       Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>,
       Russell King - ARM Linux <linux@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
In-Reply-To: <200512131403.53983.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051213213208.303580000@localhost.localdomain>
	 <200512131403.53983.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/05, David Brownell <david-b@pacbell.net> wrote:
> Is there a writeup on how to hook this up with the key retention
> infrastructure?  I know many folk are unfamiliar with that, and
> I seem to recall a need for some userspace tweaks.  (Like SHA1
> hashing of passphrases to generate MMC keys, and maybe storing
> keys in some per-user file using some user interface.)

We have created a sample text-mode reference UI (using keyctl from the
keyutils[1] package to interface with the key retention service) that
shows how everything works together. We are setting up some web space
to put such UI (actually a set of shell scripts) and we will provide
links soon.

Regarding the userspace tweaks, we have not gone into this aspect, but
just provided the "core" kernel code. Usually, those integrating the
system will dictate policies regarding password hashing, persistent
caching etc. The policies for our reference UI were:

- no hashing (password is sent/stored clear-text)
- in-memory caching (so if the user reboots the system, the password
will have to be re-typed).

I think those policies can be done still on userspace, so the kernel
code remains "policy-free".

[1] http://people.redhat.com/~dhowells/keyutils/
--
Anderson Lizardo
Embedded Linux Lab - 10LE
Nokia Institute of Technology - INdT
Manaus - Brazil
