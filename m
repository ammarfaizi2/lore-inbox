Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbTFWQJj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 12:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264862AbTFWQI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 12:08:29 -0400
Received: from relay.pair.com ([209.68.1.20]:11019 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S264806AbTFWQHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 12:07:05 -0400
X-pair-Authenticated: 65.247.36.27
Subject: Re: O(1) scheduler & interactivity improvements
From: Daniel Gryniewicz <dang@fprintf.net>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Helge Hafting <helgehaf@aitel.hist.no>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1056363509.587.13.camel@teapot.felipe-alfaro.com>
References: <1056298069.601.18.camel@teapot.felipe-alfaro.com>
	 <3EF6B5D4.10501@aitel.hist.no>
	 <1056363509.587.13.camel@teapot.felipe-alfaro.com>
Content-Type: text/plain
Organization: 
Message-Id: <1056385266.1968.22.camel@athena.fprintf.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 23 Jun 2003 12:21:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-23 at 06:18, Felipe Alfaro Solana wrote:

> If a process has received user
> input in the past, ir's pretty probable that the process is an
> interactive one.

<snip>

> So then, why I can easily starve the X11 server (which should be marked
> interactive), Evolution or OpenOffice simply by running "while true; do
> a=2; done". Why don't they get an increased priority boost to stop the
> from behaving so jerky?

You're own metric will kill you here.  You're while true; loop is
running in the shell, which is interactive (it has accepted user in put
in the past) and can therefore easily starve anything else.  You need a
an easy way to make an interactive process non-interactive, and that's
what these threads are all about, making interactive threads
non-interactive (and the other way around) in a fashion that maximises
the user experience.  A history of user input is not necessarily a good
metric, as many non-interactive CPU hogs start out life as interactive
threads (like your loop above).
-- 
Daniel Gryniewicz <dang@fprintf.net>

