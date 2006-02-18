Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWBRSzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWBRSzR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 13:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWBRSzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 13:55:17 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:49630 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932120AbWBRSzP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 13:55:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uHkInEP1NlMeM/bmXxBngPJbJ4saJMylJhI9ndZeeUmnxLHuiLs4cLHU8f/C/hZnGDITTiybUXfLFXvIAKo+iXOhsjMlwCGy0gpDKbc16z7Mr32vbXXSeua+i1F54DhM+rB4lG5NmyYixsAcEVWHPxWT2cE+wPqZmTtNuzhgaX8=
Message-ID: <a36005b50602181055n454c446aoed83ea21baaf1a67@mail.gmail.com>
Date: Sat, 18 Feb 2006 10:55:14 -0800
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Bernd Eckenfels" <be-news06@lina.inka.de>
Subject: Re: How to find the CPU usage of a process
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E1FAX4Z-0000zv-00@calista.inka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060218174209.4376.qmail@web32607.mail.mud.yahoo.com>
	 <E1FAX4Z-0000zv-00@calista.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/06, Bernd Eckenfels <be-news06@lina.inka.de> wrote:
> You can use the result wof wait3(2) if you are the parent:
> [...]

That's after the fact.  Programs which want to get the information
while running can use the CPU clocks:

  struct timespec ts;
  if (clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &ts) != 0)
    fatal("cannot get CPU time");
  /* result is in TS */

It's also possible to get a thread's CPU consumption.  Use
CLOCK_THREAD_CPUTIME_ID in that case.

All this works as it should ever since Roland's clock patches landed,
in early 2.6 kernels.  Before that the time returned did not discount
the time the process wasn't scheduled.
