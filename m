Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318286AbSGRUGw>; Thu, 18 Jul 2002 16:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318290AbSGRUGw>; Thu, 18 Jul 2002 16:06:52 -0400
Received: from hqvsbh2.ms.com ([205.228.12.104]:31454 "EHLO hqvsbh2.ms.com")
	by vger.kernel.org with ESMTP id <S318286AbSGRUGv>;
	Thu, 18 Jul 2002 16:06:51 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15671.8335.526673.92376@axolotl.ms.com>
Date: Thu, 18 Jul 2002 16:09:51 -0400 (EDT)
From: Hildo.Biersma@morganstanley.com
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: close return value
In-Reply-To: <200207180001.g6I015f02681@devserv.devel.redhat.com>
References: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk>
	<20020716.165241.123987278.davem@redhat.com>
	<1026869741.2119.112.camel@irongate.swansea.linux.org.uk>
	<20020716.172026.55847426.davem@redhat.com>
	<mailman.1026868201.10433.linux-kernel2news@redhat.com>
	<200207180001.g6I015f02681@devserv.devel.redhat.com>
X-Mailer: VM 6.75 under 21.1 (patch 8) "Bryce Canyon" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pete" == Pete Zaitcev <zaitcev@redhat.com> writes:

Pete> I really hate to disagree with the chief penguin here, but it's
Pete> extremely dumb to return errors from close(). The last time we
Pete> trashed this issue on this list was when a newbie used an error
Pete> return from release() to communicate with his driver.

Pete> The problem with errors from close() is that NOTHING SMART can be
Pete> done by the application when it receives it. And application can:

Pete>  a) print a message "Your data are lost, have a nice day\n".
Pete>  b) loop retrying close() until it works.
Pete>  c) do (a) then (b).

I must disagree with you.  We run the Andrew File System (AFS), which
has client-side caching with write-on-close semantics.  If an error
occurs goes wrong at close() time, a well-written application can
actually do something useful - such as sending an alert, or letting
the user know the action failed.
