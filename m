Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268338AbUHXVWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268338AbUHXVWe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268332AbUHXVWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:22:34 -0400
Received: from waste.org ([209.173.204.2]:39842 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268339AbUHXVW2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:22:28 -0400
Date: Tue, 24 Aug 2004 16:22:08 -0500
From: Matt Mackall <mpm@selenic.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] [3/4] /dev/random: Use separate entropy store for /dev/urandom
Message-ID: <20040824212208.GH5414@waste.org>
References: <E1By1Sq-0001TP-BV@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1By1Sq-0001TP-BV@thunk.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2004 at 12:57:20AM -0400, Theodore Ts'o wrote:
> 
> This patch adds a separate pool for use with /dev/urandom.  This
> prevents a /dev/urandom read from being able to completely drain the
> entropy in the /dev/random pool, and also makes it much more difficult
> for an attacker to carry out a state extension attack.

My version of this went a step further. We want to at all times ensure
that there's enough data to do a full catastrophic reseed in the
blocking pool, so we have to assure we're never drawing below that
point when doing reads for urandom.

-- 
Mathematics is the supreme nostalgia of our time.
