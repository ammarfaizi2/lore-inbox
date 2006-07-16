Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWGPUN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWGPUN3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 16:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWGPUN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 16:13:29 -0400
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:1976 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932075AbWGPUN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 16:13:28 -0400
Date: Sun, 16 Jul 2006 16:08:25 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: raid io requests not parallel?
To: "Jonathan Baccash" <jbaccash@gmail.com>
Cc: Ava Kivity <avi@argo.co.il>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607161609_MC3-1-C52A-F449@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <e0e4cb3e0607160938k70819e40g4172f5917045ebf8@mail.gmail.com>

On Sun, 16 Jul 2006 09:38:25 -0700, Jonathan Baccash wrote:

> > Each head has to service 1024 write requests (compared to just 512 read
> > requests).
>
> By that logic, it would take twice as long for my writes to finish.
> Why is it taking 4x as long in my parallel test?

Because a single read not only goes to just one disk, it is sent to
the disk with the lowest expected seek time for that request.  This
cuts average read time in half, on average.

(See drivers/md/raid1.c::read_balance().)

> I would expect a raid-1 write
> to take about as long to write a single block as a single write to a
> single disk (assuming no other disk activity), because I would expect
> two writes to happen concurrently.

You didn't post any benchmarks showing results for single write to a
single disk.

-- 
Chuck
 Think. Or you will be replaced with a small shell script.  --dwmw2
