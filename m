Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263612AbUEKUdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263612AbUEKUdo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263609AbUEKUdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:33:44 -0400
Received: from d64-180-152-77.bchsia.telus.net ([64.180.152.77]:36878 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S263632AbUEKUdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:33:13 -0400
Date: Tue, 11 May 2004 13:28:12 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
Message-ID: <20040511202812.GA5737@net-ronin.org>
References: <1084152941.22837.21.camel@vertex> <20040510021141.GA10760@taniwha.stupidest.org> <1084227460.28663.8.camel@vertex> <20040511024701.GA19489@taniwha.stupidest.org> <1084278001.1225.9.camel@vertex> <20040511124647.GE17014@parcelfarce.linux.theplanet.co.uk> <20040511190228.GA12609@tentacle.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040511190228.GA12609@tentacle.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2004 at 03:02:31PM -0400, John McCutchan wrote:
> >From a quick glance at someone elses implementation of it, I plan on
> walking up the dentries and checking at each level if a watcher on that
> level is interested in events from subdirectories. Is this good practice in
> the kernel?

Curious, why is it being implemented in this fashion instead of broadcasting
it over a netlink socket?

That way, the user-space listeners can determine whether they want to pay
attention to it or not, and figure out for themselves most of the "do I
care about this event" issue.

As for the directory heirarchy watching, does that mean the user can do:
<process 1>   <process 2>
              while : ; do mkdir a ; cd a ; done
    .... wait 10 seconds ....
listen to a/

What's the kernel going to do then?  Hopefully, you don't mean you'll
be crawling down the entire chain each and every time...

Just random thoughts.

-- DN
Daniel
