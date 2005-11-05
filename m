Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbVKETGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVKETGT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 14:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbVKETGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 14:06:19 -0500
Received: from postel.suug.ch ([195.134.158.23]:51368 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S932289AbVKETGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 14:06:17 -0500
Date: Sat, 5 Nov 2005 20:06:36 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Patrick McHardy <kaber@trash.net>,
       Brian Pomerantz <bapper@piratehaven.org>, netdev@vger.kernel.org,
       davem@davemloft.net, pekkas@netcore.fi, jmorris@namei.org,
       yoshfuji@linux-ipv6.org, kaber@coreworks.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [IPV4] Fix secondary IP addresses after promotion
Message-ID: <20051105190636.GU23537@postel.suug.ch>
References: <20051104184633.GA16256@skull.piratehaven.org> <436BFE08.6030906@trash.net> <20051105010740.GR23537@postel.suug.ch> <20051105183910.GA17215@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105183910.GA17215@ms2.inr.ac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Local routes for 10.0.0.3 and 10.0.0.4 have disappeared _without_
> > any notification.
> 
> Flushes do not generate notifications. The reason is technical: they
> are usually massive, do overflow buffer, get lost and listeners have
> to do painful resynchronization. The justification: they are useless
> because these events are derived.

I perfectly agree, still I'm not happy with deleting the local routes
for the temporarly orphaned secondaries without notifications and
just re-add them again later.

I think we should either prevent the deletion of the local routes by
rewriting their preferred source address during promotion or explicitely
announce the temprary orphaned secondaries as down and up again in order
to have the local routes deleted/re-added in a clean way.
