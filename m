Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbTJAQZo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTJAQVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:21:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:58600 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262410AbTJAQTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:19:37 -0400
Date: Wed, 1 Oct 2003 18:16:13 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Catalin BOIE <util@deuroconsult.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: chstk - URL?
In-Reply-To: <Pine.LNX.4.58.0310011223260.22797@hosting.rdsbv.ro>
Message-ID: <Pine.LNX.4.56.0310011804050.5615@localhost.localdomain>
References: <Pine.LNX.4.58.0310011218290.22797@hosting.rdsbv.ro>
 <Pine.LNX.4.58.0310011223260.22797@hosting.rdsbv.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Oct 2003, Catalin BOIE wrote:

> I use kernel 2.6.0-test6-mm1 with ecec-shield and X gives me sig 11.

for security reasons it's not possible to disable exec-shield for setuid
root processes (such as X). So the solution either to upgrade X to have
the fix or to switch off exec-shield when you start up X, and switch on
exec-shield afterwards. A bit painful the later method ...

(alternatively you can also disable the setuid-root protection in the
kernel, remove the two 'current->personality = PER_LINUX' lines from
fs/exec.c and recompile the kernel.)

> A program must be compiled with new gcc to work with exec-shield and
> without chstk?

no. The X segmenation fault is because the X module loader malloc()s
buffers for code and expects them to be executable. Those buffers were
non-executable on other architectures already, so the fix is really simple
- a oneliner #ifdef or so.

	Ingo
