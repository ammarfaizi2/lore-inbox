Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTKLPwi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 10:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTKLPwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 10:52:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:51596 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262110AbTKLPwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 10:52:37 -0500
Date: Wed, 12 Nov 2003 07:52:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: "David S. Miller" <davem@redhat.com>,
       <viro@parcelfarce.linux.theplanet.co.uk>, <dancraig@internode.on.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-bk16 ALi M5229 kernel boot error
In-Reply-To: <20031112180642.A1064@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.44.0311120749520.3288-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Nov 2003, Ivan Kokshaysky wrote:
> 
> I'm not sure there was any logic at all, given extremely misleading
> comments in the original code. That "south-bridge's enable bit" stands
> for "enable input pins for 80-conductor cable detection" according
> to my (rather sparse) docs, and I don't understand why the hell it has
> anything to do with a northbridge.

The thing is, those "enable input pins" are actually GPIO's, and some 
boards don't use them as cable detect enables..

The whole thing should probably be done as a PCI quirk. Anyway, I'll
change my patch to be the absolute minimal one, ie just adding the
!isa_dev test instead of removing the old confused logic. I'm pretty 
certain that we shouldn't touch those GPIO's at all, but since some boards 
probably _do_ want them enabled, let's go for the minimal "avoid oops" 
approach.

		Linus

