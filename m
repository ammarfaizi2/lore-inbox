Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265854AbUAECxM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 21:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265855AbUAECxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 21:53:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:27346 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265854AbUAECxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 21:53:10 -0500
Date: Sun, 4 Jan 2004 18:52:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
cc: Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
In-Reply-To: <20040104230104.A11439@pclin040.win.tue.nl>
Message-ID: <Pine.LNX.4.58.0401041847370.2162@home.osdl.org>
References: <20040103040013.A3100@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401022033010.10561@home.osdl.org> <20040103141029.B3393@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 4 Jan 2004, Andries Brouwer wrote:
> 
> Surprise! Are you leaving POSIX? Or ditching NFS?
> Or demanding that NFS servers must never reboot?

Ok, Andries, time for you to take a deep breath, and calm down. Because 
your arguments are getting ridiculous in the extreme.

A NFS server is sure as hell not going to export _its_ dynamic /dev to its 
clients. That would be not just stupid, but crazy. Next you tell me that 
you were using devfs and exporting that over NFS. 

A NFS server is going to export something _totally_ different than its own 
/dev directory - it needs to be _client_-specific anyway. That's true with 
stable numbers too, btw - ever tried to mount a Solaris /dev on a Linux 
client? No workee.

> A common Unix idiom is testing for the identity
> of two files by comparing st_ino and st_dev.
> A broken idiom?

No. It still works. Even if the device numbers change across reboots.

Why? Becuase that _program_ sure as hell isn't running across a reboot.

And again, this is not something we haven't seen before. Have you ever 
looked at the "st_dev" values? Try once - look at what it returns for a 
NFS-mounted filesystem. Ponder. Notice how it already is NOT stable across 
reboots.

In other words, the stuff you're complaining about is all stuff that 
nobody has _ever_ been able to rely on, and that has nothign to do with 
udev or anythign else. It all just shows how 100% right I am for saying 
that you cannot rely on stable numbers.

So I repeat: calm down, and think it through.

		Linus
