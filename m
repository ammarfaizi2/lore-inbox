Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274819AbRIUU3j>; Fri, 21 Sep 2001 16:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274821AbRIUU33>; Fri, 21 Sep 2001 16:29:29 -0400
Received: from mueller.uncooperative.org ([216.254.102.19]:62733 "EHLO
	mueller.datastacks.com") by vger.kernel.org with ESMTP
	id <S274819AbRIUU31>; Fri, 21 Sep 2001 16:29:27 -0400
Date: Fri, 21 Sep 2001 16:29:49 -0400
From: Crutcher Dunnavant <crutcher@datastacks.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Magic SysRq +# in 2.4.9-ac/2.4.10-pre12
Message-ID: <20010921162949.H8188@mueller.datastacks.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BA8C01D.79FBD7C3@osdlab.org>; from rddunlap@osdlab.org on Wed, Sep 19, 2001 at 08:56:13AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.  I'd really prefer to see callers use
> register_sysrq_key() and unregister_sysrq_key() so that they
> can get/use return values, and not the lower-level functions
> "__sysrq*" functions that are EXPORTed in sysrq.c.
> I don't see a good reason to EXPORT all of these functions.

So would I, however, the lower interface is there so that modules can
restructure the table in more complex ways, allowing for sub-menus.

The really good answer here is to add registration functions for the top
level handler, so that sub handlers can just claim the top level events
without mucking with the table, and then restore the table handler
later. This allows really modeful handlers, with submenus, and
potentially even key entry. An example would be a handler to kill a
specific process.

I'm also looking at a patch from Amazon which allows sysrq to be
'sticky', to get arround bad keyboards and VTs, and allows which key the
magic key is to be setable, to get arround VTs lacking sysrq entirely. 

I am reviewing the things I apparently horked, and this amazon stuff
(which is very small) at the moment. Expect a pair of patches tomorrow,
or late tonight.

Ps. I am very embarassed about the log-level stuff.

-- 
Crutcher        <crutcher@datastacks.com>
GCS d--- s+:>+:- a-- C++++$ UL++++$ L+++$>++++ !E PS+++ PE Y+ PGP+>++++
    R-(+++) !tv(+++) b+(++++) G+ e>++++ h+>++ r* y+>*$
