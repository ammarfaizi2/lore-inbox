Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271042AbTHCHWZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 03:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271055AbTHCHWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 03:22:25 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:48654 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S271042AbTHCHWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 03:22:24 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roland McGrath <roland@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] bug in setpgid()? process groups and thread groups
References: <200308021908.h72J82x10422@magilla.sf.frob.com>
	<1059857483.20306.6.camel@dhcp22.swansea.linux.org.uk>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Roland McGrath
 <roland@redhat.com>,  Jeremy Fitzhardinge <jeremy@goop.org>, Ulrich
 Drepper <drepper@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Date: Sun, 03 Aug 2003 09:22:14 +0200
In-Reply-To: <1059857483.20306.6.camel@dhcp22.swansea.linux.org.uk> (Alan
 Cox's message of "02 Aug 2003 21:51:24 +0100")
Message-ID: <8765lfxl21.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> #1 Lots of non posix afflicted intelligent programmers use the per
> thread uid stuff in daemons. Its really really useful

It doesn't work reliably because the threading implementation might
have to send signals which the current combination of credentials does
not allow.

IMHO, POSIX is wrong to favor process attributes so strongly.  It
wouldn't be a problem if there were other ways to pass these implicit
parameters (such as thread-specific attributes, or, even better,
syscall arguments).  But often there isn't.
