Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278179AbRJRWX1>; Thu, 18 Oct 2001 18:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278177AbRJRWXR>; Thu, 18 Oct 2001 18:23:17 -0400
Received: from mailg.telia.com ([194.22.194.26]:20439 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S278179AbRJRWXE>;
	Thu, 18 Oct 2001 18:23:04 -0400
Message-Id: <200110182223.f9IMNAW24982@mailg.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Leo Mauro <lmauro@usb.ve>, linux-kernel@vger.kernel.org
Subject: Re: [Bench] New benchmark showing fileserver problem in 2.4.12
Date: Thu, 18 Oct 2001 23:36:20 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <3BCD8269.B4E003E5@anu.edu.au> <9qkci1$h9g$1@penguin.transmeta.com> <01101722010908.02313@lmauro.home.usb.ve>
In-Reply-To: <01101722010908.02313@lmauro.home.usb.ve>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 October 2001 04:01, Leo Mauro wrote:
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

You too...

I was close to press the send button but noticed the "BUFSIZE-so_far"
in the read call, just in time(TM).

If it had not been there you would have needed to copy data from the
end of buf (from above BUFSIZE) to the beginning of buf too...
(the required size of buf would have been 2*BUFSIZE)

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
