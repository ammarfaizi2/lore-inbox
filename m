Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932697AbWCPSKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbWCPSKi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 13:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbWCPSKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 13:10:37 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:54198
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932697AbWCPSKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 13:10:35 -0500
Date: Thu, 16 Mar 2006 10:10:25 -0800
From: Greg KH <greg@kroah.com>
To: "Artem B. Bityutskiy" <dedekind@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Bug? Report] kref problem
Message-ID: <20060316181025.GB8280@kroah.com>
References: <1142509279.3920.31.camel@sauron.oktetlabs.ru> <20060316165323.GA10197@kroah.com> <1142528877.3920.64.camel@sauron.oktetlabs.ru> <1142529004.3920.66.camel@sauron.oktetlabs.ru> <20060316172039.GB5624@kroah.com> <1142532019.3920.79.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142532019.3920.79.camel@sauron.oktetlabs.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 09:00:19PM +0300, Artem B. Bityutskiy wrote:
> On Thu, 2006-03-16 at 09:20 -0800, Greg KH wrote:
> > Again, why are you trying to call the sysfs raw functions?  You are not
> > registering the kobject with the kobject core, so bad things are
> > happening.  Why not call kobject_register() or kobject_add(), like it is
> > documented to do so?
> 
> Well, we were discussing this with you some time ago, and you pointed me
> to these raw functions. My stuff just does not fit device/driver/bu
> modes and you said I have to create whatever sysfs hierarchy I want with
> the raw functions.

Yes, but you still need to register your kobject :)

> kobject_register()/kobject_del() instead of
> sysfs_create_dir()/sysfs_remove_dir() solved my problem, thanks. Just to
> refine this, I'm still going to use
> sysfs_create_file()/sysfs_remove_file() to create whatever attributes I
> want, is this right?

Yes, that should be fine.

> I've just noticed similarity in naming: sysfs_remove_file() creates a
> file, so the symmetrical sysfs_create_dir() creates a directory. So just
> started using it. From the names it was not obvious that I could
> not. :-)

Hm, perhaps I'll just remove the export for that function as the only
thing that should use that is the kobject core, and that can't be built
as a module.

thanks,

greg k-h
