Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267638AbUIVCCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267638AbUIVCCk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 22:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267646AbUIVCCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 22:02:40 -0400
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:48260 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S267638AbUIVCCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 22:02:38 -0400
Subject: Re: [RFC][PATCH] inotify 0.9.2
From: John McCutchan <ttb@tentacle.dhs.org>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Edgar Toernig <froese@gmx.de>, Robert Love <rml@novell.com>,
       linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
In-Reply-To: <41504C21.3090506@nortelnetworks.com>
References: <1095652572.23128.2.camel@vertex>
	 <1095744091.2454.56.camel@localhost>
	 <20040921173404.0b8795c9.froese@gmx.de>
	 <41504C21.3090506@nortelnetworks.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095820046.22558.4.camel@vertex>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 21 Sep 2004 22:27:26 -0400
X-PMX-Version-Mac: 4.7.0.111621, Antispam-Engine: 2.0.0.0, Antispam-Data: 2004.9.21.5
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 11:43, Chris Friesen wrote:
> Edgar Toernig wrote:
> > Robert Love wrote:
> > 
> >> struct inotify_event {
> >> 	int wd;
> >> 	int mask;
> >>-	char filename[256];
> >>+	char filename[PATH_MAX];
> >> };
> > 
> > 
> > You really want to shove >4kB per event to userspace???
> 
> Ouch.
> 
> Maybe make it variable-size?  On average it would likely be shorter.
> 
> struct inotify_event {
> 	int wd;
> 	int mask;
> 	short namelen;
> 	char filename[0];
> };

This makes reading events from inotify a pain, first you need to read up
to namelen, then read namelen more bytes. 

John

