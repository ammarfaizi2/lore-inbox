Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269331AbRHGV4L>; Tue, 7 Aug 2001 17:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269380AbRHGV4B>; Tue, 7 Aug 2001 17:56:01 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:22453 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S269331AbRHGVz4>; Tue, 7 Aug 2001 17:55:56 -0400
Message-ID: <3B70641D.CF5F48B9@idcomm.com>
Date: Tue, 07 Aug 2001 15:56:45 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre1-xfs-4 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: encrypted swap
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211C9A8@mail0.myrio.com> <Pine.LNX.4.33L2.0108072212590.18776-100000@spiral.extreme.ro> <9kpl82$iao$1@abraham.cs.berkeley.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner wrote:
> 
> Dan Podeanu  wrote:
> >If its going to be stolen while its offline, you
> >can have your shutdown scripts blank the swap partition [...]
> 
> Erasing data, once written, is deceptively difficult.
> See Peter Gutmann's excellent paper on the subject at
> http://www.usenix.org/publications/library/proceedings/sec96/gutmann.html
> 
> It turns out that the easiest way to solve this problem is to make sure
> you only ever write to the swap partition in encrypted form, and then when
> you want to erase it securely, just throw away the key used to encrypt it.
> (You have to securely erase this key, but it is much easier to erase
> this key securely, because it is shorter and because you can arrange
> that it only resides in RAM.)
> 
> It is critical that you choose a new encryption key each time you boot.
> (Requiring users to enter in passphrases manually is unlikely to work well.)

You could easily create a pass phrase that is a combination of a user
defined pass, and a random device generation. During suspend of the
laptop, you could force it to forget only the user defined portion, and
ask that it get re-entered on resume. Keyboard snooping would only
provide a small part of the key; though it would aid attacks to know
part of the key, each reboot would invalidate the per-session key, and
each suspend or boot would also invalidate the user key (the user could
choose a different user key each boot, but that key would remain in
effect for the remainder of the boot; one could be so devious as to also
force the user key portion to pass a one-way hash, like MD5, against a
permanent pass file, if the permanent pass file was not itself on an
encrypted partition).

D. Stimits, stimits@idcomm.com

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
