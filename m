Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUHHB5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUHHB5G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 21:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbUHHB5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 21:57:06 -0400
Received: from c66-235-4-168.sea2.cablespeed.com ([66.235.4.168]:17132 "EHLO
	darklands.zimres.net") by vger.kernel.org with ESMTP
	id S264919AbUHHB5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 21:57:04 -0400
Date: Sat, 7 Aug 2004 18:54:58 -0700
From: Thomas Zimmerman <thomas@zimres.net>
To: linux-kernel@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>, Buddy Lumpkin <b.lumpkin@comcast.net>
Subject: Re: EXT intent logging
Message-ID: <20040808015458.GA11279@darklands>
Reply-To: Thomas <thomas@zimres.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>, Buddy Lumpkin <b.lumpkin@comcast.net>
References: <S268081AbUHFEzL/20040806045511Z+197@vger.kernel.org> <20040806195615.GA14163@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806195615.GA14163@thunk.org>
X-Operating-System: Linux darklands 2.6.8-rc1-ck5-amd64
X-Operating-Status: 19:39:30 up  1:21,  4 users,  load average: 0.33, 0.24, 0.22
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-Aug 03:56, Theodore Ts'o wrote:
> "mount -o data=journal" logs metadata blocks and data blocks into
> journal first, and then after the transaction commits, the metadata
> and data blocks are written to their final location on disk.  The
> problem with this is that all your write bandwidth is cut in half
> since all block writes get written twice to disk --- once to the
> journal, and once to the final location on disk.

While you do half your write bandwidth, there arn't any _seeks_ while
writing to the journal. For IO workloads where a sync allows you to
move on to another job, this can speed up your workload. Mail delivery
on an old laptop disk was ~2 as fast using ext3 data=journal...

Thomas
