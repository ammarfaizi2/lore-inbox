Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261881AbVEKFgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbVEKFgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 01:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVEKFgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 01:36:54 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:19903 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261881AbVEKFgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 01:36:31 -0400
Date: Tue, 10 May 2005 22:36:23 -0700
From: Greg KH <gregkh@suse.de>
To: Per Liden <per@fukt.bth.se>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
Message-ID: <20050511053622.GD8287@suse.de>
References: <20050506212227.GA24066@kroah.com> <Pine.LNX.4.63.0505090025280.7682@1-1-2-5a.f.sth.bostream.se> <20050509232207.GB24238@suse.de> <Pine.LNX.4.63.0505101843050.2271@1-1-2-5a.f.sth.bostream.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0505101843050.2271@1-1-2-5a.f.sth.bostream.se>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 11:51:04PM +0200, Per Liden wrote:
> On Mon, 9 May 2005, Greg KH wrote:
> 
> > On Mon, May 09, 2005 at 12:52:02AM +0200, Per Liden wrote:
> > > On Fri, 6 May 2005, Greg KH wrote:
> > > 
> > > [...]
> > > > Now, with the 2.6.12-rc3 kernel, and a patch for module-init-tools, the
> > > > USB hotplug program can be written with a simple one line shell script:
> > > > 	modprobe $MODALIAS
> > > 
> > > Nice, but why not just convert all this to a call to 
> > > request_module($MODALIAS)? Seems to me like the natural thing to do.
> > 
> > Because that's not the only thing that the hotplug event causes to
> > happen. It's easier to have userspace decide what to do with this 
> > instead.
> 
> Sure, the hotplug event could still be issued so that userspace could do 
> magic things when it wants to (load firmware or whatever), but since the 
> kernel already has all the infrastructure in place to load modules on 
> demand, and it's used all over the place, it doesn't make sense to use a 
> completely different approach here.

Well, do you really want your kernel to be creating 2 userspace programs
for every device in sysfs that is created?  Remember, we can't just not
emit that hotplug event, too many programs need it....

> Also, since most people never need to do anything except modprobe, they 
> can still have a working system without any scripts what so ever... again 
> just like normal on demand module loading.

Lots of programs do lots of stuff other than modprobe on hotplug events.
Look at HAL for just one example.

thanks,

greg k-h
