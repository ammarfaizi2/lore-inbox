Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261697AbTIOXjN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbTIOXjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:39:13 -0400
Received: from hockin.org ([66.35.79.110]:53265 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S261697AbTIOXiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:38:46 -0400
Date: Mon, 15 Sep 2003 16:26:52 -0700
From: Tim Hockin <thockin@hockin.org>
To: James Clark <jimwclark@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Discourage Uniform Driver Model
Message-ID: <20030915162651.A27457@hockin.org>
References: <200309140027.08610.jimwclark@ntlworld.com> <200309142138.32222.jimwclark@ntlworld.com> <1063577498.2472.3.camel@dhcp23.swansea.linux.org.uk> <200309160013.38466.jimwclark@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200309160013.38466.jimwclark@ntlworld.com>; from jimwclark@ntlworld.com on Tue, Sep 16, 2003 at 12:13:38AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 16, 2003 at 12:13:38AM +0100, James Clark wrote:
> I understand the way competitor binary interfaces work. Currently I'm not 
> going to roll up my sleeves and write this system. I don't have the technical 
> expertise to design such a thing and although I could learn the curve at this 
> time is too steep. I do think that my experience with similar competitor 
> systems allows me to speak on the subject. However, I feel that pushing for 
> this change is a positive thing. It has started a debate on 'misusing' the 
> GPL to prevent binary only modules and has resulted in some positive 
> comments. If they debate it  rationally and then decide not to bother I will 
> have achieved a lot. I do  feel qualified to make this (obvious) suggestion 
> and comment on the design of any resulting interface.

I and others have repeatedly pointed out the big failings in this, which you
have ignored.

To do this means you must freeze the size of any structure passed across the
kernel-module boundary.  You must freeze any functions which are in-lined.

spin_lock() must not have debugging code which is enabled by a CONFIG_
option, or it must become a function call.  You can never optimize away
stuff that only matters on SMP systems.  You can never have a structure
include members conditionally upon CONFIG_ options, or you have to provide
accessor functions for every field of every struct.

This is what you are not getting.  Because module code is a first-class
citizen in Linux, you CAN'T decouple them, without imposing BIG UGLY
restrictions on all modules.  Do you understand the examples I am giving
you?  I can be more explicit, if you like.

Now, if you, or someone can devise a cleanish way to do it, SHOW US CODE.
It doesn't have to work fully, just enough to convince us it could work AT
ALL.

I assert that any solution will have one or more of the following
attributes, any of which are unacceptable:

* will perform terribly
* will be cumbersome to code
* will impose new restrictions on kernel developers
* will be unmaintainable


I BEG YOU to prove me wrong.

-- 
Notice that as computers are becoming easier and easier to use,
suddenly there's a big market for "Dummies" books.  Cause and effect,
or merely an ironic juxtaposition of unrelated facts?

