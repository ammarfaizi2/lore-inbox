Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279791AbRJ0HzF>; Sat, 27 Oct 2001 03:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279792AbRJ0Hyy>; Sat, 27 Oct 2001 03:54:54 -0400
Received: from torvi.fmi.fi ([193.166.211.16]:14355 "EHLO torvi.fmi.fi")
	by vger.kernel.org with ESMTP id <S279791AbRJ0Hyj>;
	Sat, 27 Oct 2001 03:54:39 -0400
From: Kari Hurtta <hurtta@leija.mh.fmi.fi>
Message-Id: <200110270755.f9R7t9hh028454@leija.fmi.fi>
Subject: Re: [off topic?] Re: [PATCH] strtok --> strsep in framebuffer drivers
 (part 2)
In-Reply-To: <200110270700.f9R70AkT028190@leija.fmi.fi>
Date: Sat, 27 Oct 2001 10:55:09 +0300 (EEST)
CC: =?ISO-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@loewe-komp.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL95a (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=ISO-8859-1
X-Filter: torvi: 2 received headers rewritten with id 20011027/24797/01
X-Filter: torvi: ID 23602, 1 parts scanned for known viruses
X-Filter: leija.fmi.fi: ID 23375, 1 parts scanned for known viruses
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > René Scharfe wrote:
> 
> > NAME
> >        strsep - extract token from string
> > [...]
> > RETURN VALUE
> >        The strsep() function returns a pointer to the  token,  or
> >        NULL if delim is not found in stringp.
> > 
> > If strsep returns NULL, and you dereference it -> Oops.
> > 
> > 
> > ! if (!this_opt)
> > 	continue;
> 
> Is that manual page incorrect?
> 
> I would think that 
> 
> 	strsep() returns NULL  when *stringp points to '\0' character
> 	
> 	and that if delim is not found in stringp then stringp
> 	is just advanced to '\0' character of string (and original
> 	*stringp value is returned)
> 
> If that is not true, then these all patches are incorrect.
> Namely last token will be skipped.

Seems that I have also good to talk to mayself....

lib/string.c tells truth.

strsep() returns NULL when *stringp is NULL.

if delim is not found *stringp is set to NULL (and original
*stringp value is returned).

Because kernel code claims that 

 * It returns empty tokens, too, behaving exactly like the libc function
 * of that name. In fact, it was stolen from glibc2 and de-fancy-fied.
 * Same semantics, slimmer shape. ;)

quoted manual page IS incorrect (at least if it describes glibc2 function.)

-- 
          /"\                           |  Kari 
          \ /     ASCII Ribbon Campaign |    Hurtta
           X      Against HTML Mail     |
          / \                           |
