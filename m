Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbTAREwK>; Fri, 17 Jan 2003 23:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262420AbTAREwK>; Fri, 17 Jan 2003 23:52:10 -0500
Received: from packet.digeo.com ([12.110.80.53]:40583 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262418AbTAREwJ>;
	Fri, 17 Jan 2003 23:52:09 -0500
Date: Fri, 17 Jan 2003 21:02:21 -0800
From: Andrew Morton <akpm@digeo.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: Is the BitKeeper network protocol documented?
Message-Id: <20030117210221.17ce1054.akpm@digeo.com>
In-Reply-To: <20030118043309.GA18658@bjl1.asuk.net>
References: <20030118043309.GA18658@bjl1.asuk.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jan 2003 05:00:57.0460 (UTC) FILETIME=[9646BB40:01C2BEAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> wrote:
>
> Thus far, the best solution I have for tracking checkins is to rsync
> the SCCS files from Rik's mirror, and use a Perl script to extract the
> head version from each SCCS file.

Do you not use

	http://www.kernel.org/pub/linux/kernel/v2.5/testing/cset/

?

It always has the latest diff against the last-released kernel.

I snarf it hourly, so I have decent granularity for doing the
binary-search-to-see-where-it-broke trick.


#!/bin/sh

URL=ftp://ftp.kernel.org/pub/linux/kernel/v2.5/testing/cset/

cd /opt/downloads/bk
rm -f index.html
wget --quiet $URL/index.html
VERSION=$(grep 'patches since' index.html | \
		head -1 | \
		sed -e 's/.*since \([^:]*\).*/\1/')
mkdir -p $VERSION
cd $VERSION
wget --quiet --timestamping --recursive $URL 2>&1
