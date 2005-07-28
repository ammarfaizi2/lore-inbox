Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVG1UxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVG1UxG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVG1Uur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:50:47 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:52232 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262194AbVG1UuJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:50:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SlCiDvOdjBu+E/GKxEdKZgtVXizl1UNRE1nxY5zvTrSumBZrrza9aObbLw2Mtvqbj7BSHBHNgQQs1mqpRE6PlUtjnFktkVIc5zrZBuCJ1Il7QWssKlJGCVjdCcLoqtiVdIptvQDFi/ZhdHcpqFZT6ueVkDgkl5DyOsVty1iUetw=
Message-ID: <9e47339105072813507c00687e@mail.gmail.com>
Date: Thu, 28 Jul 2005 16:50:08 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] fbdev: colormap fixes
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339105072813213db7cee4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200507280031.j6S0V3L3016861@hera.kernel.org>
	 <Pine.LNX.4.62.0507280952140.24391@numbat.sonytel.be>
	 <9e473391050728060741040424@mail.gmail.com>
	 <42E8F0CD.6070500@gmail.com>
	 <Pine.LNX.4.62.0507281758080.24391@numbat.sonytel.be>
	 <9e473391050728092936794718@mail.gmail.com>
	 <9e47339105072811183ac0f008@mail.gmail.com>
	 <Pine.LNX.4.62.0507282202450.29876@numbat.sonytel.be>
	 <9e4733910507281315419c3c12@mail.gmail.com>
	 <9e47339105072813213db7cee4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've verified now that all ATI R300+ chips have 10bit cmaps. These are
pretty common so I'd be in favor of making this into a binary
attribute where I can get/set the whole table at once. Given that
OpenGL is already supporting 12 and 16 bits these tables are only
going to get much larger.

1024 entries * 5 fields * 2 bytes = 10KB -- too big for a text attribute.

65536 entries * 5 fields * 2 bytes = 655KB -- way too big for a text attribute.

The bits_per_pixel sysfs attribute is an easy way to tell how many
entries you need. You can just set it at 4, 8, 10, etc until you get
an error. Now you know the max. 2^n and you know how many entries.

-- 
Jon Smirl
jonsmirl@gmail.com
