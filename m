Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277295AbRJRCAw>; Wed, 17 Oct 2001 22:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277554AbRJRCAm>; Wed, 17 Oct 2001 22:00:42 -0400
Received: from rs9s2.datacenter.cha.cantv.net ([200.44.32.49]:14089 "EHLO
	rs9s2.datacenter.cha.cantv.net") by vger.kernel.org with ESMTP
	id <S277295AbRJRCAi>; Wed, 17 Oct 2001 22:00:38 -0400
Content-Type: text/plain; charset=US-ASCII
From: Leo Mauro <lmauro@usb.ve>
Organization: USB
To: linux-kernel@vger.kernel.org
Subject: Re: [Bench] New benchmark showing fileserver problem in 2.4.12
Date: Wed, 17 Oct 2001 22:01:09 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <3BCD8269.B4E003E5@anu.edu.au> <9qkci1$h9g$1@penguin.transmeta.com>
In-Reply-To: <9qkci1$h9g$1@penguin.transmeta.com>
MIME-Version: 1.0
Message-Id: <01101722010908.02313@lmauro.home.usb.ve>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Small fix to Linus's sample code

 	unsigned int so_far = 0;
 	for (;;) {
 		int bytes = read(in, buf+so_far, BUFSIZE-so_far);
 		if (bytes <= 0)
 			break;
 		so_far += bytes;
 		if (so_far < BUFSIZE)
 			continue;
 		write(out, buf, BUFSIZE);
- 		so_far = 0;
+		so_far -= BUFSIZE;
 	}
 	if (so_far)
 		write(out, buf, so_far);

to avoid losing data.
