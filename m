Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWF1SNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWF1SNQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWF1SNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:13:16 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:50409 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750728AbWF1SNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:13:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p9nveLe/jAulpaZlQxxUAAekXsRfCt/BVdbjCBtInmS+yW2h2/W80dKREjlWkJNUITuOoD9lR0NJN4FWAbHmkJWfPq4IU8cYhVFlAw5BmQ/0qK4K04/E1988Cb1fTObvwJQ+AlzBfeTo7NLDBmgxbzBI8CKvc9mw5GSou2grFf4=
Message-ID: <9e4733910606281113m2c5fc3bfgcdf5b458f3fbc861@mail.gmail.com>
Date: Wed, 28 Jun 2006 14:13:13 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty_mutex and tty_old_pgrp
Cc: "Paul Fulghum" <paulkf@microgate.com>, lkml <linux-kernel@vger.kernel.org>,
       "Theodore Ts'o" <tytso@mit.edu>
In-Reply-To: <1151517865.15166.54.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910606261538i584e2203o9555d77094de6fe7@mail.gmail.com>
	 <44A1B79F.9020204@microgate.com>
	 <9e4733910606272029r32255d27we6e8b34a4c2e569@mail.gmail.com>
	 <1151490240.15166.5.camel@localhost.localdomain>
	 <9e4733910606281036k53956aaev3d323fbb7a2cb7a9@mail.gmail.com>
	 <1151517865.15166.54.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Mer, 2006-06-28 am 13:36 -0400, ysgrifennodd Jon Smirl:
> > This selinux code is checking to see if the current process still has
> > access rights to it's controlling tty, right? If it doesn't tty and
> > tty_old_pgrp are nulled out. Does this need locking?
>
> Yes that looks like it needs to the tty lock covering it.
I can add the lock.

If the task is the session leader and you null out it's controlling
tty, what about other tasks in the session? I didn't think is was
legal to have some tasks in a session with tty set and some without
it.  Should this turn into a disassociate_tty()?

-- 
Jon Smirl
jonsmirl@gmail.com
