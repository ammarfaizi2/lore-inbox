Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318116AbSGMHee>; Sat, 13 Jul 2002 03:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318117AbSGMHed>; Sat, 13 Jul 2002 03:34:33 -0400
Received: from emory.viawest.net ([216.87.64.6]:36260 "EHLO emory.viawest.net")
	by vger.kernel.org with ESMTP id <S318116AbSGMHed>;
	Sat, 13 Jul 2002 03:34:33 -0400
Date: Sat, 13 Jul 2002 00:37:17 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Ed Sweetman <safemode@speakeasy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020713073717.GA9203@wizard.com>
References: <1026545050.1203.116.camel@psuedomode>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026545050.1203.116.camel@psuedomode>
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.5.25 (i686)
X-uptime: 12:30am  up 22:15,  2 users,  load average: 0.01, 0.00, 0.00
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2002 at 03:24:09AM -0400, Ed Sweetman wrote:
> Same config as in my last post about the issue linking with this
> kernel.  I'm having my keyboard just not respond from boot.  I've got
> Input Device support built in and i had it as module and the keyboard is
> ps/2.  No idea what's going on here 
> 

        Just a "me too" here.. I've had this problem since around 2.5.15-dj 
and later, and have had input and keyboard support compiled into the kernel. 
Luckily I was able to get into the box via ssh, and check things. both 
keyboard and mouse are PS/2. If possible, see if you can do this, and check if 
IRQ 1 is not listed in /proc/interrupts. That is what is happening with me, 
while my mouse is working. For me to get my keyboard to work, I have to have 
the following set:

CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_EVBUG=y
CONFIG_SERIO=y
CONFIG_SERIO_SERPORT=m
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KEYBOARD_XTKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y

        This leaves me without using the new Input API, but with a working 
keyboard. with using the new API, mouse will work, keyboard will not. you can 
try these, and use the old setup (I assume will be made legacy by the time 2.6 
comes out), and let me know if they work. The new API seems to be working for 
some people, but not all.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

