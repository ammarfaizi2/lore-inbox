Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWFRLbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWFRLbc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 07:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWFRLbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 07:31:32 -0400
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:45660 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751149AbWFRLbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 07:31:31 -0400
Subject: Re: [ck] [ckpatch][8/29] track_mutexes-1.patch
From: Juho Saarikko <juhos@mbnet.fi>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux list <linux-kernel@vger.kernel.org>, ck list <ck@vds.kolivas.org>
In-Reply-To: <200606181731.14664.kernel@kolivas.org>
References: <200606181731.14664.kernel@kolivas.org>
Content-Type: text/plain
Organization: 
Message-Id: <1150630103.9668.4.camel@a88-112-69-25.elisa-laajakaista.fi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 18 Jun 2006 14:28:23 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-18 at 10:31, Con Kolivas wrote:
> Keep a record of how many mutexes are held by any task. This allows cpu
> scheduler code to use this information in decision making for tasks that
> hold contended resources.

So, if I'm an userspace application trying to overcome nice or
scheduling class limitations, I can simply create a lot of mutexes, lock
them all, and get better scheduling ?-)

A better way would be to track what task holds what mutex, and when some
task tries to lock an already locked one, temporarily elevate the task
holding the mutex to the priority of the highest priority task blocking
on it (if higher than what the holding task already has, of course).
Then return the task to normal when it unlocks the mutex.

This might be more trouble and cost more overhead than it's worth, but
in theory, it would be a supreme system.

