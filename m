Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266678AbSLJGrQ>; Tue, 10 Dec 2002 01:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266686AbSLJGrQ>; Tue, 10 Dec 2002 01:47:16 -0500
Received: from h24-80-147-251.no.shawcable.net ([24.80.147.251]:9478 "EHLO
	antichrist") by vger.kernel.org with ESMTP id <S266678AbSLJGrO>;
	Tue, 10 Dec 2002 01:47:14 -0500
Date: Mon, 9 Dec 2002 22:51:59 -0800
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: Re: capable open_port() check wrong for kmem
Message-ID: <20021210065159.GB17928@net-ronin.org>
References: <20021210032242.GA17583@net-ronin.org> <at3v15$mur$1@abraham.cs.berkeley.edu> <20021210064134.GA17928@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021210064134.GA17928@net-ronin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

forgot to cc: linux-kernel:

Hi,

On Tue, Dec 10, 2002 at 05:45:09AM +0000, David Wagner wrote:
> Read-only access to /dev/kmem is probably enough to get root access
> (maybe you can snoop root's password, for instance).  This would make
> the power of the two capabilities roughly equivalent, so if this is true,
> I'm not sure I understand the point of splitting them in two this way.

It's rather annoying and counter-intuitive to have:

crw-r-----    1 root     kmem       1,   2 Sep  8 21:56 /dev/kmem

but to have the following code fragment give:

int fd;
	fd = open("/dev/kmem", O_RDONLY);
	if(fd == -1) {
		fprintf(stderr, "Can't open /dev/kmem: %s\n", strerror(errno));
		exit(EXIT_FAILURE);
	}

Can't open /dev/kmem: Operation not permitted

with a user in the kmem group.

Also, the utility I'm writing doesn't need write access, so why give it to
the process in the first place?

-- DN
Daniel
