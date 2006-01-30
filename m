Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964822AbWA3VtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWA3VtO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 16:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965025AbWA3VtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 16:49:13 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:32526 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S964822AbWA3VtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 16:49:12 -0500
Date: Mon, 30 Jan 2006 22:49:08 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] consolidate command line escaping
Message-ID: <20060130214908.GA28626@mars.ravnborg.org>
References: <43DDE4AB.76F0.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DDE4AB.76F0.0078.0@novell.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 10:04:27AM +0100, Jan Beulich wrote:
> From: Jan Beulich <jbeulich@novell.com>
> 
> While the recent change to also escape # symbols when storing C-file
> compilation command lines was helpful, it should be in effect for all
> command lines, as much as the dollar escaping should be in effect for
> C-source compilation commands. Additionally, for better readability and
> maintenance, consolidating all the escaping (single quotes, dollars,
> and now sharps) was also desirable.

Very nice paths - thanks!
I have applied it locally and will commit if it when testing a bit more.

> -cmd = @$(if $($(quiet)cmd_$(1)),\
> -      echo '  $(call escsq,$($(quiet)cmd_$(1)))' &&) $(cmd_$(1))
> +cmd = @$(echo-cmd) $(cmd_$(1))
Here you replace 
	echo 'xxx' && cmd
with
	echo 'xxx'; cmd

Since we assume echo will always succeed I see no difference in
behaviour, but I recall the '&&' was there for some specific reason.
Just wondering why it is so - I see no problems with it.

	Sam
