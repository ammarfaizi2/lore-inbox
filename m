Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVJKO4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVJKO4O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 10:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVJKO4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 10:56:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16557 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932110AbVJKO4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 10:56:11 -0400
Date: Tue, 11 Oct 2005 09:55:52 -0500
From: David Teigland <teigland@redhat.com>
To: Jan Hudec <bulb@ucw.cz>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/16] GFS: core fs
Message-ID: <20051011145552.GA8812@redhat.com>
References: <20051010171002.GD22483@redhat.com> <20051010213928.GB2475@elf.ucw.cz> <20051011121525.GC16249@djinn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051011121525.GC16249@djinn>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 02:15:25PM +0200, Jan Hudec wrote:
> On Mon, Oct 10, 2005 at 23:39:28 +0200, Pavel Machek wrote:

> > > + for (head = &ai->ai_ail1_list, tmp = head->prev, prev = tmp->prev;
> > > +      tmp != head;
> > > +      tmp = prev, prev = tmp->prev) {
> > 
> > 

> > > + for (head = &ai->ai_ail1_list, tmp = head->prev, prev = tmp->prev;
> > > +      tmp != head;
> > > +      tmp = prev, prev = tmp->prev) {
> > 
> > 
> > Can you get less creative in the for loops? [There are more examples
> > at other patches, for (i=something; i--; ) was "nicest" example].
> 
> The later two are good examples of where list_for_each_safe is
> appropriate.

There are multiple places like this that need either a
list_for_each_entry_reverse_safe or list_for_each_prev_safe, neither of
which exist.  I'll send a patch to add one.

I've just converted to a macro in ail2_empty() -- I'm not sure why I'd
left it out in that spot, maybe to be consistent with ail1_empty above.

Thanks,
Dave

