Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbVIAN5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbVIAN5Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 09:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbVIAN5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 09:57:25 -0400
Received: from nproxy.gmail.com ([64.233.182.204]:24639 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965109AbVIAN5Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 09:57:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AS/b8TDlP+bEU9+FDMENuwie5B58Nr815oEQ5az+1yAZjgczL+GwiMKPrTkWa7xQYNYZ1pBlpIVz6gSnPgXov4TZZjSFps0jqCNtFqPGUZPRTX+pXYJzPwayolMfO/c7F9dMWhxYl7LYgvfGmrXRIK3llAyIZ7/r2pIA81gYGkw=
Message-ID: <69304d110509010657d397a6f@mail.gmail.com>
Date: Thu, 1 Sep 2005 15:57:22 +0200
From: Antonio Vargas <windenntw@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: State of Linux graphics
Cc: Ian Romanick <idr@us.ibm.com>, Allen Akin <akin@pobox.com>,
       Discuss issues related to the xorg tree 
	<xorg@lists.freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1125570042.15768.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e47339105083009037c24f6de@mail.gmail.com>
	 <1125422813.20488.43.camel@localhost>
	 <20050831063355.GE27940@tuolumne.arden.org>
	 <1125512970.4798.180.camel@evo.keithp.com>
	 <20050831200641.GH27940@tuolumne.arden.org>
	 <1125522414.4798.222.camel@evo.keithp.com>
	 <20050901015859.GA11367@tuolumne.arden.org>
	 <43167150.1040808@us.ibm.com>
	 <69304d1105083123007c00f9e0@mail.gmail.com>
	 <1125570042.15768.3.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Iau, 2005-09-01 at 08:00 +0200, Antonio Vargas wrote:
> > 2. whole screen z-buffer, for depth comparison between the pixels
> > generated from each window.
> 
> That one I question in part - if the rectangles are (as is typically the
> case) large then the Z buffer just ups the memory accesses. I guess for
> round windows it might be handy.
> 

There are multiple ways to enhance the speed for zbuffer:

1. Use an hierarchical z-buffer

Divide the screen in 16x16 pixel tiles, and then a per-tile minimum
value. When rendering a poly, you first check the tile-z against the
poly-z and if it fails you can skip 256 pixels in one go.

2. Use scanline-major rendering:

for_each_scanline{
  clear_z_for_scanline();
  for_each_polygon{
    draw_pixels_for_current_polygon_and scanline();
  }
}

This is easily done by modeling the scanliner with a coroutine for each polygon
to be painted. The zbuffer is reduced to a scanline and is reused for
all scanlines,
so it's rather fast :)

-- 
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/

Las cosas no son lo que parecen, excepto cuando parecen lo que si son.
