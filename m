Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277630AbRJRIa6>; Thu, 18 Oct 2001 04:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277629AbRJRIaj>; Thu, 18 Oct 2001 04:30:39 -0400
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:2184 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S277626AbRJRIa0>; Thu, 18 Oct 2001 04:30:26 -0400
Date: Thu, 18 Oct 2001 09:30:52 +0100 (BST)
From: James Sutherland <jas88@cam.ac.uk>
X-X-Sender: <jas88@yellow.csi.cam.ac.uk>
To: Leo Mauro <lmauro@usb.ve>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Bench] New benchmark showing fileserver problem in 2.4.12
In-Reply-To: <01101722010908.02313@lmauro.home.usb.ve>
Message-ID: <Pine.SOL.4.33.0110180929310.13081-100000@yellow.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2001, Leo Mauro wrote:

> Small fix to Linus's sample code
>
>  	unsigned int so_far = 0;
>  	for (;;) {
>  		int bytes = read(in, buf+so_far, BUFSIZE-so_far);
>  		if (bytes <= 0)
>  			break;
>  		so_far += bytes;
>  		if (so_far < BUFSIZE)
>  			continue;
>  		write(out, buf, BUFSIZE);
> - 		so_far = 0;
> +		so_far -= BUFSIZE;
>  	}
>  	if (so_far)
>  		write(out, buf, so_far);
>
> to avoid losing data.

Checking the return from write() for errors might be a nice idea too,
otherwise you carry on reading, and trying to append, even if the target
device is full (or whatever).


James.
-- 
"Our attitude with TCP/IP is, `Hey, we'll do it, but don't make a big
system, because we can't fix it if it breaks -- nobody can.'"

"TCP/IP is OK if you've got a little informal club, and it doesn't make
any difference if it takes a while to fix it."
		-- Ken Olson, in Digital News, 1988

