Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVDYUTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVDYUTQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 16:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbVDYUQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 16:16:56 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:26051 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S262785AbVDYUPg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 16:15:36 -0400
Date: Tue, 26 Apr 2005 00:15:00 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, sensors@stimpy.netroedge.com,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Message-ID: <20050426001500.6a199399@zanzibar.2ka.mipt.ru>
In-Reply-To: <d120d50005042509326241a302@mail.gmail.com>
References: <200504210207.02421.dtor_core@ameritech.net>
	<1114089504.29655.93.camel@uganda>
	<d120d50005042107314cbacdea@mail.gmail.com>
	<1114420131.8527.52.camel@uganda>
	<d120d50005042509326241a302@mail.gmail.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [194.85.82.65]); Tue, 26 Apr 2005 00:15:12 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While thinking about locking schema
with respect to sysfs files I recalled,
why I implemented such a logic - 
now one can _always_ remove _any_ module
[corresponding object is removed from accessible
pathes and waits untill all exsting users are gone],
which is very good - I really like it in networking model,
while with whole device driver model
if we will read device's file very quickly
in several threads we may end up not unloading it at all.

So decision is simple from the first point of view -
just remove appropriate objects from accessible pathes
and free them from finall callbacks [device's remove method].

	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
