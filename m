Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269285AbUJQULh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269285AbUJQULh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 16:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269260AbUJQULd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 16:11:33 -0400
Received: from gate.in-addr.de ([212.8.193.158]:42978 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S269289AbUJQULb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 16:11:31 -0400
Date: Sun, 17 Oct 2004 22:08:04 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Martijn Sipkema <martijn@entmoot.nl>, Buddy Lucas <buddy.lucas@gmail.com>,
       Jesper Juhl <juhl-lkml@dif.dk>
Cc: David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041017200804.GP7468@marowsky-bree.de>
References: <20041016062512.GA17971@mark.mielke.cc> <MDEHLPKNGKAHNMBLJOLKMEONPAAA.davids@webmaster.com> <20041017133537.GL7468@marowsky-bree.de> <5d6b657504101707175aab0fcb@mail.gmail.com> <20041017150509.GC10280@mark.mielke.cc> <5d6b65750410170840c80c314@mail.gmail.com> <Pine.LNX.4.61.0410171921440.2952@dragon.hygekrogen.localhost> <5d6b65750410171104320bc6a8@mail.gmail.com> <20041017180629.GO7468@marowsky-bree.de> <003001c4b484$8999fe70$161b14ac@boromir>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <003001c4b484$8999fe70$161b14ac@boromir>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-10-17T21:04:40, Martijn Sipkema <martijn@entmoot.nl> wrote:

> > The specs don't disagree with that. On a O_NONBLOCK socket, that is
> > allowed.
> No, it isn't. select() may not behave differently based on the O_NONBLOCK
> flag at the moment of the select() call. 

Yes it may. Though this is getting nitpicking; please re-read:

"A descriptor shall be considered ready for reading when a call to an
input function with O_NONBLOCK clear would not block, whether or not the
function would transfer data successfully. (The function might return
data, an end-of-file indication, or an error other than one indicating
that it is blocked, and in each of these cases the descriptor shall be
considered ready for reading.)"

No claim is made for O_NONBLOCK set; so in that case we can do something
sane.

> And if a call to recvmsg() with O_NONBLOCK cleared doesn't block and
> since it can't return EAGAIN, then I don't think a recvmsg() call with
> O_NONBLOCK set should return EAGAIN where something like EIO should
> have been returned otherwise.

Point taken. For UDP, returning EIO in both cases is just fine (it's
actually also correct, for a checksum error constitutes a "network read
error"...). At least according to the spec.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX AG - A Novell company

