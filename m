Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270740AbTHATAc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 15:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270926AbTHATAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 15:00:32 -0400
Received: from adsl-216-158-28-251.cust.oldcity.dca.net ([216.158.28.251]:16521
	"EHLO fukurou.paranoiacs.org") by vger.kernel.org with ESMTP
	id S270740AbTHATAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 15:00:31 -0400
Date: Fri, 1 Aug 2003 14:45:43 -0400
From: Ben Slusky <sluskyb@paranoiacs.org>
To: Andries.Brouwer@cwi.nl
Cc: fvw@var.cx, linux-kernel@vger.kernel.org, linux-crypto@nl.linux.org
Subject: Re: 2.6.0-test2+Util-linux/cryptoapi
Message-ID: <20030801184543.GA15828@fukurou.paranoiacs.org>
Mail-Followup-To: Andries.Brouwer@cwi.nl, fvw@var.cx,
	linux-kernel@vger.kernel.org, linux-crypto@nl.linux.org
References: <UTC200307310941.h6V9fP204094.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200307310941.h6V9fP204094.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003 11:41:25 +0200, Andries.Brouwer@cwi.nl wrote:
> The patches I got were maximal, too much junk.
> So I went for a minimal version instead.
> 
> It is usable (when the kernel part is stable, which it isn't today)
> but mount/losetup may well acquire a few options before it is
> conveniently usable.

Can we discuss those options now? I find the latest losetup to be
completely unusable, tho' I appreciate the effort that's gone into it
so far.

Firstly, are the other key size choices (128-bit, 192-bit) gone for
good? If so then I'll need to redo this entire hard disk (which currently
uses 128-bit AES) before I can test 2.6 on my laptop.

Secondly, there's the issue of passphrase hashing. I agree with the
decision to cut it out of losetup, but where do we put it now? Andries
has suggested an external program, but this isn't as simple as it sounds.
To get this working would require a new way of reading the passphrase,
since the hashed passphrase might contain a newline, or a null. Maybe
change the semantics of the -p option, so that:

	losetup -e aes /dev/loop/10 /home/sluskyb/testloop

will work when I give it the passphrase "foobar", but also

	pwhash -h sha1 |losetup -e aes -k 128 -p 0 /dev/loop/0 \
		/dev/discs/disc0/part3

will read exactly 16 bytes of (probably) non-printable chars and use
that as the key.

Questions? Comments? Flames?

-- 
Ben Slusky                      | A free society is a society
sluskyb@paranoiacs.org          | where it is safe to be
sluskyb@stwing.org              | unpopular.
PGP keyID ADA44B3B              |               -Adlai Stevenson
