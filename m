Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129112AbRCFS0d>; Tue, 6 Mar 2001 13:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129115AbRCFS0X>; Tue, 6 Mar 2001 13:26:23 -0500
Received: from cx866070-a.tucson1.az.home.com ([24.177.155.28]:33526 "EHLO
	aahz.klah.net") by vger.kernel.org with ESMTP id <S129112AbRCFS0N>;
	Tue, 6 Mar 2001 13:26:13 -0500
Date: Tue, 6 Mar 2001 11:36:29 -0700 (MST)
From: Jeff Coy <jcoy@klah.net>
Reply-To: jcoy@klah.net
To: Peter Samuelson <peter@cadcamlab.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: binfmt_script and ^M
In-Reply-To: <20010306121510.A28368@cadcamlab.org>
Message-ID: <Pine.LNX.4.10.10103061126490.27694-100000@aahz.klah.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Mar 2001, Peter Samuelson wrote:

> 
> [Jeff Coy]
> > this issue came up frequently with customers uploading scripts in
> > binary mode trying to run #!/usr/bin/perl^M.  The solution for me was
> > to just do the following:
> > 
> > 	cd /usr/bin
> > 	sudo ln -s perl^V^M perl
> 
> So none of your customers tried '#!/usr/bin/perl -w^M'?  (Come on,
> doesn't everyone use -w?)
> 
> I'm not for treating \r as IFS in the kernel, but the "simple one-time"
> solution is not perfect..
> 

'#!/usr/bin/perl -w^M' works without any special handling; the link is
not needed:

	11:15:52 jcoy@d-hopper::~
	$ cat -vet foo.pl
	#!/usr/bin/perl -w^M$
	^M$
	print "Hello, World!\n";^M$
	11:16:52 jcoy@d-hopper::~
	$ ./foo.pl
	Hello, World!

Jeff
--
The Harvard Law states:  Under controlled conditions of light, temperature,
humidity, and nutrition, the organism will do as it damn well pleases.
             -- Larry Wall

