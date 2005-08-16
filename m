Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbVHPFu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbVHPFu6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 01:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965122AbVHPFu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 01:50:58 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:44990
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S965121AbVHPFu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 01:50:57 -0400
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base
	Driver (dcdbas) with sysfs support
From: Michael E Brown <Michael_E_Brown@dell.com>
To: Chris Wedgwood <cw@f00f.org>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org,
       Doug Warzecha <Douglas_Warzecha@dell.com>
In-Reply-To: <20050816053541.GA26150@taniwha.stupidest.org>
References: <1124169589.10755.194.camel@soltek.michaels-house.net>
	 <20050816053541.GA26150@taniwha.stupidest.org>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 00:50:49 -0500
Message-Id: <1124171449.10755.217.camel@soltek.michaels-house.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-15 at 22:35 -0700, Chris Wedgwood wrote:
> On Tue, Aug 16, 2005 at 12:19:49AM -0500, Michael E Brown wrote:
> 
> > Hmm... did I mention libsmbios? :-)
> > http://linux.dell.com/libsmbios/main.
> 
> I'm aware of it --- it seems pretty limited right now and I'm still
> irked Dell isn't more forthcoming with documentation.

I cannot give docs, but I can retype the docs into code or xml files.
What, specifically, were you looking for?

I intend to make an XML file of all of the token name, id, and
description mappings within the next couple of weeks. This should pretty
much document all of the token mappings. 

Next thing would be to do something for the SMI calls. What I will do
there is basically just put a big table and make a C-API available for
every SMI call we support.

> Given that why not resubmit the kernel driver when the userspace
> becomes usable for people without them having to use MonsterApp from
> Dell?

Well, there are three different groups involved here. I didn't write the
dcdbas code, Doug did. I just reviewed it and decided it would be nice
to implement in libsmbios. I started work on the libsmbios side of
things this weekend. I didn't know that Doug had reposted the driver to
linux-kernel until about 4pm this afternoon. :-(

Libsmbios isn't the only user of dcdbas. That is the third group.
(MonsterApp, so nicely put...)

When I found out Doug reposted the driver, I went into overdrive trying
to finish out libsmbios. But, basically, libsmbios is a one-person
project, and that person would be me. And I have a "real" job to do
besides just libsmbios. :-)  The best I can guarantee is next week,
although if my manager is understanding, I may have it done sooner. :-)

> 
> > Aside from that, for the most part, the only thing SMI ever does is
> > pass buffers back and forth.
> 
> I meant to ask; does this have horrible latency or nasties like lots
> of laptop SMM stuff?

That really depends, I guess. The hugely horrible laptop SMM stuff
mostly has to do with the battery gauge. The reason that the battery
stuff takes so long is that they basically do an entire current
measurement and computation of the battery each time the SMI is called
and do not (and pretty much cannot) cache anything from call to call.
Compounding things, they have to talk to the battery over a very slow
serial link. (as related to me by a former BIOS engineer)

I haven't done any measurements on servers, but I bet that most of it
isn't anywhere near as bad as the laptop stuff.
--
Michael

