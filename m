Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316217AbSFEUIe>; Wed, 5 Jun 2002 16:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316243AbSFEUId>; Wed, 5 Jun 2002 16:08:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:24556 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316217AbSFEUIb>; Wed, 5 Jun 2002 16:08:31 -0400
Date: Wed, 5 Jun 2002 22:08:26 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Joseph Pingenot <trelane@digitasaru.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Build error on 2.5.20 under unstable debian
In-Reply-To: <20020605122129.A14027@ksu.edu>
Message-ID: <Pine.NEB.4.44.0206052203260.11522-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002, Joseph Pingenot wrote:

> Ah.  What does __devexit_p() do?  It looks to be some sort of macro,
>   doing a cast?
>...

No, look at the definition in include/linux/init.h:

<--  snip  -->

...
/* Functions marked as __devexit may be discarded at kernel link time, depending
   on config options.  Newer versions of binutils detect references from
   retained sections to discarded sections and flag an error.  Pointers to
   __devexit functions must use __devexit_p(function_name), the wrapper will
   insert either the function_name or NULL, depending on the config options.
 */
#if defined(MODULE) || defined(CONFIG_HOTPLUG)
#define __devexit_p(x) x
#else
#define __devexit_p(x) NULL
#endif
...

<--  snip  -->


A bit more of explanation is in Documentation/pci.txt.


> -Joseph

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

