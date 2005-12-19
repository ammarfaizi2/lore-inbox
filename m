Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbVLSSEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbVLSSEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 13:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVLSSEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 13:04:13 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:17858 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932340AbVLSSEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 13:04:12 -0500
Message-ID: <43A707CF.F27868E6@tv-sign.ru>
Date: Mon, 19 Dec 2005 22:19:43 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [PATCH rc5-rt2 3/3] plist: convert the code to newimplementation
References: <43A5A7BD.152A4F80@tv-sign.ru> <1135012399.30466.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:
> 
> I think firstly, if you want to have success with this patch you'll need
> to clean it up a bit. I'm not an authority on clean code , but below
> isn't clean to my eyes.

Cleanups are always good, I am open to any suggestions.

>                         However, this is cleaner than your last
> attempt .

Thanks, but it was NOT changed from my last attempt. Just rediff.

> Hard coding MAX_PRIO isn't really acceptable.

I don't do that? Could you clarify?

>                                               If your going to make it
> more similar to list_head , why not name it plist_head instead of
> pl_head that way it's easy to switch between them.

I don't mind to rename, probably plist_head is better. I'd like to know
Ingo's opinion first.

>                                                              Like you
> remove a lot of the API which makes it less similar to a regular list .

For example?

> Also, making any changes to the internals of the plist structure outside
> of plist.c (or similar) isn't acceptable. For instance you set the node
> priority in several places, that should be hidden inside another
> function or macro. That makes it easier for people to change the
> internal structure without treading though tons of code.

Agreed, I already thought it makes sense to add plist_add_prio() helper.
Note that ->prio is set directly mostly right before plist_add() call.

> Changing plist_empty() doesn't make any sense to me.

plist_empty(head) means this list empty. plist_unhashed(node) means
this node is not on list. 

>                                                       Also changing
> dp_node to prio_list doesn't make much sense either.

Again, this patch is unchanged. I don't mind to rename, but recall
that it was sent before the current implementation become functional.
And honestly I don't like 'sp_node', this name is misleading, and
reflects first buggy implementation. It should be called 'all_nodes'
or something like this.

Oleg.
