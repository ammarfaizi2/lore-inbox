Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbUKJEQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbUKJEQK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 23:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbUKJEQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 23:16:10 -0500
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:24482 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261849AbUKJEQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 23:16:02 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] Re: 2.6.10-rc1-mm3: ACPI problem due to un-exported hotplug_path
Date: Tue, 9 Nov 2004 23:15:55 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>,
       Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       Kay Sievers <kay.sievers@vrfy.org>, tokunaga.keiich@jp.fujitsu.com,
       motoyuki@soft.fujitsu.com, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, rml@novell.com, len.brown@intel.com,
       acpi-devel@lists.sourceforge.net
References: <20041105001328.3ba97e08.akpm@osdl.org> <d120d5000411091548584bf8c5@mail.gmail.com> <20041110000811.GA8543@kroah.com>
In-Reply-To: <20041110000811.GA8543@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411092315.55187.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 November 2004 07:08 pm, Greg KH wrote:
> On Tue, Nov 09, 2004 at 06:48:17PM -0500, Dmitry Torokhov wrote:
> > On Tue, 9 Nov 2004 14:55:02 -0800, Greg KH <greg@kroah.com> wrote:
> > > On Fri, Nov 05, 2004 at 09:18:48PM -0800, Keshavamurthy Anil S wrote:
> > > > Also, since you have brought this, I have one another question to you.
> > > > Now in the new kernel, I see whenever anybody calls sysdev_register(kobj),
> > > > an "ADD" notification is sent. why is this? I would like to call
> > > > kobject_hotplug(kobj, ADD) later.
> > > 
> > > This happens when kobject_add() is called.  You shouldn't ever need to
> > > call kobject_hotplug() for an add event yourself.
> > > 
> > 
> > This is not always the case. One might want to postpone ADD event
> > until all summpelental object attributes are created. This way userspace
> > is presented with object in consistent state.
> 
> No, that's a mess.  Let userspace wait for those attributes to show up
> if they need to.  That's what the "wait_for_sysfs" program bundled with
> udev is for.
>

I strongly disagree:

- it makes userspace being aware of implementation details (whe exactly it
  has to wait for, for how long, etc.) which is bad thing;
- not all the world is udev - needless replication of the code and bugs;
- not only making visible but announcing an object in non-working state
  to userspace simply does not feel right.

-- 
Dmitry
