Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTIWXp5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 19:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTIWXp5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 19:45:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3551 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263397AbTIWXpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 19:45:54 -0400
Date: Tue, 23 Sep 2003 16:32:52 -0700
From: "David S. Miller" <davem@redhat.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: alan@lxorguk.ukuu.org.uk, davidm@hpl.hp.com, davidm@napali.hpl.hp.com,
       peter@chubb.wattle.id.au, bcrl@kvack.org, ak@suse.de, iod00d@hp.com,
       peterc@gelato.unsw.edu.au, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-Id: <20030923163252.2a93e406.davem@redhat.com>
In-Reply-To: <DD755978BA8283409FB0087C39132BD101B01197@fmsmsx404.fm.intel.com>
References: <DD755978BA8283409FB0087C39132BD101B01197@fmsmsx404.fm.intel.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003 15:58:29 -0700
"Luck, Tony" <tony.luck@intel.com> wrote:

> Which is great until the "cleverly written" program is fed a data set
> that pushes into the unaligned case far more frequently than the
> programmer anticipated.

Which is why the people who work on the networking are well
aware of the issues and will make sure the common case never
triggers these unaligned accesses.

People writing protocol stacks _don't_ feed these data unaligned
cases out onto the wire, because like us they want the networking
to go fast.  Why in the world do you think they specify in the
very RFCs that define the protocols that one should use NOP options
in the TCP option area in order to align TCP timestamps on a 32-bit
boundry?

Do you think they say this so people can go ahead and use memmove()'s
and byte loads all over the place anyways?

No, rather, they specify things so that unless you do something
absolutely stupid all the shit is aligned properly.

It is absurdly stupid to do byte loads of TCP and IP header
bits just because one tenth of one hundredths of one percent
of systems have some configuration where word and half-word
loads of these things will be unaligned _AND_ be slow on that
cpu.
