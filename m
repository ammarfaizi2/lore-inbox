Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267039AbTBTVuO>; Thu, 20 Feb 2003 16:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbTBTVuN>; Thu, 20 Feb 2003 16:50:13 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:35138 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S267039AbTBTVuK>; Thu, 20 Feb 2003 16:50:10 -0500
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302201951270.20350-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0302201951270.20350-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1045778401.1201.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Feb 2003 06:00:53 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-21 at 03:58, James Simmons wrote:
> 
> > I was for five weeks in U.S., so I did not do anything with
> > matroxfb during that time. I plan to use fillrect and copyrect
> > from generic code 
> 
> I have ported the accelerated functions to the new api. What is left is to 
> deal with the loadfont and putcs issue which I'm working on the code right 
> now.
> 
> > (although it means unnecessary multiply on
> > generic side, and division in matroxfb, 
> 
> ????
> 
> > but well, if we gave
> > up on reasonable speed for fbdev long ago...). 
> 
> This is not true. Several benchmarks have shown a large performance 
> improvement in 2.5.X.
> 

2.5.x might be a bit slower with bpp8 but at higher color depths is
significantly faster. And this is done with a single generic color
exapnd function that replaces the entire fbcon-cfb*.c in 2.4.  And it
will theoretically still draw correctly whatever the condition is (any
bpp from  1-32,  unaligned origin, pitch, width, etc). 

Drivers with accelerated color expansion, if done correctly, _should_
perform better whatever the color depth.  

However, using fonts with widths not divisible by 8 will be several
folds slower.  This should be helped if we add some form of tile/texture
blitting support to fbdev.

Note: I cannot test with 12x22 fonts in 2.4 because some/most drivers do
not support it.

Tony

no accel
scrollmode: yredraw
font: 8x16
visual: packed pixels

time cat /usr/src/linux/MAINTAINERS

linux-2.4.20

bpp8
----
real    0m2.499s
user    0m0.000s
sys     0m2.500s

bpp16
-----
real    0m8.324s
user    0m0.000s
sys     0m8.320s

bpp24
-----
real    0m12.364s
user    0m0.000s
sys     0m12.370s

bpp32
-----
real    0m16.274s
user    0m0.000s
sys     0m16.280s

linux-2.5.62

bpp8
----
real    0m2.557s
user    0m0.003s
sys     0m2.553s

bpp16
-----
real    0m4.051s
user    0m0.002s
sys     0m4.050s

bpp24
-----
real    0m9.520s
user    0m0.000s
sys     0m9.520s

bpp32
-----
real    0m7.496s
user    0m0.002s
sys     0m7.494s

