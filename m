Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272138AbTGYRfL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 13:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272228AbTGYRfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 13:35:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16035 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S272138AbTGYRfI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 13:35:08 -0400
Date: Fri, 25 Jul 2003 10:47:38 -0700
From: "David S. Miller" <davem@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: arjanv@redhat.com, torvalds@transmeta.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove module reference counting.
Message-Id: <20030725104738.7ffbc118.davem@redhat.com>
In-Reply-To: <20030725173900.D7DE12C2A9@lists.samba.org>
References: <20030725173900.D7DE12C2A9@lists.samba.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jul 2003 04:00:18 +1000
Rusty Russell <rusty@rustcorp.com.au> wrote:

> 	If module removal is to be a rare and unusual event, it
> doesn't seem so sensible to go to great lengths in the code to handle
> just that case.  In fact, it's easier to leave the module memory in
> place, and not have the concept of parts of the kernel text (and some
> types of kernel data) vanishing.
> 
> Polite feedback welcome,

I'm ok with this, with one possible enhancement.

How about we make ->cleanup() return a boolean, which if true
causes the caller to do the module_free()?

(Yes I know that doing this will require some more thought
 in order to minimize how large a change it would need to
 be to keep exiting modules working.  It's a seperate discussion.)
