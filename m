Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSCPJlX>; Sat, 16 Mar 2002 04:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310191AbSCPJlO>; Sat, 16 Mar 2002 04:41:14 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:64014 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S310190AbSCPJlB>; Sat, 16 Mar 2002 04:41:01 -0500
Date: Sat, 16 Mar 2002 04:40:53 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Anders Gustafsson <andersg@0x63.nu>, arjanv@redhat.com,
        linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: Re: [PATCH] devexit fixes in i82092.c
Message-ID: <20020316044053.A11660@devserv.devel.redhat.com>
In-Reply-To: <3C92AD1F.30909@mandrakesoft.com> <Pine.LNX.4.33.0203152339200.31551-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0203152339200.31551-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Mar 15, 2002 at 11:40:30PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 11:40:30PM -0800, Linus Torvalds wrote:
> 
> On Fri, 15 Mar 2002, Jeff Garzik wrote:
> > 
> > I wonder if mochel already code for this, or has thought about this... 
> >  Just like suspend, IMO we ideally should use the device tree to 
> > shutdown the system, agreed?
> 
> Ideally we should, yes. Although if we really turn off power, it doesn't 
> much matter.

It kind of does for warm reboots. I'm getting more and more reports that
on warm reboot, the bios then can't boot again because we left some
hardware (usually the scsi or ide controller) in a state the bios didn't expect.
While I consider it a bios duty to reset the hw, using the device-tree for
clean shutdown of hardware at least would allow us to make it work.

> This is what I want. Those reboot/shutdown notifiers are completely and 
> utterly buggy, and cannot sanely handle any kind of device hierarchy.

Device owned notifiers could indeed go; the question is if
non-device owned ones (the only purpose of those would
probably cluster filesystems) should make a "fake" device or
keep using the current mechanism.

Greetings,
  Arjan van de Ven


