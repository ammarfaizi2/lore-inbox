Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754176AbWKGKXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbWKGKXP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 05:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754186AbWKGKXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 05:23:15 -0500
Received: from ns.firmix.at ([62.141.48.66]:44201 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1754176AbWKGKXO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 05:23:14 -0500
Subject: Re: UNIX domain socket problem
From: Bernd Petrovitsch <bernd@firmix.at>
To: Bin Chen <binary.chen@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <454fe59b.6455ade0.6506.1f45@mx.google.com>
References: <454fe59b.6455ade0.6506.1f45@mx.google.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 07 Nov 2006 11:23:08 +0100
Message-Id: <1162894988.19866.19.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.402 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 09:47 +0800, Bin Chen wrote:
> Sorry for cross post, it has been posted on
> comp.os.linux.development.apps.
> 
> I wrote a domain socket sever, which is a STREAM type, let it listen a
> sun_path, and in a while loop it accept new connections. I analyze it
> using netstat.
> 
> Abstractly, the communication need two end. Even the listen socket is
> only one, each time the accept returns, there should be two end
> produced: one by connect() issued by client, one by accept() issued by
> server. These two should have different inode number.

Why should they?
The filename (actually and more to the point: the i-node) in the
filesystem is just an "anchor" so that the clients can find the server
(if you have several servers on your system, they *must* have different
filenames to bind(2) to).

> What is strange is that I sometimes find the RefCnt of some unix domain
> socket have values 2,3,4,5,6,7 or even 258, if each connection in
> stream should be in pair, why this problem occurs?

Probably (because I didn't look at source code) because every connect(2)
and/or accept(2) sys-call increments it.
And BTW I assume that you meand the in memory ref count, not the one in
the inode on the disk (which is incremented with hardlinks).

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

