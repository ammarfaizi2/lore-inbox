Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTIOWkX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 18:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbTIOWkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 18:40:23 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:47883 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261684AbTIOWkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 18:40:17 -0400
Date: Tue, 16 Sep 2003 00:40:09 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Tom Rini <trini@kernel.crashing.org>
cc: Norman Diamond <ndiamond@wta.att.ne.jp>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.6.0-test5: serio config broken?
In-Reply-To: <20030915212015.GA9102@ip68-0-152-218.tc.ph.cox.net>
Message-ID: <Pine.LNX.4.44.0309160003290.19512-100000@serv>
References: <1aba01c379d0$4d061ab0$2dee4ca5@DIAMONDLX60>
 <20030915144939.GA29517@ip68-0-152-218.tc.ph.cox.net>
 <Pine.LNX.4.44.0309152136110.19512-100000@serv> <20030915212015.GA9102@ip68-0-152-218.tc.ph.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 15 Sep 2003, Tom Rini wrote:

> > You have to define what "inconsistency" means, right now the kconfig 
> > design makes ambigous configurations impossible (provided that there are 
> > no recursive dependencies, which kconfig warns about). I have no plans to 
> > give up this property, as it keeps kconfig reasonably simple, it's already 
> > complex enough as is.
> 
> So long as it doesn't involve 'select', it won't let you be
> inconsistent, yes.

No, this is even true with the current select.

>  How exactly are items that come in from a select
> evaluated right now?

'select' adds a reverse dependency to the selected option, e.g.

config FOO
	select BAR if BAZ

BAR has now a reverse dependency of "FOO && BAZ" and the value of BAR is 
calculated as "(user value && visibility) || reverse dependency" 
(visibility is the dependencies of all BAR prompts). The details are in 
symbol.c:sym_calc_value().
This allows to calculate the configuration in a single pass and as a side 
effect avoids inconsistencies.

bye, Roman

