Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316614AbSGNNdb>; Sun, 14 Jul 2002 09:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316663AbSGNNda>; Sun, 14 Jul 2002 09:33:30 -0400
Received: from users-vst.linvision.com ([62.58.92.114]:40824 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S316614AbSGNNd2>; Sun, 14 Jul 2002 09:33:28 -0400
Message-Id: <200207141336.PAA01395@cave.bitwizard.nl>
Subject: Re: kbd not functioning in 2.5.25-dj2
In-Reply-To: <20020714143702.A26584@ucw.cz> from Vojtech Pavlik at "Jul 14, 2002
 02:37:02 pm"
To: Vojtech Pavlik <vojtech@suse.cz>
Date: Sun, 14 Jul 2002 15:36:20 +0200 (MEST)
CC: Andries Brouwer <aebr@win.tue.nl>,
       A Guy Called Tyketto <tyketto@wizard.com>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice: Read http://www.bitwizard.nl/cou.html for the licence to my Emailaddr.
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> > > > mice: PS/2 mouse device common for all mice
> > > > atkbd.c: Sent: f5
> > > > atkbd.c: Received fe
> > > > serio: i8042 KBD port at 0x60,0x64 irq 1
[...]
> Responses:
> 
> 0xfe
>   Resend. Keyboard will send this if it didn't receive the last command
> correctly.
> 
> Unfortunately, 0xfe also happens when you send a command to a keyboard
> that's not plugged, or when the keyboard doesn't understand the command.
> Resending in those cases (which are the most common) would cause an
> infinite loop ...

Not if implemented correctly. 

Set the retry counter to 5 at the beginning. 

    if you get 0xfe: decrement retry counter, 
	if 0 : 
	    no keyboard connected. Give up. 
	else 
	    Just immediately resend the last command
    else
	set the retry counter to 5 again. 
	process returned code


Roger. 



-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
