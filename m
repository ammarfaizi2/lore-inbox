Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWE1QBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWE1QBo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 12:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWE1QBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 12:01:44 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:12883 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750720AbWE1QBn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 12:01:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=VEXO3T02+wIZUA4FiCveKIKRpQ0X2jI8foV45qtsisPNPWEpS3jAMvhmJmh0my295t3H5nL33ed1RjbFYGagg66pbHM7oxAcsio+TGyh0wncwxr98Ko9wtAVDLu5y0srKCv694I4PWI04vSgfomG5tI5yhTHJfjWtuJfkeJiYlo=
Message-ID: <d6e463920605280901n41840baeuc30283a51e35204e@mail.gmail.com>
Date: Sun, 28 May 2006 09:01:43 -0700
From: "Nathan Laredo" <laredo@gnu.org>
To: "Mauro Carvalho Chehab" <mchehab@infradead.org>
Subject: Re: Stradis driver conflicts with all other SAA7146 drivers
Cc: "Jiri Slaby" <jirislaby@gmail.com>,
       "Christer Weinigel" <christer@weinigel.se>,
       linux-kernel@vger.kernel.org, video4linux-list@redhat.com,
       "v4l-dvb maintainer list" <v4l-dvb-maintainer@linuxtv.org>
In-Reply-To: <1148825088.1170.45.camel@praia>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <m3wtc6ib0v.fsf@zoo.weinigel.se> <44799D24.7050301@gmail.com>
	 <1148825088.1170.45.camel@praia>
X-Google-Sender-Auth: cb09c3eeefd03316
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I agree that the real fix is to unify the stradis driver so that it
uses the existing saa7146 driver (and extending the saa7146 driver if
it doesn't have all the support necessary yet).   Keep in mind that at
the time the driver was written, there was no other saa7146-based card
on the market (mid 1999).

Until the pci change there was never a single complaint.

Unfortunately it was ill timed to happen when I was busiest at work,
and even now I'm on my way to New Zealand for a month where I'll be
out of touc as well, so the "right" fix is not likely to happen soon.

I didn't even know that other saa7146 cards had been developed until
the bug reports about the conflicts started pouring in.  I don't run
bleeding edge kernels anymore due to work having a rhel3 requirement
because the lame cad tool vendors are so far behind the curve.

- Nathan Laredo
laredo@gnu.org

On 5/28/06, Mauro Carvalho Chehab <mchehab@infradead.org> wrote:
> Em Dom, 2006-05-28 às 14:52 +0159, Jiri Slaby escreveu:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
>
> > > For anyone submitting a new SAA7146 driver to the kernel in the
> > > future, please be aware that your card isn't the only one that uses
> > > that chip, so always add a subvendor/subdevice to your drivers.
> The better is to use the existent driver instead of creating newer
> ones.
> > The only difference is in order of searching for devices. Stradis now gets
> > control before your "real" driver. Kick stradis from your config or blacklist
> > it.
> This sucks. Distros should compile all drivers to support as much
> hardware as possible. For now, it is better to implement Christer
> suggestions.
> > Or, why you ever load module, you don't want to use?
> There's no safe way to make a driver to get control after the others, if
> both are modules, so the option is to use the saa7146 driver instead of
> stradis.
> > There is no change in searching devices, it didn't check for subvendors before
> > not even now. If Nathan knows, there are some subvendor/subdevices ids, which we
> > should compare to, then yes, we can change the behaviour, otherwise, I am
> > afraid, we can't. It's vendors' problem, that they don't use this pci registers
> > (and it's evil) -- i think, that stradis cards have that two zeroed.
> This is, in fact, a trouble on several video capture boards. A real
> merge work should be done by migrating stradis to use the generic
> support for SAA7146. Then, having just one board, those conflicts won't
> happen.
> >
> > regards,
> > - --
> > Jiri Slaby         www.fi.muni.cz/~xslaby
>
> Cheers,
> Mauro.
>
>
