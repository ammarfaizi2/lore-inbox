Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265862AbUAEDGO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 22:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265863AbUAEDGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 22:06:14 -0500
Received: from [209.195.52.120] ([209.195.52.120]:9683 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S265862AbUAEDGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 22:06:06 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, Rob Love <rml@ximian.com>,
       rob@landley.net, Pascal Schmidt <der.eremit@email.de>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Date: Sun, 4 Jan 2004 19:06:00 -0800 (PST)
Subject: Re: udev and devfs - The final word
In-Reply-To: <Pine.LNX.4.58.0401041847370.2162@home.osdl.org>
Message-ID: <Pine.LNX.4.58.0401041903290.6089@dlang.diginsite.com>
References: <20040103040013.A3100@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401022033010.10561@home.osdl.org> <20040103141029.B3393@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031423180.2162@home.osdl.org> <20040104000840.A3625@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl>
 <Pine.LNX.4.58.0401041847370.2162@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, what Andries is saying is that if you export a directory (say
/home) the process of exporting it somehow uses the /dev device number so
if the server reboots and gets a different device number for the partition
that /home is on the clients won't see it as the same export, breaking the
NFS requirement that a server can be rebooted.

I don't agree with him becouse if the NFS server does include /dev info in
what it shows to the outside world it's already broken.

David Lang


 On Sun, 4 Jan 2004, Linus Torvalds wrote:

> Date: Sun, 4 Jan 2004 18:52:56 -0800 (PST)
> From: Linus Torvalds <torvalds@osdl.org>
> To: Andries Brouwer <aebr@win.tue.nl>
> Cc: Rob Love <rml@ximian.com>, rob@landley.net,
>      Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
>      Greg KH <greg@kroah.com>
> Subject: Re: udev and devfs - The final word
>
>
>
> On Sun, 4 Jan 2004, Andries Brouwer wrote:
> >
> > Surprise! Are you leaving POSIX? Or ditching NFS?
> > Or demanding that NFS servers must never reboot?
>
> Ok, Andries, time for you to take a deep breath, and calm down. Because
> your arguments are getting ridiculous in the extreme.
>
> A NFS server is sure as hell not going to export _its_ dynamic /dev to its
> clients. That would be not just stupid, but crazy. Next you tell me that
> you were using devfs and exporting that over NFS.
>
> A NFS server is going to export something _totally_ different than its own
> /dev directory - it needs to be _client_-specific anyway. That's true with
> stable numbers too, btw - ever tried to mount a Solaris /dev on a Linux
> client? No workee.
>
> > A common Unix idiom is testing for the identity
> > of two files by comparing st_ino and st_dev.
> > A broken idiom?
>
> No. It still works. Even if the device numbers change across reboots.
>
> Why? Becuase that _program_ sure as hell isn't running across a reboot.
>
> And again, this is not something we haven't seen before. Have you ever
> looked at the "st_dev" values? Try once - look at what it returns for a
> NFS-mounted filesystem. Ponder. Notice how it already is NOT stable across
> reboots.
>
> In other words, the stuff you're complaining about is all stuff that
> nobody has _ever_ been able to rely on, and that has nothign to do with
> udev or anythign else. It all just shows how 100% right I am for saying
> that you cannot rely on stable numbers.
>
> So I repeat: calm down, and think it through.
>
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
