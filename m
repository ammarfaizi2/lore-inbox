Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751997AbWG1PFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbWG1PFz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 11:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbWG1PFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 11:05:55 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:31921 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751997AbWG1PFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 11:05:54 -0400
Subject: Re: A better interface, perhaps: a timed signal flag
From: Steven Rostedt <rostedt@goodmis.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Neil Horman <nhorman@tuxdriver.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Segher Boessenkool <segher@kernel.crashing.org>,
       Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
       a.zummo@towertech.it, jg@freedesktop.org
In-Reply-To: <20060728145210.GA3566@thunk.org>
References: <44C67E1A.7050105@zytor.com>
	 <20060725204736.GK4608@hmsreliant.homelinux.net>
	 <44C6842C.8020501@zytor.com> <20060725222547.GA3973@localhost.localdomain>
	 <70FED39F-E2DF-48C8-B401-97F8813B988E@kernel.crashing.org>
	 <20060725235644.GA5147@localhost.localdomain> <44C6B117.80300@zytor.com>
	 <20060726002043.GA5192@localhost.localdomain>
	 <20060726144536.GA28597@thunk.org>
	 <1154093606.19722.11.camel@localhost.localdomain>
	 <20060728145210.GA3566@thunk.org>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 11:05:16 -0400
Message-Id: <1154099116.19722.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 10:52 -0400, Theodore Tso wrote:

> Good point, and limiting this facility to one such timeout per
> task_struct seems like a reasonable restriction.  The downsides I can
> see about about mapping the tasks' own task struct would be (a) a
> potential security leak either now or in the future if some field in
> the task_struct shouldn't be visible to a non-privileged userspace
> program, and (b) exposing the task_struct might cause some (stupid)
> programs to depend on the task_struct layout.  Allocating an otherwise
> empty 4k page just for this purpose wouldn't be all that horrible,
> though, and would avoid these potential problems.

Actually, if you are going to map a page, then allow the user to do
PAGE_SIZE / sizeof(*flag) timers.  That way the user gets a single page
mapped for this purpose, and can have multiple flags.

I would only limit it to one page though. Since this page can not be
swapped out, if you allow for more than one page, a non privileged user
can map in a bunch of non swappable pages and might be able to perform a
DoS attack.

-- Steve


