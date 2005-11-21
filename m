Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbVKULq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbVKULq5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 06:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932268AbVKULq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 06:46:57 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:24004 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932216AbVKULq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 06:46:56 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [RFC] userland swsusp
Date: Mon, 21 Nov 2005 12:47:44 +0100
User-Agent: KMail/1.8.3
Cc: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
References: <20051115212942.GA9828@elf.ucw.cz> <20051120214832.GC28918@redhat.com> <20051120220904.GB24132@elf.ucw.cz>
In-Reply-To: <20051120220904.GB24132@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511211247.45558.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sunday, 20 of November 2005 23:09, Pavel Machek wrote:
}-- snip --{ 
> > With what we have in-kernel, and a restricted /dev/mem, achieving the
> > attack you mention is a lot less feasible, as the attacker has no access
> > to the memory being written out to the suspend partition, even as root.
> > Even if they did, people tend to notice boxes shutting down pretty quickly
> > making this a not-very-stealthy attack.
> 
> Can I read somewhere about security model you are using? Would it be
> enough to restrict /dev/[k]mem to those people that have right to
> update kernel anyway? Or your approach is "noone, absolutely noone has
> right to modify running kernel"? [Do you still use loadable modules?]

The problem is that, whatever the security model, if you have access to the
kernel memory (eg. via /dev/kmem), you can modify the security rules
themselves, so this should better be avoided.

Apart from this, IMO, if it's necessary to access the kernel memory directly
from a userland process, this means that the process' functionality really
belongs to the kernel.  Consequently, the code in swsusp that needs
to access the kernel memory should stay in the kernel, and the rest
can go to the userland.

Greetings,
Rafael
