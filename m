Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUBWFyg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 00:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbUBWFyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 00:54:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59306 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261830AbUBWFyS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 00:54:18 -0500
Date: Mon, 23 Feb 2004 05:54:15 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Mike Strosaker <strosake@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch-specific callout in panic()
Message-ID: <20040223055415.GY31035@parcelfarce.linux.theplanet.co.uk>
References: <40398BFE.1040300@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40398BFE.1040300@austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 11:13:34PM -0600, Mike Strosaker wrote:
> Hello, All:
> 
> There are some ppc64-specific actions that should be taken upon a
> kernel panic.  Rather than adding a new #ifdef in panic(), it seems to
> me that it would be worthwhile to add a single callout, and move the
> arch-specific code out to the arch subtrees.  Does this seem reasonable,
> or should another #ifdef be added in panic() to perform the ppc64-
> specific actions?

Don't do it that way.  Add a weak alias to empty function and override it
on ppc64 by defining a function with the same name.

See how cond_syscall() is done - similar trick will work here.  There's
no need to mess with the architectures that do not use your hook.
