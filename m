Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbVK0XVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbVK0XVN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 18:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbVK0XVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 18:21:13 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:51634 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751171AbVK0XVM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 18:21:12 -0500
Date: Mon, 28 Nov 2005 00:20:58 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Rob Landley <rob@landley.net>
cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] make miniconfig (take 2)
In-Reply-To: <200511251512.20330.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0511271841320.1610@scrub.home>
References: <200511170629.42389.rob@landley.net> <200511241145.24037.rob@landley.net>
 <Pine.LNX.4.61.0511250022330.1609@scrub.home> <200511251512.20330.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 25 Nov 2005, Rob Landley wrote:

> Ok, what's the best thing I can do to help get this implemented, working 
> _with_ you rather than against?

It's not exactly simple, as it requires some kconfig hacking.
Something relatively simply would be to change the miniconfig.sh script 
into a C program, where it would have to access to all the information to 
do the job fast and correctly.
I think it can even be done in a single pass over all the symbols, where 
boolean/tristate symbols are checked if they are already at the minimum 
value and string/hex/int values are compared with their default values.
Next step could be to add a variation of allnoconfig with better error 
checking (e.g. checking that all requested symbols have been set), the 
basic allnoconfig functionality is just a few lines of code, the fun is 
in the extras.

To further reduce the config size one could look at the dependecies, e.g.:

config FOO
	depends on BAR && BAZ1 || BAZ2

In this case FOO could also set BAR, but not BAZ1/BAZ2.
But this also requires a new frontend to read such a minimized config 
file and is quite a bit more complex.

bye, Roman
