Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbTJMG05 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 02:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTJMG05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 02:26:57 -0400
Received: from user-118bgnr.cable.mindspring.com ([66.133.194.251]:42629 "EHLO
	BL4ST") by vger.kernel.org with ESMTP id S261471AbTJMG04 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 02:26:56 -0400
Date: Sun, 12 Oct 2003 23:27:27 -0700
From: Eric Wong <eric@yhbt.net>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Greg Norris <haphazard@kc.rr.com>
Subject: Re: retaining use of the mouse wheel with "psmouse_noext=1"?
Message-ID: <20031013062727.GB6958@BL4ST>
References: <20031011202411.GA1397@glitch.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031011202411.GA1397@glitch.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Norris <haphazard@kc.rr.com> wrote:
> I have to use the "psmouse_noext=1" option to psmouse.ko, in order to
> keep the pointer from going stark-raving mad[1] when I use my KVM
> switch.  Unfortunately, this seems to squash the use of the mouse wheel
> for scrolling (it still works as a 3rd button), which is a feature I'd
> really like to retain.  Is there any way to keep the wheel fully
> functional when using this option (or otherwise fix the KVM issue)? 
> It's a Belkin SOHO 4-port switch, if that makes a difference.

A stab in the dark (I don't have a KVM handy, or even a mouse at the
moment to test on) but you could try editing the psmouse_extensions()
function in drivers/input/mouse/psmouse-base.c :

	if (psmouse_noext)
		return PSMOUSE_PS2;

replace PSMOUSE_PS2 with another one of the defined variables found near
the bottom of: drivers/input/mouse/psmouse.h

You should be able to figure out which name most closely matches you
mouse by looking at the psmouse_extensions() function.

-- 
Eric Wong
