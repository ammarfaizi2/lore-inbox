Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751948AbWJMWWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbWJMWWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 18:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbWJMWWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 18:22:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52376 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751948AbWJMWWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 18:22:51 -0400
Date: Fri, 13 Oct 2006 23:22:37 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Phillip Susi <psusi@cfl.rr.com>
Cc: Alasdair G Kergon <agk@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org,
       Heinz Mauelshagen <mauelshagen@redhat.com>
Subject: Re: dm stripe: Fix bounds
Message-ID: <20061013222237.GL17654@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Phillip Susi <psusi@cfl.rr.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org,
	Heinz Mauelshagen <mauelshagen@redhat.com>
References: <20060316151114.GS4724@agk.surrey.redhat.com> <452DBE11.2000005@cfl.rr.com> <20061012135945.GV17654@agk.surrey.redhat.com> <452E5FD0.8060309@cfl.rr.com> <20061012160515.GD17654@agk.surrey.redhat.com> <452E85ED.1040409@cfl.rr.com> <20061012183529.GF17654@agk.surrey.redhat.com> <452EA9FF.2040602@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <452EA9FF.2040602@cfl.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 04:47:59PM -0400, Phillip Susi wrote:
> One stripe table can only contain one stripe size, so to have two would 
> require two tables, and a third table to tie them back together.

One device-mapper table can contain two concatenated stripe targets.

  http://people.redhat.com/agk/talks/FOSDEM_2005/text6.html
 
> The entire idea of a stripe is that you are using multiple identical 
> drives ( or partitions ), so it doesn't make any sense to be able to 
> truncate one of the drives.  

dmraid is not the only user of device-mapper striping.  Userspace volume
managers may want to use all sorts of odd layouts quite legitimately.

> In any case, this is not something you can 
> do now, 

[Actually that's what the code did before this patch:-(]

> so the fact that you could not do it then either does not seem 
> to be a good argument against allowing partial tails.
 
The arguments are (1) to avoid the ambiguity I've discussed and (2) to avoid
the additional complexity the in-kernel striped target would require
(calculating a stripe size for the end of the device to override the one
supplied), when it's so simple for userspace to specify exactly what it
requires by using two targets.

Alasdair
-- 
agk@redhat.com
