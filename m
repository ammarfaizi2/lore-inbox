Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270896AbTGPOuB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270895AbTGPOuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:50:01 -0400
Received: from mailb.telia.com ([194.22.194.6]:33530 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id S270891AbTGPOty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:49:54 -0400
X-Original-Recipient: linux-kernel@vger.kernel.org
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1: Synaptics driver makes touchpad unusable
References: <200307151244.53276.gallir@uib.es>
	<200307151753.59165.gallir@uib.es> <m2brvvh3vz.fsf@telia.com>
	<200307161649.55783.gallir@uib.es>
From: Peter Osterlund <petero2@telia.com>
Date: 16 Jul 2003 17:04:38 +0200
In-Reply-To: <200307161649.55783.gallir@uib.es>
Message-ID: <m2brvutsvt.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ricardo Galli <gallir@uib.es> writes:

> On Tuesday 15 July 2003 23:33, Peter Osterlund shaped the electrons to shout:
> > Does it help to make the timeout even longer? (15 seconds for example)
> > Does it help to disable the reset sequence altogether, like this?
> >
> > diff -u -r -N linux-2.6.0-test1/drivers/input/mouse/synaptics.c
> > linux-tmp/drivers/input/mouse/synaptics.c ---
> > linux-2.6.0-test1/drivers/input/mouse/synaptics.c	Sat Jul 12 00:17:19 2003
> > +++ linux-tmp/drivers/input/mouse/synaptics.c	Tue Jul 15 23:31:01 2003 @@
> > -81,6 +81,8 @@
> >  {
> >  	unsigned char r[2];
> >
> > +	return 0;
> > +
> >  	if (psmouse_command(psmouse, r, PSMOUSE_CMD_RESET_BAT))
> >  		return -1;
> >  	if (r[0] == 0xAA && r[1] == 0x00)
> 
> 
> No, it didn't help. With the above patch, the x server gives the following 
> errors:
> Query no Synaptics: 0000C8
> (EE) TouchPad no synaptics  touchpad detected and no repeater device
> (EE) TouchPad Unable to query/initialize Synaptics hardware.

Looks like the wrong protocol is specified in the X driver
configuration. You must set "Device" to "/dev/input/eventX" and
"Protocol" to "event", where X is probably 0 in your case.

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
