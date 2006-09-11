Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965071AbWIKV23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbWIKV23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 17:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbWIKV22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 17:28:28 -0400
Received: from nef2.ens.fr ([129.199.96.40]:36877 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S964940AbWIKV21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 17:28:27 -0400
Date: Mon, 11 Sep 2006 23:28:26 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: capabilities patch: trying a more "consensual" approach
Message-ID: <20060911212826.GA9606@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Mon, 11 Sep 2006 23:28:26 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

Given the rather cold reception that my "capabilities" patch has met,
it is obvious that it will never be accepted in any official kernel,
so I am now abandoning it and will try to suggest a different approach
that, in my opinion, isn't nearly as useful or expressive, but which
should probably be much more acceptable to those who found fault with
my previous patch, since it follows various suggestions which I
received on the list.

First, attempt to implement POSIX draft semantics for inheritance as
closely as the current situation will allow.  (I think this is wrong,
but many people seem to care, and POSIX semantics is still better than
no semantics at all.)  Actual filesystem support can come later (Serge
Hallyn has a patch for that), but in the meantime it would be useful
to add some (per-filesystem) mount options to specify the default
"inheritable" and "effective" capability sets.  In the absence of this
mount option, the behavior would be entirely unchanged, so everyone
should be happy.  With the mount options, capabilities will be
somewhat inheritable (only "somewhat", though, because with the POSIX
semantics, even with a default set, you can't force a non-caps-aware
process to gain caps in such a way that it will pass it on to its
children).

Second, suppress the idea of "regular" capabilities, and implement
them with Linux Security Module hooks (the module could be called,
say, "cuppabilities").  This won't do as much, but we can probably
still get a few things done that way.  Unfortunately, the
cuppabilities won't (can't) follow the same inheritance rules as
capabilities, and this might be a bit confusing.  But better than
nothing.

Is there some objection to this scheme?  I should start coding it in a
couple of weeks.

Happy hacking,

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
