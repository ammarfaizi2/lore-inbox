Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264899AbTFQTrH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 15:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264909AbTFQTrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 15:47:07 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:2357 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264899AbTFQTrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 15:47:05 -0400
Date: Tue, 17 Jun 2003 13:01:42 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: roy@karlsbakk.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O_DIRECT for ext3 (2.4.21)
Message-Id: <20030617130142.50775749.akpm@digeo.com>
In-Reply-To: <1055861357.4240.11.camel@sisko.scot.redhat.com>
References: <20030615110106.GA8404@karlsbakk.net>
	<1055861357.4240.11.camel@sisko.scot.redhat.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jun 2003 20:01:00.0621 (UTC) FILETIME=[2CA1A7D0:01C3350B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" <sct@redhat.com> wrote:
>
> Hi,
> 
> On Sun, 2003-06-15 at 12:01, Roy Sigurd Karlsbakk wrote:
> > hi all
> > 
> > I've been waiting for the official O_DIRECT on ext3 for some time now, so I
> > thought perhaps it's time to get it into 2.4.22 or so. The patch I've used, is
> > the one below (for 2.4.21):
> 
> This is Andrea's patch,

Actually I'm the culprit.

> (like allowing direct IO in journaled data mode --- bad move ---

hmm, OK, it doesn't even vaguely work in journalled mode either...

I think the check should be implemented in (the new) ext3_open().  Because
checking the return from open() is the way in which a good application would
determine whether the underlying fs supports O_DIRECT.

Unfortunately O_DIRECT can also be set with fcntl(F_SETFL), and we seem to
have forgotten to provide a way for the fs to be told about fcntl.


