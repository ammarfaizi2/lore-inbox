Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbTGHK3e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 06:29:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265648AbTGHK3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 06:29:34 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:19078 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S264647AbTGHK3d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 06:29:33 -0400
Date: Tue, 8 Jul 2003 12:43:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Must-fix cursor bugs
Message-ID: <20030708104319.GA134@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There are few must-fix bugs in cursor handling:

echo -e '\33[?8c'

...should turn block cursor on on current console. It does so, but if
you switch to another console, block cursor appears there too, and/or
it reverts to line cursor on original console.

echo -e "\33[?18;0;136c" 

...should turn on softcursor (see
Documentation/VGA-softcursor.txt). It does turn it on, but it fails to
erase it once cursor moves! [Type foo in bash, then press backspace
three times].

Play with gpm selection for a while and your cursor gets corrupted
with random dots. Ouch.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
