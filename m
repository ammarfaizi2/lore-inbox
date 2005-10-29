Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVJ2TX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVJ2TX5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 15:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVJ2TX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 15:23:57 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:29686 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932113AbVJ2TX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 15:23:56 -0400
Message-Id: <20051029191229.562454000@omelas>
Date: Sat, 29 Oct 2005 12:12:29 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, tony@atomide.com
Subject: [patch 0/5] HW RNG cleanup & new drivers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to the kernel for some more HW RNG devices
and cleans up the code a bit.  My basic goal was to keep the same
user space interface as exists, but not have to reproduce all
the same 100 lines of user space interface code across every new
driver (as we currently do with watchdogs...)

The new code separates the HW specific driver from the user 
interface code and just adds a few function pointers so that
the two can talk to each other. I opted out of using a sysfs
class and all that complication b/c there will be one and only
one RNG device at a time on a given system.

I've added drivers for Intels' IXP4xx and for the TI OMAP and
these have both been tested.

There was some discussion on lkml on the subject of killing
the in-kernel driver and moving the whole implementation to
user space but that cannot be done as some SOCs (MPC85xx for
example) have the RNG unit as part of a larger device that
needs kernel space code to manage command descriptor rings
and other such things. We also want to be able to suspend/resume
the RNG devices (see OMAP driver) and that needs to be done as part
of the kernel PM path.

Please apply,

~Deepak

--
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

Even a stopped clock gives the right time twice a day.
