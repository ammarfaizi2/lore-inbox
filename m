Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264550AbTDPTYa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 15:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264554AbTDPTYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 15:24:30 -0400
Received: from AMarseille-201-1-5-18.abo.wanadoo.fr ([217.128.250.18]:14375
	"EHLO debian") by vger.kernel.org with ESMTP id S264550AbTDPTY3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 15:24:29 -0400
Subject: RE: Subtle semantic issue with sleep callbacks in drivers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304161133110.912-100000@cherise>
References: <Pine.LNX.4.44.0304161133110.912-100000@cherise>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050521763.644.9.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 16 Apr 2003 21:36:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-16 at 20:39, Patrick Mochel wrote:

> I completely agree with Andy. We should not re-POST the video hardware, no
> matter what. The idea behind ACPI is that the OS takes care of everything, 
> including video save/restore. 

If I understand Alan properly, we don't always have choice, some BIOSes
will do it anyway...

> We may not have the documentation to properly do that for all hardware 
> currently, but that is something that we have to suck up and deal with. 
> For now, we go with hardware that we're able to handle. 
> 
> The drivers that cannot support reinitialization will not be able to 
> support suspend-to-RAM. When we get to a point where it really becomes an 
> issue (i.e. after we have decent working code), then we concentrate on 
> getting the appropriate docuementation (or code itself, source or binary) 
> to do it correctly. 

It is now already ! I don't think we will _ever_ get ATI and nVidia
provide enough documentation to POST all chip models (which isn't always
possible without knowledge of every single way the chip is wired on a
each board).

Currently, I cannot implement suspend-to-RAM on the latest PowerBooks
because of that (they use nVidia chip that are powered down and not just
unclocked unlike earlier ATI based models) because of that. Nor can I
implement it on any other "desktop" Mac.

> Trying to figure out if we need to POST or not for different hardware, 
> based what the driver knows, is going to become quite a mess real fast. I 
> don't want to deal with the pain, and would rather take the high ground, 
> even if it means suffering in the short term. 

When I finally have an implementation of an OF runtime so I can re-POST
the card, I could eventually have the driver itself call this to explicitely
ask for a re-POST...

Ben.

