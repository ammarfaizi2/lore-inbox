Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVIOJjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVIOJjE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 05:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVIOJjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 05:39:04 -0400
Received: from [203.171.93.254] ([203.171.93.254]:62951 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S932384AbVIOJjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 05:39:03 -0400
Subject: Re: [linux-pm] swsusp3: push image reading/writing into userspace
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <20050915073744.GA2725@elf.ucw.cz>
References: <20050914223206.GA2376@elf.ucw.cz>
	 <1126749596.3987.5.camel@localhost> <20050915063753.GA2691@elf.ucw.cz>
	 <1126768581.3987.31.camel@localhost>  <20050915073744.GA2725@elf.ucw.cz>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1126776726.4452.50.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 15 Sep 2005 19:32:06 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-09-15 at 17:37, Pavel Machek wrote:
> Hi!
> 
> > > > > Here's prototype code for swsusp3. It seems to work for me, but don't
> > > > > try it... yet. Code is very ugly at places, sorry, I know and will fix
> > > > > it. This is just proof that it can be done, and that it can be done
> > > > > without excessive ammount of code.
> > > > 
> > > > No comments on the code sorry. Instead I want to ask, could you please
> > > > find a different name? swsusp3 is going to make people think that it's
> > > > Suspend2 redesigned. Since there hasn't been a swsusp2 (so far as I
> > > > know), how about using that name instead? At least then we'll clearly
> > > > differentiate the two implementations and you won't confuse/irritate
> > > > users.
> > > 
> > > swsusp2 can't be used, it is already "taken" by suspend2 (25000 hits
> > > on google). I was actually hoping that you would release suspend4
> > > (using swsusp3 infrastructure) :-).
> > 
> > You could reclaim it. There are 10 times as many hits (239,000) for
> > suspend2, and I've never wanted it to be called swsusp2 anyway :). As
> > for suspend4, at the moment, I'm not planning on ever progressing beyond
> > 2.x.
> 
> Sorry, have to ask...
> 
> "not planning on progressing" == version number stays "2" no matter
> what changes, or "not planning on progressing" == not plan to use
> swsusp3/uswsusp infrastructure?

I'm not planning on ever progressing beyond 2.x because I'm seeing the
code I have now as pretty much feature complete. There are a few small
areas that I'd like to improve (reinstating module support being one -
it was a mistake to remove it), but I don't see the need for a complete
redesign. That said, I was careful to say 'at the moment'. I'm not
denying for a second that things might change.

Regarding the 'swsusp3/uswsusp infrastructure': as I see it at the
moment (feel free to correct me), your new revision is only moving as
much code as you can to userspace (plus changes that are made necessary
by that). Beyond maybe reducing the kernel size a little, I don't see
any advantage to that - it just makes things more complicated and
requires the user to set up more in the way of an initrd or initramfs in
order to suspend and resume. You end up with more code to maintain to
get the same functionality (same amount of kernel code or slightly less
plus extra userland code to do all the reading and writing). I'm
speaking from experience. Bernard and I moved the userinterface code to
userspace to make others happy and that fact that we ended up with more
code shouldn't surprise anyone. You need all the code you had before
plus code for the interface (at least).

If the main impetus is seeking to reduce kernel code size, why not just
provide the option of building your code as a module for those who are
concerned about that statistic?

> > > I guess I could call it "uswsusp".
> > 
> > u as in micro?
> 
> Originaly I thought about it as "userland-swsusp", but micro-swsusp
> sounds nice, too.

I think people would think of micro more readily that userland, but it's
your choice :)

Regards,

Nigel
								Pavel
-- 


