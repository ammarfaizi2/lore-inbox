Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030398AbWALOAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWALOAd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 09:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWALOAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 09:00:33 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:36998 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030398AbWALOAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 09:00:32 -0500
Date: Thu, 12 Jan 2006 15:00:33 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ben Collins <ben.collins@ubuntu.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
In-Reply-To: <1137072715.4254.24.camel@grayson>
Message-ID: <Pine.LNX.4.61.0601121437310.11765@scrub.home>
References: <0ISL003ZI97GCY@a34-mta01.direcway.com> <200601090109.06051.zippel@linux-m68k.org>
 <1136779153.1043.26.camel@grayson> <200601091232.56348.zippel@linux-m68k.org>
 <1136814126.1043.36.camel@grayson> <Pine.LNX.4.61.0601120019430.30994@scrub.home>
 <1137031253.9643.38.camel@grayson> <Pine.LNX.4.61.0601121155450.30994@scrub.home>
 <1137068880.4254.8.camel@grayson> <Pine.LNX.4.61.0601121342200.11765@scrub.home>
 <1137072715.4254.24.camel@grayson>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 12 Jan 2006, Ben Collins wrote:

> > > silentoldconfig tells you a lot less, agreed?
> > 
> > No.
> 
> So you are saying that silentoldconfig outputs no less information than
> oldconfig? No output compared to a full config output (yes, with some
> special cased invisible options, but the same output that a user would
> see if manually configuring).

You're seriously telling me that you check every line of the oldconfig 
output in case of the problem? 
If it makes you feel better, you can rerun oldconfig after the 
silentoldconfig, but the output is practically useless.
It would actually be a lot better if you ran a diff between the old config 
and the new config and add this to the build output, only the contents of 
the .config file is relevant to kbuild and if something went wrong, the 
real differences would be easily visible.

> My point is that you are making oldconfig and silentoldconfig operate
> differently when they encounter a closed stdin. You are making them
> inconsistent. And so far, you have yet to give a valid reason to do so.
> I've been giving very valid reasons why they should work the same, and
> why the behavior is correct for them to work that way.

Even if they sound similiar they are not the same. e.g. I'm working on 
patches to integrate split config step, so it will do a bit more than 
normal config targets (but it remain a valid make target). The 
silentoldconfig target is an automatic target which is also used by kbuild 
to verify the config consistency.
The situation is very simple, we have automatic config targets (like 
silentoldconfig or all*config) and we have interactive config targets 
(like config, xconfig, oldconfig).
I'm very much interested to improve the situation of the automatic 
targets to help automatic builds, but just printing useless information 
adds no value. If you don't trust that silentoldconfig does the right 
thing, you can't trust oldconfig either.

bye, Roman
