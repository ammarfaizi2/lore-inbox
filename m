Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbTDESFk (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 13:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbTDESFk (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 13:05:40 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:5098 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S261727AbTDESFj (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Apr 2003 13:05:39 -0500
Subject: Re: Route cache performance under stress
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       bert hubert <ahu@ds9a.nl>
In-Reply-To: <8765pshpd4.fsf@deneb.enyo.de>
References: <8765pshpd4.fsf@deneb.enyo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049566629.25170.203.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 Apr 2003 20:17:09 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-04-05 at 18:37, Florian Weimer wrote:

> Netfilter ip_conntrack support might have similar issues, but you
> can't use it in a uncooperative environment anyway, at least in my
> experience.  (Note that there appears to be no way to disable
> connection tracking while the code is in the kernel.)

It's correct that ip_conntrack has similar issues. There's been some
work on the hashalgorithm used but no patch has been made yet.
And yes it doesn't scale well at all (especially on SMP), I'm about to
start working on this a bit. Hopefully I can improve it somewhat.

If you've compiled ip_conntrack into your kernel there's only two ways
to disable it and both needs code-modifications :)

Install a netfilter-module that gets the packets before conntrack and
steal the packets, the downside is that you will bypass the rest of
iptables as well.

Apply a patch from patch-o-matic that adds a NOTRACK target that
instructs conntrack to not look at the packets marked by that target.

-- 
/Martin
