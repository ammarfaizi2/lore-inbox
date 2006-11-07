Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752387AbWKGIPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbWKGIPt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 03:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754090AbWKGIPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 03:15:49 -0500
Received: from fmx12.freemail.hu ([195.228.245.62]:38546 "HELO
	fmx12.freemail.hu") by vger.kernel.org with SMTP id S1752387AbWKGIPs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 03:15:48 -0500
Date: Tue, 7 Nov 2006 09:15:43 +0100 (CET)
From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: Re: [PATCH] input: map BTN_FORWARD to button 2 in mousedev
To: Dmitry Torokhov <dtor@insightbb.com>
cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <d120d5000611061448p73bcfec5xb91bb4f454312eb9@mail.gmail.com>
Message-ID: <freemail.20061007091543.11068@fm05.freemail.hu>
X-Originating-IP: [80.98.105.91]
X-HTTP-User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Firefox/1.5.0.7
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
X-Freemail: message scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dmitry Torokhov <dtor@insightbb.com> wrote:

> On 11/5/06, Németh Márton <nm127@freemail.hu> wrote:
> > From: Márton Németh <nm127@freemail.hu>
> >
> > In mousedev the BTN_LEFT and BTN_FORWARD were mapped to
mouse button 0, causing
> > that the user space program cannot distinguish between
them through /dev/input/mice.
> > The BTN_FORWARD is currently used in the synaptics.c,
logips2pp.c and in alps.c. All
> > mice have BTN_LEFT, but not all have BTN_MIDDLE (e.g.
Clevo D410J laptop). Mapping
> > BTN_FORWARD to mouse button 2 makes the BTN_FORWARD
button useful on the mentioned
> > laptop.
> >
> 
> I'd rather not touch mappings in legacy mousedev driver. I
believe
> both synaptics and evdev X drivers will correctly recognize
> BTN_FORWARD, is there any reason you are not using them?

If I have understand the input subsystem correctly, for the
evdev X driver the mousedev.c is not needed, so using an
evdev X driver is a completely other story. This map change
could result that the BTN_FORWARD can be used as BTN_MIDDLE
out of the box, without any additional drivers, so it is
simpler (at least in case of Clevo D410J).

My patch is based on the assumption that every mouse has
BTN_LEFT, so it is not worth having two mouse buttons for
the same function. (For Clevo D410J it is actually an
information loss at this point.)

Next thing is that the BTN_FORWARD and BTN_BACK usually
comes together. The BTN_LEFT and BTN_RIGHT usually comes
together also. For the mapping I see some possible mapping
listed in the following table:

    Button name    |     (a)     |     (b)     |     (c)     |
    ---------------+-------------+-------------+-------------+
    BTN_LEFT       |      0      |      0      |      0      |
    BTN_RIGHT      |      1      |      1      |      1      |
    BTN_FORWARD    |      0      |      2      |      0      |
    BTN_BACK       |      1      |      3      |      3      |

Mapping (a) would map BTN_FORWARD and BTN_BACK to BTN_LEFT
and BTN_RIGHT. Mapping (b) would map all 4 buttons to
different buttons. Mapping (c) is the current mapping where
the BTN_FORWARD is handled differently than BTN_BACK.

        NMarci

___________________________________________________________________________
Karácsonyi sorban állás helyett vásároljon kényelmesen! Garantáltan 1 nap alatt szállítjuk a megrendelt könyveket!
http://www.bookline.hu/control/news?newsid=528&affiliate=frenapkar3171

