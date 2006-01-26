Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWAZXQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWAZXQK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 18:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWAZXQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 18:16:10 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:43735 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030220AbWAZXQH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 18:16:07 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: [ 01/23] [Suspend2] Make workqueues freezeable.
Date: Fri, 27 Jan 2006 00:17:18 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>
References: <20060126034518.3178.55397.stgit@localhost.localdomain> <20060126034527.3178.99591.stgit@localhost.localdomain>
In-Reply-To: <20060126034527.3178.99591.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601270017.18773.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 26 January 2006 04:45, Nigel Cunningham wrote:
> 
> Prior to this patch, kernel threads and workqueues are unconditionally
> unfreezeable. This patch reverses that behaviour, making the default
> for kernel processes to be frozen. New variations of the routines for
> starting kernel threads and workqueues (containing _nofreeze_) allow
> threads that need to run during suspend to be made nofreeze again.

This looks like "let's make everything freezable and hunt for things that
must not be frozen" kind of approach, but isn't it error-prone?  I mean,
for example, if someone creates a kernel thread that in fact must not
be frozen, but forgets to use the _nofreeze_ call, things will break for
some people and the problem will be worse than the current one,
it seems.

Greetings,
Rafael
