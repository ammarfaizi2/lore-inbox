Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbTKNAxs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 19:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbTKNAxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 19:53:48 -0500
Received: from findaloan-online.cc ([216.209.85.42]:47750 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id S261752AbTKNAxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 19:53:47 -0500
Date: Thu, 13 Nov 2003 19:52:04 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: kirk bae <justformoonie@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: So, Poll is not scalable... what to do?
Message-ID: <20031114005203.GA4425@mark.mielke.cc>
References: <Law12-F49kTQUM6H2Ht000057a3@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law12-F49kTQUM6H2Ht000057a3@hotmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 05:10:50PM -0600, kirk bae wrote:
> Is mixing threads with poll uncommon? Is this a bad design? any comments 
> would be appreciated.

For a portable solution involving threads, I am fond of using threads to
prioritize the scheduling. For example, a high priority thread could poll()
or select() for (the expected few) high priority events, a medium for medium,
and a low for low. Periodic events, or events that may frequently occur,
may deserve their own blocking thread.

The model probably isn't the simplest to code, though... :-)

I'm most fond of this model as the medium or lower priority threads shouldn't
wake up as often.

Another variant on this that may further reduce the overhead of poll()
is to put events that are expected to occur in the high priority
thread, and events that won't occur for some time in the low priority
thread. This variant would cause problems in the case that priority is
important, and mis-classification of an event would have an
exaggerated cost.

I suppose it really depends on the target application, as to which model
would work best...

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

