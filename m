Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbVBCUEf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbVBCUEf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 15:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbVBCUCP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 15:02:15 -0500
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:53404 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263627AbVBCTwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 14:52:03 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [PATCH 2.6] 4/7 replace uml_strdup by kstrdup
Date: Thu, 3 Feb 2005 20:51:17 +0100
User-Agent: KMail/1.7.2
Cc: Paulo Marques <pmarques@grupopie.com>, Pekka Enberg <penberg@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       penberg@cs.helsinki.fi
References: <1107228511.41fef75f4a296@webmail.grupopie.com> <84144f02050201235257d0ec1c@mail.gmail.com> <4200BFA1.2060808@grupopie.com>
In-Reply-To: <4200BFA1.2060808@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502032051.18191.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 February 2005 12:55, you wrote:
> Pekka Enberg wrote:
> > On Tue,  1 Feb 2005 03:28:31 +0000, pmarques@grupopie.com
> >
> > <pmarques@grupopie.com> wrote:
> >>diff -buprN -X dontdiff
> >> vanilla-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c
> >> linux-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c ---
> >> vanilla-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c      
> >> 2004-12-24 21:35:40.000000000 +0000 +++
> >> linux-2.6.11-rc2-bk9/arch/um/os-Linux/drivers/tuntap_user.c 2005-01-31
> >> 20:39:08.591154025 +0000
> >
> > [snip]
> >
> >>-               pri->dev_name = uml_strdup(buffer);
> >>+               pri->dev_name = kstrdup(buffer);
> >
> > Please compile-test before submitting.
>
> I'm really sorry about this...
>
> I've compiled with an allyesconfig to validate the changes, but that
> doesn't build the UML parts :(

Well, the answer is to do add a "ARCH=um" to the build commands... you could 
maybe use a "make defconfig ARCH=um" however because UML itself, sometimes, 
does not build with allyesconfig /allmodconfig...

However, that said, there are bigger problems for UML.

Since of its particular nature, it contains some code which is compiled 
against userspace headers. For instance cow_user.c (the list includes 
*_user.c and everything that is explicitly listed in USER_OBJS inside the 
Makefiles)

So, for cow_user.c, when you add <linux/string.h> to cow_user.c, you are 
actually making it include /usr/include/linux/string.h...

For UML, you should probably add the prototype to a good header inside 
arch/um/include (those headers are in the searchpath for every file under 
arch/um) - probably the one which declared uml_strdup. Yes, we have had to 
duplicate prototypes for many functions... for inlines, we've had to provide 
in many case a non-inline version.

> Anyway, thanks for pointing this out. I still haven't got feedback
> regarding the acceptance of these patches. If there is a chance they're
> accepted, maybe the best thing to do is to post the series again with
> this correction and the sound patch corrections.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

