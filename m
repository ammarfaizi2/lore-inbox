Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268351AbUIMPH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268351AbUIMPH3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 11:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbUIMPFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 11:05:22 -0400
Received: from pimout7-ext.prodigy.net ([207.115.63.58]:34045 "EHLO
	pimout7-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S267660AbUIMOww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 10:52:52 -0400
Date: Mon, 13 Sep 2004 10:52:14 -0400 (EDT)
From: Vladimir Dergachev <volodya@mindspring.com>
X-X-Sender: volodya@node2.an-vo.com
Reply-To: Vladimir Dergachev <volodya@mindspring.com>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
cc: Dave Airlie <airlied@linux.ie>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jon Smirl <jonsmirl@gmail.com>,
       Felix =?ISO-8859-1?Q?K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
In-Reply-To: <1095036743.22137.48.camel@admin.tel.thor.asgaard.local>
Message-ID: <Pine.LNX.4.61.0409131047060.4885@node2.an-vo.com>
References: <E3389AF2-0272-11D9-A8D1-000A95F07A7A@fs.ei.tum.de> 
 <Pine.LNX.4.58.0409100209100.32064@skynet>  <9e47339104090919015b5b5a4d@mail.gmail.com>
  <20040910153135.4310c13a.felix@trabant>  <9e47339104091008115b821912@mail.gmail.com>
  <1094829278.17801.18.camel@localhost.localdomain>  <9e4733910409100937126dc0e7@mail.gmail.com>
  <1094832031.17883.1.camel@localhost.localdomain>  <9e47339104091010221f03ec06@mail.gmail.com>
  <1094835846.17932.11.camel@localhost.localdomain>  <9e47339104091011402e8341d0@mail.gmail.com>
  <Pine.LNX.4.58.0409102254250.13921@skynet>  <1094853588.18235.12.camel@localhost.localdomain>
  <Pine.LNX.4.58.0409110137590.26651@skynet>  <1094912726.21157.52.camel@localhost.localdomain>
  <Pine.LNX.4.58.0409122319550.20080@skynet>  <1095035276.22112.31.camel@admin.tel.thor.asgaard.local>
  <Pine.LNX.4.61.0409122042370.9611@node2.an-vo.com>
 <1095036743.22137.48.camel@admin.tel.thor.asgaard.local>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811584-1127454695-1095087134=:4885"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811584-1127454695-1095087134=:4885
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Sun, 12 Sep 2004, Michel [ISO-8859-1] D=E4nzer wrote:

> On Sun, 2004-09-12 at 20:45 -0400, Vladimir Dergachev wrote:
>>
>> On Sun, 12 Sep 2004, Michel [ISO-8859-1] Dnzer wrote:
>>
>>> On Sun, 2004-09-12 at 23:42 +0100, Dave Airlie wrote:
>>>>
>>>> I think yourself and Linus's ideas for a locking scheme look good, I a=
lso
>>>> know they won't please Jon too much as he can see where the potential
>>>> ineffecienes with saving/restore card state on driver swap are, especa=
illy
>>>> on running fbcon and X on a dual-head card with different users.
>>>
>>> Frankly, I don't understand the fuss about that. When you run a 3D
>>> client on X today, 3D client and X server share the accelerator with
>>> this scheme, and as imperfect as it is, it seems to do a pretty good jo=
b
>>> in my experience.
>>
>> Not that good - try dragging something while a DVD video is playing.
>
> What are you getting at?

The overlay window is currently using part of what is being proposed by
"multiple drivers" proponents. It has to make engine queiscent so it can=20
write data directly to the video memory. It does *not* have to save the=20
state.

So, as Jon rightly points out the "multiple drivers" scheme only makes=20
sense in the current usage patter - you either use X or framebuffer, never=
=20
both at the same time and you consider a few seconds per switch normal.
(Not that it actually has to take few seconds, I am just pointing out the=
=20
the expectations are well below what we do now)

However, if we want the switch from X to framebuffer to be as fast as=20
switching between different text consoles (assuming they have the same=20
resolution) and if we want to be able to run different Xservers on=20
different consoles or Xserver+framebuffer combinations Jon's proposal=20
wins.

                        best

                           Vladimir Dergachev

>
>
> --=20
> Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI devel=
oper
> Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenze=
r
>
---1463811584-1127454695-1095087134=:4885--
