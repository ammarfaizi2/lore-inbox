Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269024AbTGTXfO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 19:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269084AbTGTXfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 19:35:13 -0400
Received: from smtp3.unsw.EDU.AU ([149.171.96.70]:16883 "EHLO
	smtp3.unsw.edu.au") by vger.kernel.org with ESMTP id S269024AbTGTXfG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 19:35:06 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Riley Williams" <Riley@williams.name>
Date: Mon, 21 Jul 2003 09:48:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16155.10848.454262.343447@gargle.gargle.HOWL>
Cc: "James Simmons" <jsimmons@infradead.org>, <junkio@cox.net>,
       <linux-kernel@vger.kernel.org>
Subject: RE: "Where's the Beep?" (PCMCIA/vt_ioctl-s)
In-Reply-To: message from Riley Williams on Thursday July 17
References: <Pine.LNX.4.44.0307151750090.7746-100000@phoenix.infradead.org>
	<BKEGKPICNAKILKJKMHCAIEMGEOAA.Riley@Williams.Name>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday July 17, Riley@Williams.Name wrote:
> Hi James.
> 
>  >>>> On my old DELL LM laptop the -2.5 series no longer issues
>  >>>> any beeps when a card is inserted.  The problem is in the
>  >>>> kernel, as the test program below (extracted from cardmgr)
>  >>>> beeps on -2.4, but not on -2.5.
> 
>  >>> CONFIG_INPUT_PCSPKR needs to be =y (or =m and the module
>  >>> loaded).
> 
>  >> That's true, but I wonder why PC Speaker is under *INPUT*
>  >> category...
> 
>  > Because many keyboards have built in speakers.
> 
> What sort of logic is that !!!
> 
> The ONLY reason I can think of for treating a speaker as an INPUT
> device is if that speaker is wired up in a way that allows it to
> be used as a microphone, the way some baby-intercoms do. If this
> is the reason, then don't expect any sort of quality from it, and
> please also separate this use from the more conventional one.

The problem here is really with the name 'INPUT'.  It is not an
'input' subsytem, but rather an 'event' subsystem.  It handles events
like key presses, mounts movements, speaker beeps, LED on/off etc.

It could quite reasonable also be used for APCI events like power
status changes and power-button events, but I don't know that anyone
has any plans for that.

I gather the event subsystem was conceived to help managed the wide
variety of input devices (USB, PS/2, serial, etc) and was
inadvertantly misnamed 'input'.

  find linux -type f | xargs perl -pi -e 's/input/event/i'

 or something like that :-)

NeilBrown
