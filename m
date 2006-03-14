Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751039AbWCNOsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWCNOsx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 09:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751074AbWCNOsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 09:48:53 -0500
Received: from thunk.org ([69.25.196.29]:51340 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751039AbWCNOsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 09:48:52 -0500
Date: Tue, 14 Mar 2006 09:48:49 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
Subject: Re: How do I get the ext3 driver to shut up?
Message-ID: <20060314144849.GC16264@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, Rob Landley <rob@landley.net>,
	linux-kernel@vger.kernel.org
References: <200603132218.39511.rob@landley.net> <20060313231407.7606f0d3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060313231407.7606f0d3.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 11:14:07PM -0800, Andrew Morton wrote:
> >  Guess which device driver feels a bit chatty?
> > 
> > ...
> >
> >  VFS: Can't find ext3 filesystem on dev loop0.
> 
> That's only printed if the sys_mount() caller set MS_VERBOSE in `flags'.

I should have been a bit more explict in my previous message.
Actually, if you trace down the logic, it's only printed if
sys_mount() __DIDN'T__ set MS_VERBOSE in 'flags'.  The code in
fs/super.c sets the "silent" flag if (flags & MS_VERBOSE) is non-zero.
The meaning is reversed, which is counterintuitive.  Hence, my patch.

						- Ted
