Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316960AbSGNRaA>; Sun, 14 Jul 2002 13:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316961AbSGNR37>; Sun, 14 Jul 2002 13:29:59 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:28083 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316960AbSGNR36>;
	Sun, 14 Jul 2002 13:29:58 -0400
Date: Sun, 14 Jul 2002 19:32:36 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andries Brouwer <aebr@win.tue.nl>,
       A Guy Called Tyketto <tyketto@wizard.com>, linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020714193236.A27798@ucw.cz>
References: <20020714143702.A26584@ucw.cz> <200207141336.PAA01395@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200207141336.PAA01395@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Sun, Jul 14, 2002 at 03:36:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 03:36:20PM +0200, Rogier Wolff wrote:

> Vojtech Pavlik wrote:
> > > > > mice: PS/2 mouse device common for all mice
> > > > > atkbd.c: Sent: f5
> > > > > atkbd.c: Received fe
> > > > > serio: i8042 KBD port at 0x60,0x64 irq 1
> [...]
> > Responses:
> > 
> > 0xfe
> >   Resend. Keyboard will send this if it didn't receive the last command
> > correctly.
> > 
> > Unfortunately, 0xfe also happens when you send a command to a keyboard
> > that's not plugged, or when the keyboard doesn't understand the command.
> > Resending in those cases (which are the most common) would cause an
> > infinite loop ...
> 
> Not if implemented correctly. 
> 
> Set the retry counter to 5 at the beginning. 
> 
>     if you get 0xfe: decrement retry counter, 
> 	if 0 : 
> 	    no keyboard connected. Give up. 
> 	else 
> 	    Just immediately resend the last command
>     else
> 	set the retry counter to 5 again. 
> 	process returned code

Yes. Sure. I knew someone will suggest that. :) The only problem is,
I've never seen a keyboard sending 0xfe because it wants the command
sent again. Under normal circumstances, there aren't bit errors on the
cable.

-- 
Vojtech Pavlik
SuSE Labs
