Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129041AbQJ3TpD>; Mon, 30 Oct 2000 14:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129054AbQJ3Tox>; Mon, 30 Oct 2000 14:44:53 -0500
Received: from ns.caldera.de ([212.34.180.1]:1030 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129041AbQJ3Too>;
	Mon, 30 Oct 2000 14:44:44 -0500
Date: Mon, 30 Oct 2000 20:44:03 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        sct@redhat.com
Subject: Re: [PATCH] kiobuf/rawio fixes for 2.4.0-test10-pre6
Message-ID: <20001030204403.A1912@caldera.de>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, sct@redhat.com
In-Reply-To: <20001027222143.A8059@caldera.de> <200010272123.OAA21478@penguin.transmeta.com> <20001030124513.A28667@caldera.de> <39FDAD99.47FA6A54@mandrakesoft.com> <20001030191712.B27664@caldera.de> <39FDC447.C5DD7864@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <39FDC447.C5DD7864@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Oct 30, 2000 at 01:56:07PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 01:56:07PM -0500, Jeff Garzik wrote:
> My question from above is:  how can the via audio mmap in test10-preXX
> be improved by using kiobufs?  I am not a kiobuf expert, but AFAICS a
> non-kiobuf implementation is better for audio drivers.  (and the via
> audio mmap implementation is what some other audio drivers are about to
> start using...)

I think the biggest advantage is that you actually get the list of pages
when you perform the mmap instead of doing virt_to_page on every ->nopage.
That should speed up the operations on the mmap'ed are a bit.

The other strong argument for the kiobuf solution is code-sharing. Instead
of having every (sound) driver playing with the vm, there is one central
place when you use kvmaps.

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
