Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbWFZMhj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbWFZMhj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 08:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWFZMhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 08:37:39 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:5353 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751074AbWFZMhi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 08:37:38 -0400
Date: Mon, 26 Jun 2006 14:37:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@ftp.linux.org.uk>
cc: Sam Ravnborg <sam@ravnborg.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Section mismatch warnings
In-Reply-To: <20060623222346.GC27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0606261425340.17704@scrub.home>
References: <Pine.LNX.4.61.0606231938080.26864@yvahk01.tjqt.qr>
 <20060623221217.GA372@mars.ravnborg.org> <20060623222346.GC27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 23 Jun 2006, Al Viro wrote:

> On Sat, Jun 24, 2006 at 12:12:18AM +0200, Sam Ravnborg wrote:
> > All the .smp_locks related warnings are gone when I get the kbuild.git
> > tree pushed linus wise. Needs to spend only an hour or so before it is
> > ready and will do so during the weekend.
> 
> Another fun toy that might be interesting there:
> 
> >From nobody Mon Sep 17 00:00:00 2001
> From: Al Viro <viro@zeniv.linux.org.uk>
> Date: Fri, 26 May 2006 08:35:22 -0400
> Subject: [PATCH] add make listconfig (show all kconfig symbols seen by parser)

I don't mind the functionality, but what I'd like to avoid is adding lots 
of little config targets, so what I'd like to add is something more like 
'make queryconfig', which maybe even could be extended to some simple 
scripting functionality.

> +static void list_symbols(struct menu *m)
> +{
> +	for (m = m->list; m; m = m->next) {
> +		struct symbol *s = m->sym;
> +		if (s && !sym_is_choice(s)) {

for_all_symbols() would be simpler and avoids possible duplicate menu 
entries and I think it's better to just test for s->name.

bye, Roman
