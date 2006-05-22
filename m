Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWEVWWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWEVWWh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 18:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbWEVWWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 18:22:37 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:56042 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id S1751273AbWEVWWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 18:22:37 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: tuning for large files in xfs
Date: Mon, 22 May 2006 22:22:35 +0000 (UTC)
Organization: Cistron
Message-ID: <e4tdjb$h5h$1@news.cistron.nl>
References: <447209A8.2040704@iparadigms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1148336555 17585 194.109.0.112 (22 May 2006 22:22:35 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@n2o.xs4all.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <447209A8.2040704@iparadigms.com>,
fitzboy  <fitzboy@iparadigms.com> wrote:
>I've got a very large (2TB) proprietary database that is kept on an XFS
>partition

Ehh.. partition ? Let me tell you about a very common mistake:

>under a debian 2.6.8 kernel. It seemed to work well, until I
>recently did some of my own tests and found that the performance should
>be better then it is...
>
>basically, treat the database as just a bunch of random seeks. The XFS
>partition is sitting on top of a SCSI array (Dell PowerVault) which has
>13+1 disks in a RAID5, stripe size=64k. I have done a number of tests
>that mimic my app's accesses and realized that I want the inode to be
>as large as possible (which in an intel box is only 2k), played with su
>and sw and got those to 64k and 13... and performance got better.

If your RAID has 64K stripes, and the XFS partition is also tuned
for 64K, you expect those two to match, right ? But I bet the start
of the partition isn't aligned to a multiple of 64K..

In those cases I just use the whole disk instead of a partition,
or I dump the partition table with sfdisk, move the start of the
partition I'm using to a multiple of X, and re-read it. You need
to re-mkfs the fs though.

Not sure if it has any impact in your case, just thought I'd mention it.

Mike.

