Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268231AbUIWDm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268231AbUIWDm0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 23:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268235AbUIWDmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 23:42:25 -0400
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:52118 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S268231AbUIWDmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 23:42:23 -0400
Subject: Re: [RFC][PATCH] inotify 0.9.2
From: John McCutchan <ttb@tentacle.dhs.org>
To: Ray Lee <ray-lk@madrabbit.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, Edgar Toernig <froese@gmx.de>,
       Robert Love <rml@novell.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <1095904012.11637.81.camel@orca.madrabbit.org>
References: <1095652572.23128.2.camel@vertex>
	 <1095744091.2454.56.camel@localhost>
	 <20040921173404.0b8795c9.froese@gmx.de>
	 <41504C21.3090506@nortelnetworks.com>  <1095820046.22558.4.camel@vertex>
	 <1095904012.11637.81.camel@orca.madrabbit.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095910956.9652.2.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 22 Sep 2004 23:42:36 -0400
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.0.0, Antispam-Data: 2004.9.22.4
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-22 at 21:46, Ray Lee wrote:
> On Tue, 2004-09-21 at 19:27, John McCutchan wrote:
> > On Tue, 2004-09-21 at 11:43, Chris Friesen wrote:
> > > Edgar Toernig wrote:
> > > > Robert Love wrote:
> > > > 
> > > >> struct inotify_event {
> > > >> 	int wd;
> > > >> 	int mask;
> > > >>-	char filename[256];
> > > >>+	char filename[PATH_MAX];
> > > >> };
> > > > 
> > > > 
> > > > You really want to shove >4kB per event to userspace???
> > > 
> > > Ouch.
> > > 
> > > Maybe make it variable-size?  On average it would likely be shorter.
> > > 
> > > struct inotify_event {
> > > 	int wd;
> > > 	int mask;
> > > 	short namelen;
> > > 	char filename[0];
> > > };
> > 
> > This makes reading events from inotify a pain, first you need to read up
> > to namelen, then read namelen more bytes. 
> > 
> 
> Not the case. A mildly smarter userspace program would merely read
> everything outstanding (or everything up to a fixed buffer length), and
> then unserialize the events based on the boundaries it can figure out
> from the first portion of the structure.
> 
> This is a way common technique.
> 
> At least in code I write, anyway :-).

Of course this is possible, but the inotify kernel driver only allows userspace 
program to read in event sized chunks (So that the event queue
handling is kept simple)

John
