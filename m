Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314987AbSEHTz5>; Wed, 8 May 2002 15:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315048AbSEHTzz>; Wed, 8 May 2002 15:55:55 -0400
Received: from w007.z208177141.sjc-ca.dsl.cnc.net ([208.177.141.7]:56977 "HELO
	mail.gurulabs.com") by vger.kernel.org with SMTP id <S314987AbSEHTzw>;
	Wed, 8 May 2002 15:55:52 -0400
Date: Wed, 8 May 2002 13:55:51 -0600 (MDT)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@mooru.gurulabs.com
To: "chris@scary.beasts.org" <chris@scary.beasts.org>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "marcelo@conectiva.com.br" <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Completely honor prctl(PR_SET_KEEPCAPS, 1)
In-Reply-To: <Pine.LNX.4.33.0205082029060.14553-100000@sphinx.mythic-beasts.com>
Message-ID: <Pine.LNX.4.44.0205081341160.10496-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2002, chris@scary.beasts.org wrote:

> This is a change of behaviour in a fairly security sensitive area, so I'd
> like us to step back and ask - should we fix the code or the comment?
> 
> An application using prctl()[1] is capability aware. I think it is fair
> (and more secure) if we require these applications to explicitly request
> raising capabilities in the effective set, after the switch from euid == 0
> to euid != 0.
> 
> Comments?

With the current behaviour an app has to link against libcap and do:

prtctl(PR_SET_KEEPCAPS, 1)
pre_caps = (capgetp(0, cap_init())  // save our caps into a struct
setuid(uid)  
setgid(gid)
capsetp(0,pre_caps)  // Restore them

With this patch, the app does:

prtctl(PR_SET_KEEPCAPS, 1)
setuid(uid)
setgid(gid)

The end result is exactly the same.  I'm trying to envision how this patch
would change security in a negative way.  I keep coming back to the Unix
idea of "don't be smarter than the admin; don't try to protect root from
himself". 

Maybe we could enchance PR_SET_KEEPCAPS so that:

prtctl(PR_SET_KEEPCAPS, 2) kept both the permitted and the effective caps.

Dax Kelson
Guru Labs

