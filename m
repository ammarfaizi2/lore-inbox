Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbVISHSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVISHSl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 03:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVISHSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 03:18:41 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:3276 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S932349AbVISHSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 03:18:40 -0400
Message-ID: <432E6649.1070408@v.loewis.de>
Date: Mon, 19 Sep 2005 09:18:33 +0200
From: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Martin Mares <mj@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4NsP0-3YF-17@gated-at.bofh.it> <4NsP1-3YF-19@gated-at.bofh.it> <4NsP1-3YF-21@gated-at.bofh.it> <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it> <4NtBr-4WU-3@gated-at.bofh.it> <4NtL0-5lQ-13@gated-at.bofh.it> <432B2C49.8080008@v.loewis.de> <20050917120123.GA3095@ucw.cz> <432C0B51.704@v.loewis.de> <20050919070820.GA2382@elf.ucw.cz>
In-Reply-To: <20050919070820.GA2382@elf.ucw.cz>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Why is binfmt_misc not enough for you?

For two reasons: for one, it has the overhead of yet another
exec call. This is different from usages for, say, Java byte
code or Python byte code, where the registered interpreter already
is the eventual binary which has to be invoked anyway; for
a binfmt_misc application, you need an additional wrapper
which reinterprets the first line, and then invokes the eventual
interpreter.

The other reason is availability: as an author of an UTF-8
script, you would have to communicate to your users that they
need the right binfmt_misc wrapper installed (which they may
have to build first). While installing additional stuff to
run a single program is acceptable for large applications,
it is likely not for script files. To make the feature useful
in practice, it must be builtin.

Regards,
Martin
