Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270324AbTGQUN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 16:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270420AbTGQUN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 16:13:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:2790 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270324AbTGQUN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 16:13:57 -0400
Date: Thu, 17 Jul 2003 13:19:02 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: schlicht@uni-mannheim.de, ricardo.b@zmail.pt, linux-kernel@vger.kernel.org
Subject: Re: SET_MODULE_OWNER
Message-Id: <20030717131902.76c68c56.davem@redhat.com>
In-Reply-To: <3F170589.50005@pobox.com>
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net>
	<3F16C190.3080205@pobox.com>
	<200307171756.19826.schlicht@uni-mannheim.de>
	<3F16C83A.2010303@pobox.com>
	<20030717125942.7fab1141.davem@redhat.com>
	<3F170589.50005@pobox.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003 16:22:33 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> This change is a major behavior change.  The whole point of removing a 
> module is knowing its gone ;-)  And that is completely changed now. 
> Modules are very often used by developers in a "modprobe ; test ; rmmod" 
> cycle, and that's now impossible (you don't know when the net device, 
> and thus your code, is really gone).  It's already breaking userland, 
> which does sweeps for zero-refcount modules among other things.
> 
> I can't believe I missed this.

Umm, Jeff, for years if you rmmod netfilter it very will
do this for you even if you have firewall rules installed.
This behavior exists in all of 2.4.x

People who do modprobe -r in their crontabs are asking
for trouble, losing their netdevice is the least of their
trouble especially if they have firewall rules installed.

Module reference counting added complications to net device
handling, and once I killed it off we could begin addressing
all of the real bugs that exist with network devices.  For example,
now that we're foreced to make net devices dynamic memory in all
cases we can deal with dangling procfs/sysfs references to the device
sanely.  Fixing that was not possible with module refcounting.

