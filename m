Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbUEWCnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbUEWCnR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 22:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbUEWCnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 22:43:17 -0400
Received: from zasran.com ([198.144.206.234]:15747 "EHLO zasran.com")
	by vger.kernel.org with ESMTP id S262079AbUEWCnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 22:43:15 -0400
Message-ID: <40B00FBD.8030506@bigfoot.com>
Date: Sat, 22 May 2004 19:43:09 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: how to make side button (button 6) work with kernel 2.6.5 (logitech
 mouseman)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   I have the Logitech Cordless MouseMan Wheel mouse and while it's
mostly working I can't get the side button to work (used to be button 6
when I was using kernel 2.4.x).

   the problem is that side button is same as button 2 (clicking the
wheel), as verified by xev.

   I use psmouse moudule, here's what syslog says when I modprobe psmouse:

/var/log/syslog.0:May 10 23:30:27 jojda kernel: input: ImPS/2 Logitech
Wheel Mouse on isa0060/serio1

   and here's my X config for mouse:


Section "InputDevice"
	Identifier	"Logitech Cordless MouseMan Wheel"
	Driver		"mouse"
	Option		"CorePointer"
	# Option		"Protocol"		"MouseManPlusPS/2"
	Option		"Protocol"		"ExplorerPS/2"
	Option		"Device"		"/dev/psaux"
	Option		"Emulate3Buttons"	"false"
	Option		"Buttons"		"6"
	Option		"ZAxisMapping"		"5 6"
	Option		"SendCoreEvents"	"true"
EndSection

and here's modmap that used to work with kernel 2.4.x (it still sort of
works, the wheel is usable)

xmodmap -e "pointer = 1 2 3 6 4 5"

   other combinations I tried:

Option		"Protocol"		"ExplorerPS/2"
Option		"ZAxisMapping"		"4 5"
no xmodmap mapping

Option		"Protocol"		"ImPS/2"
Option		"ZAxisMapping"		"4 5"
no xmodmap mapping

   got same results, both wheel and side button act as button 2.

   I also tried "ZAxisMapping"		"4 5" and xmodmap -e "pointer = 1 2 3 6 
4 5", that make turning the wheel become button 4 and 6, looks like side 
button is always mapped to wahtever button 2 is mapped to, e.g. xmodmap 
-e "pointer = 1 6 3 4 5 2" results in side button and wheel click to 
become button 6 (is it kernel module that does that?)

   TIA

	erik

