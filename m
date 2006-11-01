Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992808AbWKAUbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992808AbWKAUbx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 15:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992807AbWKAUbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 15:31:41 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:37044 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S2992806AbWKAUbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 15:31:39 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm] swsusp: Freeze filesystems during suspend (rev. 2)
Date: Wed, 1 Nov 2006 21:27:17 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>,
       Christoph Hellwig <hch@infradead.org>
References: <200611011200.18438.rjw@sisk.pl> <200611011853.09633.rjw@sisk.pl> <20061101114519.5a3fe193.akpm@osdl.org>
In-Reply-To: <20061101114519.5a3fe193.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611012127.17943.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 1 November 2006 20:45, Andrew Morton wrote:
> On Wed, 1 Nov 2006 18:53:07 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > +void thaw_processes(void)
> > +{
> > +	printk("Restarting tasks ... ");
> > +	__thaw_tasks(FREEZER_KERNEL_THREADS);
> > +	thaw_filesystems();
> > +	__thaw_tasks(FREEZER_USER_SPACE);
> > +	schedule();
> > +	printk("done.\n");
> > +}
> >  
> > -	read_unlock(&tasklist_lock);
> > +void thaw_kernel_threads(void)
> > +{
> > +	printk("Restarting kernel threads ... ");
> > +	__thaw_tasks(FREEZER_KERNEL_THREADS);
> >  	schedule();
> >  	printk("done.\n");
> >  }
> 
> what do these random-looking schedule()s do??

My understanding is that they allow the thawed tasks to actually exit
the refrigerator, because __thaw_tasks() only changes their states.
