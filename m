Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265836AbUBJLps (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 06:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265839AbUBJLps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 06:45:48 -0500
Received: from ns.suse.de ([195.135.220.2]:36561 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265836AbUBJLpp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 06:45:45 -0500
Date: Tue, 10 Feb 2004 12:45:21 +0100
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: oops in old isdn4linux and 2.6.2-rc3 (was in -rc2 too)
Message-ID: <20040210114521.GA21900@pingi3.kke.suse.de>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <401E4A80.4050907@web.de> <20040202195139.GB2534@pingi3.kke.suse.de> <1076328820.11882.27.camel@imladris.demon.co.uk> <1076378022.11882.80.camel@imladris.demon.co.uk> <20040210025117.GB17364@pingi3.kke.suse.de> <1076408351.11882.101.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076408351.11882.101.camel@imladris.demon.co.uk>
User-Agent: Mutt/1.4.1i
Organization: SuSE Linux AG
X-Operating-System: Linux 2.4.21-166-default i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 10:19:11AM +0000, David Woodhouse wrote:
> On Tue, 2004-02-10 at 03:51 +0100, Karsten Keil wrote:
> > Your analyse is correct, but the error is, that
> > ll_writewakeup is called with the lock.
> > Upper layers should not be called in this path.
> 
> That's an evidently sensible answer, yes -- but it looks like it's
> always been like this, and fixing it really wasn't not a task I
> particularly wanted to undertake at 2am this morning... I think I might
> leave that to you :)

I don't want give you the impression of a "evidently sensible answer",
(maybe ist was also a little bit late or early ... :-)
I only want to point out that here is a deeper design flaw in this code
and it is here for a long time, but the old none spinlock code
with a big CLI (bad,bad,bad) make it working well enough. During
porting I saw this problem, but forget to mark it for fixing later.

These things (missing separation of layers) was one reason for me to
begin a new driver from scratch some time ago (mISDN).

-- 
Karsten Keil
SuSE Labs
ISDN development
