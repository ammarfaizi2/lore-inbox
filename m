Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268130AbUIWBq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268130AbUIWBq4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 21:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268131AbUIWBq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 21:46:56 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:3770 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S268130AbUIWBqy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 21:46:54 -0400
Subject: Re: [RFC][PATCH] inotify 0.9.2
From: Ray Lee <ray-lk@madrabbit.org>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, Edgar Toernig <froese@gmx.de>,
       Robert Love <rml@novell.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <1095820046.22558.4.camel@vertex>
References: <1095652572.23128.2.camel@vertex>
	 <1095744091.2454.56.camel@localhost>
	 <20040921173404.0b8795c9.froese@gmx.de>
	 <41504C21.3090506@nortelnetworks.com>  <1095820046.22558.4.camel@vertex>
Content-Type: text/plain
Organization: http://madrabbit.org/
Message-Id: <1095904012.11637.81.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 22 Sep 2004 18:46:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 19:27, John McCutchan wrote:
> On Tue, 2004-09-21 at 11:43, Chris Friesen wrote:
> > Edgar Toernig wrote:
> > > Robert Love wrote:
> > > 
> > >> struct inotify_event {
> > >> 	int wd;
> > >> 	int mask;
> > >>-	char filename[256];
> > >>+	char filename[PATH_MAX];
> > >> };
> > > 
> > > 
> > > You really want to shove >4kB per event to userspace???
> > 
> > Ouch.
> > 
> > Maybe make it variable-size?  On average it would likely be shorter.
> > 
> > struct inotify_event {
> > 	int wd;
> > 	int mask;
> > 	short namelen;
> > 	char filename[0];
> > };
> 
> This makes reading events from inotify a pain, first you need to read up
> to namelen, then read namelen more bytes. 
> 

Not the case. A mildly smarter userspace program would merely read
everything outstanding (or everything up to a fixed buffer length), and
then unserialize the events based on the boundaries it can figure out
from the first portion of the structure.

This is a way common technique.

At least in code I write, anyway :-).

Ray

