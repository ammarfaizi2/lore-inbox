Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314758AbSEHSVm>; Wed, 8 May 2002 14:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314787AbSEHSVl>; Wed, 8 May 2002 14:21:41 -0400
Received: from codepoet.org ([166.70.14.212]:17886 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S314758AbSEHSVk>;
	Wed, 8 May 2002 14:21:40 -0400
Date: Wed, 8 May 2002 12:21:39 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020508182139.GA22659@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Padraig Brady <padraig@antefacto.com>,
	Anton Altaparmakov <aia21@cantab.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD8DAA2.6080907@evision-ventures.com> <E175QP9-0001RO-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed May 08, 2002 at 01:18:47PM +0100, Alan Cox wrote:
> I can't speak directly for the Kudzu maintainer but I can say that having
> a sane way to obtain the list of ide devices (all of them not just non 
> pcmcia) and the device bindings/type has been a long standing request.

Can't one simply do something like:

char device_string[20];
int i, type, major=0, minor=0;
for(i=0; i<26; i++) {
    snprintf(device_string, sizeof(device_string), "/dev/hd%c", 'a'+i);
    if ((fd=open(device_string, O_RDONLY | O_NONBLOCK)) < 0) {
	continue;
    }
    switch ('a'+i) {
	case 'a':
	    major=3;minor=0;
	    break;
	case 'b':
	    major=3;minor=64;
	    break;
	case 'c':
	    major=22;minor=0;
	    break;
	case 'd':
	    major=22;minor=64;
	    break;
	.....
    }

etc.... to detect the available ide devices without groveling
through /proc/ide?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
