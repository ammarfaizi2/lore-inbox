Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTGASDn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbTGASDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:03:43 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:22461 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263205AbTGASDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:03:42 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [RFC/PATCH] Touchpads in absolute mode (synaptics) and mousedev
Date: Tue, 1 Jul 2003 13:18:27 -0500
User-Agent: KMail/1.5.1
Cc: LKML <linux-kernel@vger.kernel.org>, linux-usb-devel@lists.sourceforge.net
References: <200307010303.53405.dtor_core@ameritech.net> <1057060977.603.10.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1057060977.603.10.camel@teapot.felipe-alfaro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307011318.27564.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 July 2003 07:02 am, Felipe Alfaro Solana wrote:
> On Tue, 2003-07-01 at 10:03, Dmitry Torokhov wrote:
> > - touchpads are not precise; when I take my finger off touchpad and then
> >   touch it again somewhere else I do not expect my cursor jump anywhere,
> >   I only expect cursor to move when I move my finger while pressing
> >   touchpad.
>
> Uhmmm... Maybe I'm losing something here, but my NEC Chrom@'s
> ALPS/GlidePoint touchpad doesn't cause the mouse cursor to jump/move
> when I lift off my finger from it and then touch it again elsewhere. The
> mouse cursor moves only when I drag my finger over the touchpad surface.
>

Apologies if you seen this already but it seems the list ate my previous 
replies...

My touchpad works well in relative mode, it's new synaptics driver code 
in 2.5 that switches the touchpad in absolute mode that gives me trouble. 
Right now in stock kernel synaptics driver does not register with 
mousedev and only provides /dev/input/eventX interface. I want it to also 
plug in into /dev/input/mouseX and /dev/psaux so programs that do not 
have special code for event processing could still use it. The problem 
is that conversion from absolute to relative mode in mousedev isn't 
working well for touchpads. When to take your finger off touchpad and
touch it in other place mousedev does not account for that and calculates
huge delta which causes your cursor to jump.

Dmitry 
 
