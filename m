Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbUKJAK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUKJAK3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 19:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbUKJAK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 19:10:29 -0500
Received: from mail.kroah.org ([69.55.234.183]:16335 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261809AbUKJAKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 19:10:01 -0500
Date: Tue, 9 Nov 2004 16:08:11 -0800
From: Greg KH <greg@kroah.com>
To: dtor_core@ameritech.net
Cc: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       Kay Sievers <kay.sievers@vrfy.org>, tokunaga.keiich@jp.fujitsu.com,
       motoyuki@soft.fujitsu.com, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, rml@novell.com,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: 2.6.10-rc1-mm3: ACPI problem due to un-exported hotplug_path
Message-ID: <20041110000811.GA8543@kroah.com>
References: <20041105001328.3ba97e08.akpm@osdl.org> <20041105164523.GC1295@stusta.de> <20041105180513.GA32007@kroah.com> <20041105201012.GA24063@vrfy.org> <20041105204209.GA1204@kroah.com> <20041105211848.A21098@unix-os.sc.intel.com> <20041109225502.GC7618@kroah.com> <d120d5000411091548584bf8c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000411091548584bf8c5@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 06:48:17PM -0500, Dmitry Torokhov wrote:
> On Tue, 9 Nov 2004 14:55:02 -0800, Greg KH <greg@kroah.com> wrote:
> > On Fri, Nov 05, 2004 at 09:18:48PM -0800, Keshavamurthy Anil S wrote:
> > > Also, since you have brought this, I have one another question to you.
> > > Now in the new kernel, I see whenever anybody calls sysdev_register(kobj),
> > > an "ADD" notification is sent. why is this? I would like to call
> > > kobject_hotplug(kobj, ADD) later.
> > 
> > This happens when kobject_add() is called.  You shouldn't ever need to
> > call kobject_hotplug() for an add event yourself.
> > 
> 
> This is not always the case. One might want to postpone ADD event
> until all summpelental object attributes are created. This way userspace
> is presented with object in consistent state.

No, that's a mess.  Let userspace wait for those attributes to show up
if they need to.  That's what the "wait_for_sysfs" program bundled with
udev is for.

thanks,

greg k-h
