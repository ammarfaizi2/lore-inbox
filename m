Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265341AbUEZHym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265341AbUEZHym (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 03:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265342AbUEZHym
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 03:54:42 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:35463 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S265341AbUEZHyi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 03:54:38 -0400
To: Chris Osicki <osk@osk.ch>
Cc: linux-kernel@vger.kernel.org
References: <20040525201616.GE6512@gucio>
Subject: Re: keyboard problem with 2.6.6
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 26 May 2004 09:54:36 +0200
Message-ID: <xb7hdu3fwsj.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Chris" == Chris Osicki <osk@osk.ch> writes:

    Chris> Hi

    Chris> I recently moved to kernel 2.6.6 from 2.4.26 and noticed
    Chris> that four keys on my keyboard stopped working.

Congratulations, you've  hit the most  annoying (IMO) part of  the new
'features' in 2.6.6: the new input subsystem.


    Chris> The kernel reports:

    Chris> 	keyboard: unrecognized scancode (XX) - ignored

    Chris> Where XX is 71, 72, 74, 75.

They  have rewritten the  kernel keyboard  and mouse  drivers, causing
lots of problems  to people who switch from  2.4.  What's worse: there
is no way back.  No backward-compatibility to 2.4 behaviours have been
provided, because some kernel  developers believe the new input system
is "perfect",  so perfect  that no one  would want the  old behaviours
anymore.
See also: http://www.informatik.uni-freiburg.de/~danlee/fun/psaux/




    Chris> I tried to solve my problem using setkeycodes and tried:

    Chris> setkeycodes 71 101

    Chris> as 101 was unused keycode (according to getkeycodes)

I don't think you should invent your own keycodes, given that the
following appears in linux-2.6.*/include/linux/input.h

        #define KEY_STOP                128
        #define KEY_AGAIN               129
        #define KEY_PROPS               130
        #define KEY_UNDO                131
        #define KEY_FRONT               132
        #define KEY_COPY                133
        #define KEY_OPEN                134
        #define KEY_PASTE               135
        #define KEY_FIND                136
        #define KEY_CUT                 137
        #define KEY_HELP                138
        #define KEY_MENU                139
        #define KEY_CALC                140

I'm not sure if the configs of XFree86 need any further adjustments.


    Chris> I would be very thankful if somebody could help me to
    Chris> understand what's going on

The keyboard driver has changed, and hence the behaviour.

It also affects my notebook: The SysRq key activated by some [Fn]- key
combo does not work  anymore.  It DID work in 2.4.  On  2.6, I have to
use  Alt-PrintScreen  instead.  The  atkbd  keyboard  driver seems  to
assume that  SysRq ==  Alt-PrintScreen in all  cases, which  is simply
wrong!


    Chris> and how can I get my  keys working again.  

Lobby the input system developers, emphasizing that COMPATIBILITY with
2.4 behaviours is desired  and important.  Without a smooth transition
path, people will be reluctant to migrate to 2.6.


    Chris> There must be a good reason for the change from 2.4.x to
    Chris> 2.6.x which escapes me.

Yeah.   They   say  the  input  system  "unifies"   the  interface  to
keyboard/mouse  devices.   They're   also  proud  that  the  in-kernel
keyboard/mouse drivers  are supporting more and more  devices.  But at
the same  time, they're sacrificing  flexibility by moving  many codes
into kernel.   (GPM supports more  mouse types!)  The new  system also
breaks backward compatibility.



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

