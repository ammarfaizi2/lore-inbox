Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268147AbUIPTio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268147AbUIPTio (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 15:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268148AbUIPTio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 15:38:44 -0400
Received: from h-68-165-86-241.dllatx37.covad.net ([68.165.86.241]:17790 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S268147AbUIPTim
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 15:38:42 -0400
Subject: Re: PATCH: tty drivers take two
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Cox <alan@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916143057.GA15163@devserv.devel.redhat.com>
References: <20040916143057.GA15163@devserv.devel.redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1095363506.2937.9.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Sep 2004 14:38:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan:

The N_TTY ldisc global reference leak
is still in tty_io.c release_dev().

This does not currently cause a problem because
N_TTY is never deregistered. It seems
a little ugly to have the N_TTY reference
invalid when all other ldisc references
are maintained. I could see this subtle
difference biting someone in the future
when working with this.

The lines that cause the leak serve no
purpose. There is no reason to assign
N_TTY ldisc to a tty instance that
is then immediately thrown away. The lines
that drop the reference to the current ldisc
are, of course, still needed.

-- 
Paul Fulghum
paulkf@microgate.com

