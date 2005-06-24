Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263007AbVFXCeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbVFXCeO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 22:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263008AbVFXCeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 22:34:14 -0400
Received: from web30705.mail.mud.yahoo.com ([68.142.200.138]:33170 "HELO
	web30705.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S263007AbVFXCeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 22:34:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=tgjBEZi27ezYyuVOJeiplFDFpnkYP0KUYhDa+QEKfLsjrJ5lRw9CpSiuZindYU0e5+nq4ll2yjU/4NQeip0jW/FbgRIMxYUJt1DliD0FeC8eeT6FGisVHiCGTvuGxI6yKbtAdZKklvw+TOgIlmoYp+PhkRil9UwNH7A0pPe3fzM=  ;
Message-ID: <20050624023356.63888.qmail@web30705.mail.mud.yahoo.com>
Date: Thu, 23 Jun 2005 19:33:56 -0700 (PDT)
From: <spaminos-ker@yahoo.com>
Reply-To: spaminos-ker@yahoo.com
Subject: Re: cfq misbehaving on 2.6.11-1.14_FC3
To: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200506240933.55951.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Con Kolivas <kernel@kolivas.org> wrote:
> I found the same, and the effect was blunted by noatime and 
> journal_data_writeback (on ext3). Try them one at a time and see what you 
> get.

I had to move to a different box, but get the same kind of results (for ext3
default mount options).

Here are the latencies (all cfq) I get with different values for the mount
parameters

ext2 default
0.1s

ext3 default
52.6s avg

reiser defaults
29s avg 5 minutes
then, 
12.9s avg

ext3 rw,noatime,data=writeback
0.1s avg

reiser rw,noatime,data=writeback
4s avg for 20 seconds
then 0.1 seconds avg


So, indeed adding noatime,data=writeback to the mount options improves things a
lot.
I also tried without the noatime, and that doesn't make much difference to me.

That looks like a good workaround, I'll now try with the actual server and see
how things go.

Nicolas

