Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbWIDThm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbWIDThm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 15:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWIDThm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 15:37:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:64756 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964924AbWIDThl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 15:37:41 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: matthieu castet <castet.matthieu@free.fr>
Subject: Re: msleep_interruptible vs msleep
Date: Mon, 4 Sep 2006 21:38:26 +0200
User-Agent: KMail/1.9.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
References: <44FC7EAE.6020300@free.fr>
In-Reply-To: <44FC7EAE.6020300@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609042138.26603.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Monday 04 September 2006 21:29 schrieb matthieu castet:
>
> But why if I have a kernel thread that do [1] :
>
> while (true) {
> Do some stuff
> msleep(1000)
> }
>
> the load average is high (near 100%).
>
> and if I use msleep_interruptible the load average is normal.

These are the traditional semantics of incorruptible vs. noninterruptible
sleep. A process that sleep noninterruptible contributes to the load
average but does not consume actual CPU cycles.

I guess you can take that as a hint that the code you're describing
above is a bad thing to do.

> Does the same applies to wait_event_timeout vs
> wait_event_interruptible_timeout ?

yes.

	Arnd <><
