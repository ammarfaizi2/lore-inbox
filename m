Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTJADWq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 23:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTJADWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 23:22:46 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:17876 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id S261885AbTJADWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 23:22:45 -0400
Date: Tue, 30 Sep 2003 23:22:38 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test6 scheduling(?) oddness
Message-ID: <20031001032238.GB1416@Master>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P4 2G
1G PC2700 RAM
ASUS P4S533 

Large tasks (like raytrace rendering) take double the amount of time they used
to take, although the system is nicer to the user while they run. In 
2.6.0-test5 had a little trouble with it and Piggin pointed me to a patch that
fixed it and is now in -test6, however the patch didn't slow the rendering as
much as it does in test6. (Con Koliva's patch, I believe it was).
For example - rendering an image that took 15 minutes in 2.5.65 takes 20 
minutes in 2.6.0-test5 (with patch) and 30 minutes in 2.6.0-test6 (raw from
kernel.org). Same config options (everything I use builtin - no modules).

A new issue (which also doesn't happen in -test5 with the patch):
When running cpu intense tasks, new (large) tasks will not start till the first
one finishes.
For example, using POV-Ray 3.5 to render an image that takes 30 minutes when it
is the only program running, start oowriter.
The render finishes in the same 30 minutes, then oowriter starts.
oowriter takes about 3 seconds to load if no rendering is going on.
I can use apps that are already open but can't start new ones while rendering.
In 2.6.0-test5 (with patch) opening oowriter while rendering takes about 1 
minute.
In 2.5.65 opening oowriter while rendering takes about 2 minutes (and X gets
very hard to use till oowriter is completely done opening).

-- 
Murray J. Root

