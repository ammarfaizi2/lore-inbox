Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265466AbTFRRvU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 13:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265468AbTFRRvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 13:51:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39924 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265466AbTFRRvP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 13:51:15 -0400
Subject: Re: [PATCH] 2.5.72 O(1) interactivity bugfix
From: Robert Love <rml@tech9.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200306190043.14291.kernel@kolivas.org>
References: <200306190043.14291.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1055959503.7069.1864.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 18 Jun 2003 11:05:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-18 at 07:43, Con Kolivas wrote:

> While messing with the interactivity code I found what appears to be an 
> uninitialised variable (p->sleep_avg), which is responsible for all the 
> boost/penalty in the scheduler.

The variable isn't uninitialized, it is inherited from the parent.

Recall that the task_struct of the new child starts off as a duplicate
of the parent's. If the variables are not explicitly set, they remain
the same as the parent's.

So this patch ends up resetting the sleep_avg to zero, instead of being
the same as the parent, which may or may not result in better
performance.

	Robert Love

