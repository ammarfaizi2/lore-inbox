Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265079AbUETLhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265079AbUETLhh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 07:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265091AbUETLhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 07:37:36 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:47054 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S265079AbUETLhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 07:37:35 -0400
Date: Thu, 20 May 2004 12:37:33 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Calculating cumulative stack usage
Message-ID: <Pine.LNX.4.58.0405201228400.16822@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not on the list at the moment or following the issues except on rare
occasions. I saw on LWN though that people were looking for an automatic
way of calculating cumulative stack usage. Codeviz
(http://www.csn.ul.ie/~mel/projects/codeviz) is able to do something like
this.

Without going into it in a lot of detail, it's a two stage process. Stack
usage is calculated at the same time as generating the call graph with
something like

genfull --pp-stack

Then to generate a call graph with cumulative usage, it would be something
like

gengraph -f somefunc
--pp-cstack="showcumulative=somefunc-someotherfunc,largeusage=3182"

This would generate a callgraph (in postscript) that showed the cumulative
usage in the bubbles between somefunc() and someotherfunc(). It had to be
between two functions because there was no easy way to calculate all
paths.

This would be a fairly manual process though and you would need to have an
idea of where large usage paths might be. However, as the amount of stack
every function uses is in the full.graph file, it would be possible to
identify canditates.

The documentation on how to do this is virtually non-existant because I
did not think there would be users of it but it can be written up.

-- 
Mel Gorman
