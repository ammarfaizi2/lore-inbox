Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267364AbSLLAgx>; Wed, 11 Dec 2002 19:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267385AbSLLAgx>; Wed, 11 Dec 2002 19:36:53 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:4349 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S267364AbSLLAgw>; Wed, 11 Dec 2002 19:36:52 -0500
Date: Wed, 11 Dec 2002 16:43:48 -0800
From: Chris Wright <chris@wirex.com>
To: carbonated beverage <ramune@net-ronin.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: capable open_port() check wrong for kmem
Message-ID: <20021211164348.A26790@figure1.int.wirex.com>
Mail-Followup-To: carbonated beverage <ramune@net-ronin.org>,
	linux-kernel@vger.kernel.org
References: <20021210032242.GA17583@net-ronin.org> <at3v15$mur$1@abraham.cs.berkeley.edu> <20021210064134.GA17928@net-ronin.org> <20021210065159.GB17928@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021210065159.GB17928@net-ronin.org>; from ramune@net-ronin.org on Mon, Dec 09, 2002 at 10:51:59PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* carbonated beverage (ramune@net-ronin.org) wrote:
> 
> It's rather annoying and counter-intuitive to have:
> 
> crw-r-----    1 root     kmem       1,   2 Sep  8 21:56 /dev/kmem
> 
> but to have the following code fragment give:
> 
> int fd;
> 	fd = open("/dev/kmem", O_RDONLY);
> 	if(fd == -1) {
> 		fprintf(stderr, "Can't open /dev/kmem: %s\n", strerror(errno));
> 		exit(EXIT_FAILURE);
> 	}
> 
> Can't open /dev/kmem: Operation not permitted
> 
> with a user in the kmem group.
> 
> Also, the utility I'm writing doesn't need write access, so why give it to
> the process in the first place?

Then open O_RDONLY (with CAP_SYS_RAWIO).  Then the utility won't have
write access.  If that's all you are worried about.

or.

If you have only one capability (CAP_SYS_RAWIO), you are not owner of
/dev/kmem, you are in group kmem, and /dev/kmem is 0640, then all you will
get is read-only access to /dev/kmem.  This does not require kernel changes.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
