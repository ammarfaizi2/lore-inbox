Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWGIRAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWGIRAt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 13:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWGIRAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 13:00:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:6332 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964825AbWGIRAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 13:00:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HcApQTZY78ZmocYviKYVpSVfiT2C//u87F883ddYofoKiro80Zd+v//+/vlLstJxcbiXxxS+2OSsnc4ak8TjJXIA9amaQiE/8Ps0+eDwtsYbZdhMBV9HWvZm7yLpQm8MRBzKMea0CHexhWP56fRhtQBAWEBgRNWZodSMO+COQpA=
Message-ID: <2c0942db0607091000m259c1ed5m960821eb5237c4b0@mail.gmail.com>
Date: Sun, 9 Jul 2006 10:00:47 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: Opinions on removing /proc/tty?
Cc: "Jon Smirl" <jonsmirl@gmail.com>, "Greg KH" <greg@kroah.com>,
       rmk+lkml@arm.linux.org.uk, alan@lxorguk.ukuu.org.uk, efault@gmx.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <787b0d920607090923p65c417f2v71c8e72bf786f995@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607082230w676ddc62u57962f1fc08cf009@mail.gmail.com>
	 <9e4733910607090704r68602194h3d2a1a91a4909984@mail.gmail.com>
	 <787b0d920607090923p65c417f2v71c8e72bf786f995@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/06, Albert Cahalan <acahalan@gmail.com> wrote:
> In any case, I'm NOT running a udevinfo program or linking
> to a screwball library. Random failures are not OK.

Complete agreement, but it seems like there's a third option here.
We're talking about nothing more complicated than a table lookup here.
Having a `udevinfo` invocation would indeed be overkill (and slower
than just stating the entire /dev hierarchy, I'm sure), but
Greg's/Jon's point that udev is the original authoritative source of
the data remains.

A simple solution would be for udev to just maintain a list in a flat
file (e.g., /dev/.mappings) that could be read (very quickly) by ps
upon startup. This could be yet another strategy somewhere in your
list of heroic efforts to derive a /dev/ node :-).

Having anyone other than udev try to maintain that mappings cache file
is doomed to failure, as you already noted.

Ray
