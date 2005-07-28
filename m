Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261548AbVG1Vuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVG1Vuk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 17:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVG1Vuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 17:50:40 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:54045 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261531AbVG1Vuc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 17:50:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kiF+nC4mQ5LABDZhtvBnrOJzAE7IOunOiAh5mVpqsRIcucJl641roMxbpvmDZUjVr54mYGVjhqd1y6LFPCyOJ9Cl9F2lQuYqh3PDf/QSfelWNgBWcERsLmEbLTGbdbPja/qlsIM5uajb3ddtTfz8Ui+dgSU5gBCkzLIxm+TI+xA=
Message-ID: <9e47339105072814505b6fe4f8@mail.gmail.com>
Date: Thu, 28 Jul 2005 17:50:30 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: colormap fixes
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0507282337410.29876@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507280031.j6S0V3L3016861@hera.kernel.org>
	 <42E8F0CD.6070500@gmail.com>
	 <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
	 <9e473391050728092936794718@mail.gmail.com>
	 <9e47339105072811183ac0f008@mail.gmail.com>
	 <Pine.LNX.4.62.0507282202450.29876@numbat.sonytel.be>
	 <9e4733910507281315419c3c12@mail.gmail.com>
	 <9e47339105072813213db7cee4@mail.gmail.com>
	 <9e47339105072813507c00687e@mail.gmail.com>
	 <Pine.LNX.4.62.0507282337410.29876@numbat.sonytel.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/05, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, 28 Jul 2005, Jon Smirl wrote:
> > I've verified now that all ATI R300+ chips have 10bit cmaps. These are
> > pretty common so I'd be in favor of making this into a binary
> > attribute where I can get/set the whole table at once. Given that
> > OpenGL is already supporting 12 and 16 bits these tables are only
> > going to get much larger.
> >
> > 1024 entries * 5 fields * 2 bytes = 10KB -- too big for a text attribute.
> >
> > 65536 entries * 5 fields * 2 bytes = 655KB -- way too big for a text attribute.
> >
> > The bits_per_pixel sysfs attribute is an easy way to tell how many
> > entries you need. You can just set it at 4, 8, 10, etc until you get
> > an error. Now you know the max. 2^n and you know how many entries.
> 
> No, bits_per_pixel can be (much) larger than the color map size. E.g. a simple
> ARGB8888 directcolor mode has bits_per_pixel = 32 and color map size = 256.

So I have the bits_per_pixel attribute wrong in sysfs. It needs to be
bits_per_color and then let the driver sort it out.  Otherwise there
is no way to set ARGB8888 versus ARGB2101010. With bits per color you
would set 8 or 10.

If that isn't good enough I can switch the attribute to take strings
like ARGB8888.

What do you think, should I just switch to fbconfig names and a binary
cmap attribute?

-- 
Jon Smirl
jonsmirl@gmail.com
