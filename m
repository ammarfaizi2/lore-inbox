Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268166AbUI1R3H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268166AbUI1R3H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 13:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268156AbUI1R3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 13:29:06 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:32782 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268239AbUI1R2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 13:28:52 -0400
Message-ID: <9e47339104092810284f722e7f@mail.gmail.com>
Date: Tue, 28 Sep 2004 13:28:46 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Ian Romanick <idr@us.ibm.com>
Subject: Re: New DRM driver model - gets rid of DRM() macros!
Cc: dri-devel <dri-devel@lists.sourceforge.net>,
       Xserver development <xorg@freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <415997C6.1060802@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910409280854651581e2@mail.gmail.com>
	 <415997C6.1060802@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2004 09:56:38 -0700, Ian Romanick <idr@us.ibm.com> wrote:
> Anyone have a PCI card so that we can test actually using more than one
> at a time?  In the mean time, I think just having them all load at once
> and one of them work is good enough.

It would be best if everyone tested each card individually right now,
both PCI and AGP versions should work.

I think I know of a couple places where it might break if multiple
cards are used simultaneously. All static variables in the core are
suspect and need to be individually checked. There are less than 20 so
it shouldn't take too long. Of course any help with this is
appreciated.

Another thing that isn't written is splitting the module parameters
between the core and personalities. I'll also switch syntax from 2.4
style to 2.6 style. When finished each module with have a debug=1
parameter and the core will also have a cards_limit which defaults to
16.

This version also includes minor number reuse so hotplugging a card
in/out won't exhaust the DRM minors.

-- 
Jon Smirl
jonsmirl@gmail.com
