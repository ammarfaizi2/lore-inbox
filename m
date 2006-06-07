Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWFGJzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWFGJzP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 05:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWFGJzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 05:55:15 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:4316 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932108AbWFGJzN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 05:55:13 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Don Zickus <dzickus@redhat.com>
Subject: Re: [2.6.17-rc5-mm2] crash when doing second suspend: BUG in arch/i386/kernel/nmi.c:174
Date: Wed, 7 Jun 2006 11:55:38 +0200
User-Agent: KMail/1.9.3
Cc: Nigel Cunningham <ncunningham@linuxmail.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, shaohua.li@intel.com,
       miles.lane@gmail.com, jeremy@goop.org, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>
References: <4480C102.3060400@goop.org> <200606071005.14307.ncunningham@linuxmail.org> <20060607004217.GF11696@redhat.com>
In-Reply-To: <20060607004217.GF11696@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606071155.38701.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 07 June 2006 02:42, Don Zickus wrote:
> On Wed, Jun 07, 2006 at 10:05:07AM +1000, Nigel Cunningham wrote:
> > On Wednesday 07 June 2006 09:55, Don Zickus wrote:
> > > > > So my question is/was what is the proper way to handle processor level
> > > > > subsystems during the suspend/resume path on an SMP system.  I really
> > > > > don't understand the hotplug path nor the suspend/resume path very
> > > > > well.
> > > >
> > > > Make it work properly for CPU hotplug for individual CPU and then in
> > > > suspend you take care of "global" state and the last CPU.
> > >
> > > So the assumption is treat all the cpus the same either all on or all off,
> > > no mixed mode (some cpus on, some cpus off).  I guess I was trying to hard
> > > to work on the per-cpu level.
> > 
> > This sounds wrong to me. Shouldn't the the effect of hotunplugging a cpu be to 
> > put the driver in a state equivalent to if that cpu simply didn't exist? 
> > Unplugging shouldn't assume we're going to subsequently have either a driver 
> > suspend, or a replug.
> 
> This is my biggest problem or maybe my complete lack of understanding, is
> that I don't know how to determine what state I am in during a hotplug
> event, either a cpu removal or a suspend.  Therefore I feel like I have to
> store some persistant data around _just_ in case this is a suspend event.
> Also at the opposite end, how to separate a cpu insert vs. a cpu resume.
> The different being initialize to a global state vs. initialize to a last
> known state.

The original idea was to treat the nonboot CPUs as though they were removed.

Greetings,
Rafael
