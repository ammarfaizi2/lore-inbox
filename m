Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262052AbSIYVWr>; Wed, 25 Sep 2002 17:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262065AbSIYVWr>; Wed, 25 Sep 2002 17:22:47 -0400
Received: from mailf.telia.com ([194.22.194.25]:61407 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S262052AbSIYVWq>;
	Wed, 25 Sep 2002 17:22:46 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Adam Goldstein <Whitewlf@Whitewlf.net>
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
Date: Wed, 25 Sep 2002 23:26:10 +0200
User-Agent: KMail/1.4.7
Cc: =?utf-8?q?Pawe=C5=82=20Krawczyk?= <kravietz@aba.krakow.pl>,
       Simon Kirby <sim@netnation.com>, Adam Taylor <iris@servercity.com>,
       linux-kernel@vger.kernel.org, Sebastian Benoit <benoit-lists@fb12.de>
References: <B7E52DA4-D0C3-11D6-8C5C-000502C90EA3@Whitewlf.net>
In-Reply-To: <B7E52DA4-D0C3-11D6-8C5C-000502C90EA3@Whitewlf.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200209252326.10617.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The big question is - why that much CPU usage?

Possible answers:
* PHP, mySQL, Apache - needs that amount of CPU to perform the requested 
function.
(you have got suggestions from others)

* The implementation if either has bugs that cause the CPU usage. Garbage 
collection? Ineffective algorithms?
- Not much to do other than collecting execution profiles, quite advanced - 
recompiling of the tools will probably be needed... And probably help from 
the tools developers...

* The implementation of the user code has bugs that cause the CPU usage.
One example:
SQL SELECT with unindexed data - this can usually be noticed as buffer in load 
in vmstat but since all data fits in memory - it would cause scans in memory, 
with lots of RAM cache misses... And it would work well as long as the 
scanned data was smaller than the CPU cache?
- Suggestion: Review your index keys and select statements to make sure that 
they match!

/RogerL
