Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264504AbTLQSyT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 13:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264507AbTLQSyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 13:54:18 -0500
Received: from zeus.kernel.org ([204.152.189.113]:38626 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264504AbTLQSyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 13:54:15 -0500
Date: Wed, 17 Dec 2003 18:46:54 +0000
From: Thorsten Kranzkowski <dl8bcu@dl8bcu.de>
To: Will L G <diskman@kc.rr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pam_debug.o: gp-relative relocation against dynamic symbol _pam_token_returns
Message-ID: <20031217184654.A4279@Marvin.DL8BCU.ampr.org>
Reply-To: dl8bcu@dl8bcu.de
Mail-Followup-To: Will L G <diskman@kc.rr.com>,
	linux-kernel@vger.kernel.org
References: <001e01c3c459$49a66180$6401a8c0@zephyr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <001e01c3c459$49a66180$6401a8c0@zephyr>; from diskman@kc.rr.com on Tue, Dec 16, 2003 at 10:50:13PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 16, 2003 at 10:50:13PM -0600, Will L G wrote:
> When ever I attempt to compile Linux-Pam, I receive the following error
> immediately after running 'make':
> 
> /usr/bin/ld: dynamic/pam_debug.o: gp-relative relocation against dynamic
> symbol _pam_token_returns


Always use '-fpic' in CFLAGS when compiling for shared objects (.so)
Otherwise (as in your case) the compiler is allowed to emit machine code
that may not work in shared objects.
When I was hit by this error, the offending library was istself linked to 
another, static library. This isn't allowed either. IIRC my fix was compiling
that .a library with -fpic :)


Thorsten


-- 
| Thorsten Kranzkowski        Internet: dl8bcu@dl8bcu.de                      |
| Mobile: ++49 170 1876134       Snail: Kiebitzstr. 14, 49324 Melle, Germany  |
| Ampr: dl8bcu@db0lj.#rpl.deu.eu, dl8bcu@marvin.dl8bcu.ampr.org [44.130.8.19] |
