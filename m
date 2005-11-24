Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbVKXN5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbVKXN5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 08:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbVKXN5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 08:57:13 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:22675 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750856AbVKXN5C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 08:57:02 -0500
Date: Thu, 24 Nov 2005 14:56:48 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Rob Landley <rob@landley.net>
cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] make miniconfig (take 2)
In-Reply-To: <200511211006.48289.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0511241212030.1609@scrub.home>
References: <200511170629.42389.rob@landley.net> <Pine.LNX.4.61.0511192338300.1609@scrub.home>
 <200511210015.21269.rob@landley.net> <200511211006.48289.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.61.0511241413061.1609@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 21 Nov 2005, Rob Landley wrote:

> Add "make miniconfig", plus documentation, plus the script that creates a
> minimal mini.config from a normal .config file.

The difference between miniconfig and allnoconfig is IMO too small to be 
really worth it right now.

If we go that path, this functionality should be integrated properly.
What I have in mind is to create a new config file with a bit different 
format, which is only read by kconfig. This one can also have a switch 
"only save the minimum". The important part is that if this file exists, 
all kconfig front ends will use it and keep it properly uptodate.

'make miniconfig' would then simply convert the current config to a 
minimized version. One problem I see with this how kconfig should behave, 
when it's thrown into a new kernel release. Setting everything else to 'n' 
is one possibility, but sometimes such options as CONFIG_SWAP are added, 
which one certainly wants enabled. Using the defaults would be a 
possibility, but they are currently massively abused (and I'll probably 
soon start a cleanup of them).

> 1) Documentation.

This is of course always nice, but it would be even better, if it also 
included information about the other config targets, even it's mostly a 
place holder.

bye, Roman
