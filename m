Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129322AbQKHNf1>; Wed, 8 Nov 2000 08:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQKHNfS>; Wed, 8 Nov 2000 08:35:18 -0500
Received: from [204.177.156.37] ([204.177.156.37]:40417 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129118AbQKHNfE>; Wed, 8 Nov 2000 08:35:04 -0500
Message-ID: <3A095750.FA16D022@veritas.com>
Date: Wed, 08 Nov 2000 19:08:24 +0530
From: "Amit S. Kale" <akale@veritas.com>
Organization: Veritas Software (India)
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Translation Filesystem
In-Reply-To: <3A0109D6.4DFA2F62@veritas.com> <20001106094553.C128@bug.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> > I have started a new virtual filesystem project, Translation Filesystem
> > at
> > http://trfs.sourceforge.net/  Description of the project is given below.
> >
> > It's still at a concept stage. If someone has any ideas about any useful
> > translators that fit in this framework please write to me.
> > Any feedback is most welcome.
> 
> Well - I can certainly not do zero-copy block device access.
> 
> What are expected usages of your translation filesystem?
> Hi-performance things like zero-copy block device access, or
> low-performance things like transparently ungzipping? If it is the
> second case, uservfs.sourceforge.net is perfectly applicable, if not,
> you really need to modify kernel..

Thanks for your comments.

trfs is just a framework for creating views. Translators are independent
entities, so the use of trfs will be more dependent on what translators
are present. Since translators are independent of each other, 
they can be used for hi-performance as well as low-performance things.

Translators need not be inside the trfs module (right now raw translator
is because the interface for translators isn't fixed yet). The raw
translator is dependent on block devices. A translator for some other
thing say a tar-directory translation could be dependent on a userfs.

e.g.
/trfs/tar/foo->/home/username/foo.tar

tar translator uses uservfs to create a view
It will use /uservfs/<something>/foo.tar#<bar>
-- 
Amit Kale
Veritas Software ( http://www.veritas.com )
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
