Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946048AbWJaWNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946048AbWJaWNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 17:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946055AbWJaWNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 17:13:13 -0500
Received: from mx4.cs.washington.edu ([128.208.4.190]:32426 "EHLO
	mx4.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1946048AbWJaWNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 17:13:12 -0500
Date: Tue, 31 Oct 2006 14:13:04 -0800 (PST)
From: David Rientjes <rientjes@cs.washington.edu>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org, Giuliano Pochini <pochini@shiny.it>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] Fix potential NULL pointer dereference in echoaudio
 midi.
In-Reply-To: <200610312221.41089.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.64N.0610311411000.2572@attu4.cs.washington.edu>
References: <200610312221.41089.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006, Jesper Juhl wrote:

> In sound/pci/echoaudio/midi.c::snd_echo_midi_output_write(), there's a risk
> of dereferencing a NULL 'chip->midi_out'.
> This patch contains the obvious fix as also used a bit higher up in the 
> same function.
> 

How about just adding an early test:
	if (!chip->midi_out)
		goto out;

and adding a label for out before the chip->lock unlock?  We still need to 
clear chip->midi_full so we still require the spinlock, but there's no 
reason we should be testing chip->midi_out multiple times since the 
remaining code path in its entirety depends on it.

		David
