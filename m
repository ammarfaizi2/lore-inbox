Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVCVUIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVCVUIT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVCVUIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:08:18 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:64014 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261844AbVCVUGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:06:20 -0500
Date: Tue, 22 Mar 2005 21:06:16 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Alan Curry <pacman-kernel@manson.clss.net>, linux-kernel@vger.kernel.org,
       Egbert Eich <eich@freedesktop.org>
Subject: Re: SVGATextMode on 2.6.11
Message-ID: <20050322200616.GA4583@pclin040.win.tue.nl>
References: <20050302223859.32722.qmail@manson.clss.net> <20050321141859.22623bf1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321141859.22623bf1.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : pastinakel.tue.nl 1074; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Alan Curry" <pacman-kernel@manson.clss.net> wrote:
>>
>> With 2.6.11, I can no longer change the cursor with SVGATextMode. Previously,
>> a block cursor could be selected by
>>   echo Cursor 0-31 >> /etc/TextConfig ; SVGATextMode
>> and the cursor would be a block. On all consoles. Forever.
>> 
>> To accomplish the same thing using the softcursor escape sequences, I must:
>> 1. at boot, echo '^[[?8c' to each of /dev/tty1 through /dev/tty63.
>> 2. hack terminfo to contain ^[[?8c in place of ^[[?0c
>> 3. install the hacked terminfo on all other machines that I will log into
>> remotely
>> 
>> This still isn't quite right: the reset sequence ^[c destroys the block
>> cursor because the underline cursor is still the default.

Have you tried to recompile with a different default?
Look at <linux/console_struct.h>, and change the line
	#define CUR_DEFAULT CUR_UNDERLINE
to e.g.
	#define CUR_DEFAULT CUR_BLOCK

>> An SVGATextMode
>> block cursor isn't affected by ^[c -- it truly *becomes* the default

True - it is obtained by hardware reprogramming. But having lots of programs
touch the hardware is getting less popular.


Concerning your 1. - You know that such an echo actually creates the VC?
I still recall the times that there was not enough memory for more than
four or five VCs, but probably you don't mind wasting a few hundred kB.

Andries
