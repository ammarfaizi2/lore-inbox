Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270134AbRHGIao>; Tue, 7 Aug 2001 04:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270142AbRHGIaf>; Tue, 7 Aug 2001 04:30:35 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:39658 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S270134AbRHGIaY>; Tue, 7 Aug 2001 04:30:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: John Polyakov <johnpol@2ka.mipt.ru>, Ryan Mack <rmack@mackman.net>
Subject: Re: Encrypted Swap
Date: Mon, 6 Aug 2001 19:28:01 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0108070106390.7542-100000@localhost.localdomain> <Pine.LNX.4.33.0108062239550.5316-100000@mackman.net> <200108070624.f776Ofl21096@www.2ka.mipt.ru>
In-Reply-To: <200108070624.f776Ofl21096@www.2ka.mipt.ru>
MIME-Version: 1.0
Message-Id: <01080619280108.04153@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 August 2001 02:27, John Polyakov wrote:

> Hmmm, let us suppose, that i copy your crypted partition per bit to my
> disk.
> After it I will disassemble your decrypt programm and will find a key....

First of all, if the machine has a decent UPS than an administrator can be 
required to manually restart it with a key disk or some such.  Unix boxen 
with batter backups don't go down much for anything short of a hardware 
failure they wouldn't automatically reboot their way past anyway, and if it 
DOES go down you have a choice between availability or security.

But if you DO want automatic reboots of a network connected box (LAN 
perhaps), you could always have a key locally stored on the hard drive that 
is NOT the one to unlock the local filesystem, but instead the key (set of 
keys) required to talk to some server to get the local filesystem's key via 
an encrypted session.  That way if the machine is compromised and this is 
noticed quickly enough (meaning a yank-and-run job won't do it, especially if 
the server's checking in with the client fairly regularly), that machine's 
access to the server can be switched off.  (And that server may be on a LAN 
rather than the internet; you can't move the box too far while you physically 
molest it...)  Of course this just relocates part of your vulnerability (to 
the central keyserver: cue mark twain "put all your eggs in one basket and 
WATCH THAT BASKET"), but requiring someone to physically crack TWO boxes to 
get your data (keyserver and encrypted client box) is bound to add a LITTLE 
extra security.  And having the central keyserver allows key rotation...  
Yeah you've got to expect they'll snoop your network traffic somehow, but 
this is the basic problem cryptography was designed to address in the first 
place, and having the key without root on the box doesn't do them too much 
good either...

And in the "central keyserver" plus "clients with USB" case you can have 
somebody manning the keyserver 24/7 and manually checking and approving all 
reboots, which should almost never happen anyway...

> In any case, if anyone have crypted data, he MUST decrypt them.
> And for it he MUST have some key.
> If this is a software key, it MUST NOT be encrypted( it's obviously,
> becouse in other case, what will decrypt this key?) and anyone, who have
> PHYSICAL access to the machine, can get this key.
> Am I wrong?

I can think of scenarios where "must" doesn't apply here.  I've never 
personally been that paranoid, but the feds pay people to be clinically 
certifiable 24/7.  (Okay, find people who are clinically certifiable and then 
hire them to do something nominally productive with it...)

> RM> -Ryan

Rob
