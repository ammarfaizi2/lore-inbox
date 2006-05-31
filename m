Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWEaL7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWEaL7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 07:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWEaL7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 07:59:46 -0400
Received: from wx-out-0102.google.com ([66.249.82.193]:9036 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932479AbWEaL7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 07:59:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=eM/C8DP8FNdmN64K7Tw7Ii8ppamjRaoXqE3WqOvEz8QBp2qMx4CE91CscKK65qhfh5kv/8z47N2hWhndt315ivu58ApGSwLOd47IyNeqak8S/exoOE8GCBAmny5PHihQPCcHt0Kk3ENrNOHkxI5DOJd9p4seKgxaqkM1+Rua6xk=
Message-ID: <447D8524.9090908@gmail.com>
Date: Wed, 31 May 2006 19:59:32 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Ondrej Zajicek <santiago@mail.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com> <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz> <20060530223513.GA32267@localhost.localdomain> <447CD367.5050606@gmail.com> <20060531082605.GA3925@localhost.localdomain>
In-Reply-To: <20060531082605.GA3925@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ondrej Zajicek wrote:
> On Wed, May 31, 2006 at 07:21:11AM +0800, Antonino A. Daplas wrote:
>>> 2) To modify appropriate fbdev drivers to not do mode change at startup.
>>>    Fill fb_*_screeninfo with appropriate values for text mode instead.
>> Most drivers do not change the mode at startup.  Do not load fbcon, and
>> you will retain your text mode even if a framebuffer is loaded. 
> 
> Yes, but i wrote about _using_ fbcon and fbdev without mode change.

boot with fbcon=map:9 /* or any number greater than the number of fbdev's loaded */

> 
>>> 3) (optional) To modify appropriate fbdev drivers to be able to switch
>>>    back from graphics mode to text mode.
>> And a few drivers already do that, i810fb and rivafb.  Load rivafb or i810fb,
>> switch to graphics mode, unload, and you're back to text mode.
> 
> I though about being able to explicitly change mode from graphics to text 
> (for example when fbdev-only X switch to fbcon) while using fbdev.
 
This will require the following:

1. a generic text mode framebuffer driver, ie, an fbdev version of vgacon
2. a chipset driver that can fully restore VGA text mode.

The framebuffer layer already has helper functions that will save and restore
the standard VGA registers. It's the save/restore of extended registers that
only the chipset driver know about which is lacking.
 
Once the above 2 are satisfied, the infrastructure is already present that
will do what you want.

Tony
