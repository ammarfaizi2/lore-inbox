Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263616AbUEXOUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbUEXOUL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 10:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbUEXOUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 10:20:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50903 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263616AbUEXOT6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 10:19:58 -0400
Date: Mon, 24 May 2004 15:19:56 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       "'Phil Schwan'" <phil@clusterfs.com>
Subject: Re: [PATCH/RFC] Lustre VFS patch
Message-ID: <20040524141956.GC17014@parcelfarce.linux.theplanet.co.uk>
References: <20040524114009.96CE13100E2@moraine.clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524114009.96CE13100E2@moraine.clusterfs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 07:39:50PM +0800, Peter J. Braam wrote:
> vfs-intent_api-vanilla-2.6.patch
>  
>   Introduce intents for other operations.  Add a file system hook to
>   release intent data.  Make a few "intent versions" of functions such
>   as "lookup_one_len_it" and "user_walk_it" available through headers.
>   Arrange that the open intent is visible in the open methods. Add a
>   few missing intent_init calls.

Where is the code using it?  Without examples of use there's no way to
tell whether it's bogus or not.

As it is, it looks like massive hook-adding exercise with no clear goal.
The same goes for ..._raw variants of the methods - yes, something in
that direction would make sense; however, splitting the codepath on the
top level looks like a bloody bad idea.  _IF_ we get hooks of that sort,
the right thing to do is to provide helpers and make normal filesystems
use them, passing current foo_mknod et.al. as callbacks.  And in any
case, that needs discussing - it's not obvious that "let's take over
entire work past lookup of parents" is the best choice here.

Again, without examples of users for that stuff you are asking for blind
change of API I'm really not comfortable with.
