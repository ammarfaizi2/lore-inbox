Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWCUEXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWCUEXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 23:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWCUEXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 23:23:09 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:38633 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965018AbWCUEXI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 23:23:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p5TWMaRkFDAGMR454z7bTmlDK02a8FgPTlBF60bY2SXOpMpShizxZMoxx9rLmssjDq5+ijiaYJW5o73N7R6i+ZW3gSVrVMyiDtwTDPg9AJj/Os5Kb9sAXd6nW+KoUrWIqUZgFX9L78+wFq6ljI4CegUl51vSHyCS0jYJHNPUsLs=
Message-ID: <38c09b90603202023s6c495cceu683db19c68fcc5e0@mail.gmail.com>
Date: Tue, 21 Mar 2006 12:23:07 +0800
From: "Lanslott Gish" <lanslott.gish@gmail.com>
To: "Daniel Ritz" <daniel.ritz-ml@swissonline.ch>
Subject: Re: [RFC][PATCH] USB touch screen driver, all-in-one
Cc: "Greg KH" <greg@kroah.com>, "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb <linux-usb-devel@lists.sourceforge.net>, tejohnson@yahoo.com,
       hc@mivu.no, vojtech@suse.cz
In-Reply-To: <200603172250.16667.daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <38c09b90603100124l1aa8cbc6qaf71718e203f3768@mail.gmail.com>
	 <200603152253.24194.daniel.ritz-ml@swissonline.ch>
	 <38c09b90603161846n47b5d47fnc6b4d4b9ff2d078b@mail.gmail.com>
	 <200603172250.16667.daniel.ritz-ml@swissonline.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/06, Daniel Ritz <daniel.ritz-ml@swissonline.ch> wrote:
> On Friday 17 March 2006 03.46, Lanslott Gish wrote:
> > On 3/16/06, Daniel Ritz <daniel.ritz-ml@swissonline.ch> wrote:
> > "invert" is great, thx.
> > evtouch(X11 driver) called these swap_x and swap_y
> >
>
> i think i drop it alltogether. as greg already mentioned it should be
> sysfs attributes. ( besides it's completely doable in userspace. and
> evtouch can do it. )
>
> >
> >
> > BTW, may i also suggest add more module_param to max_x, max_y, min_x, min_y  ?
> > i think these options is useful, too.
>
> no chance. (and if i remember correctly it's possible via evdev ioctl)
>


i could use my device in X without evtouch.o or any X-module or any
xorg.conf modified, but wrong positions to cursor.

and consider using touchscreens in console(framebuffer) mode, or
without evtouch in X, or devices do not provide several functions.

suppose we can something in /etc/rc.d/rc.local or some files:

/sbin/modprobe usbtouchscreen swap_xy=1,min_x=123,max_y=456,....

we don't need any calibrate tool or guest several functions from
devices, and complete this module.



Anyway, just some suggestions. thx :)

regards,

Lanslott Gish



> > > >
> > > >  /* device specifc data/functions */
> > > > @@ -224,13 +231,17 @@
> > > >   * PanJit Part
> > > >   */
> > > >  #ifdef CONFIG_USB_TOUCHSCREEN_PANJIT
> > > > +
> > > >  static int panjit_read_data(char *pkt, int *x, int *y, int *touch, int *press)
> > > >  {
> > > > -       *x = pkt[1] | (pkt[2] << 8);
> > > > -       *y = pkt[3] | (pkt[4] << 8);
> > > > +       *x = (pkt[1] & 0x0F) | ((pkt[2]& 0xFF) << 8);
> > > > +       *y = (pkt[3] & 0x0F) | ((pkt[4]& 0xFF) << 8);
> > >
> > > that just can't be right. you probably mean
> > > +       *y = pkt[3] | ((pkt[4] & 0x0F) << 8);
> > >
> > > otherwise you mask out bits 4-7. but you want to limit it to 12 bits...
> > > (btw. no need for the & 0xFF mask since *pkt is char)
> > >
> >
> > you are right, sorry for my fault. the truely way is
> >

> >
> > still need 12 bits( 0x0FFF) and the masks to avoid get negative.
>
> my latest patch has it right. and no, you don't need the mask for the lower
> 8 bits, only for the upper 4.
>

--
L.G, Life's Good~
