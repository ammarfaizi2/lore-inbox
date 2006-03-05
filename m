Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752280AbWCEXlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbWCEXlu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752281AbWCEXlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:41:50 -0500
Received: from mraos.ra.phy.cam.ac.uk ([131.111.48.8]:21725 "EHLO
	mraos.ra.phy.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1752277AbWCEXlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:41:50 -0500
To: jonathan@jonmasters.org
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [OT] inotify hack for locate
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com>
From: Chris Ball <cjb@mrao.cam.ac.uk>
Date: Sun, 05 Mar 2006 23:41:49 +0000
In-Reply-To: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com> (Jon
 Masters's message of "Sun, 5 Mar 2006 21:36:19 +0000")
Message-ID: <yd3bqwkbgsi.fsf@islay.ra.phy.cam.ac.uk>
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> On 5 Mar 2006 21:36:19, Jon Masters <jonmasters@gmail.com> said:

   > I'm fed up with those finds running whenever I power on. Has
   > anyone written an equivalent of the Microsoft indexing service to
   > update locate's database?

I think the reason this hasn't been done is that inotify_add_watch()es
are non-recursive:  you'd need a watch over every directory, and you'd 
need a crawling step (churn, churn) to enumerate the directories to
add watches for.

Beagle (which only indexes home directories, by default) uses an 
algorithm for placing watches as it crawls, such that by the end 
of the crawl you can guarantee not to have a lost a race on new 
directories being created while the crawl was happening:

http://mail.gnome.org/archives/dashboard-hackers/2004-October/msg00022.html

- Chris.
-- 
Chris Ball   <cjb@mrao.cam.ac.uk>    <http://www.mrao.cam.ac.uk/~cjb/>

