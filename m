Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266844AbSL3K3s>; Mon, 30 Dec 2002 05:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266846AbSL3K3s>; Mon, 30 Dec 2002 05:29:48 -0500
Received: from alfie.demon.co.uk ([158.152.44.128]:37638 "EHLO
	bagpuss.pyrites.org.uk") by vger.kernel.org with ESMTP
	id <S266844AbSL3K3r>; Mon, 30 Dec 2002 05:29:47 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Nick.Holloway@pyrites.org.uk (Nick Holloway)
Newsgroups: list.linux-kernel
Subject: Avoid large reads using parport_read() ?
Date: 30 Dec 2002 10:32:01 -0000
Organization: Alfie's Internet Node
Message-ID: <aup7b1$i50$1@alfie.demon.co.uk>
X-Newsreader: NN version 6.5.0 CURRENT #120
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been involved with the cpia_pp driver (parallel port Webcam), and
found that X becomes very sluggish when capturing a stream of images.
I suspect that this is due to reading the whole of each frame using
parport_read(), which could be up to 200K.

In the 2.0 kernel days (pre-parport layer), the cpia_pp driver would do
its own parallel port banging, and would actually only read 16 bytes
(fifo size) at a time before checking if it needed to reschedule.
Now it fetches the whole image using a single call to parport_read().

I did a quick check, and instead of issuing one parport_read for the whole
image, I looped round issuing reads of 4096 bytes.  The responsiveness
of the machine was much improved.

Is there any problem with looping calls to parport_read() with a smaller
buffer size, and performing cond_resched() each time through the loop?
What size of buffer should I use?

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
