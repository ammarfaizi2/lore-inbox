Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272080AbRIUIhH>; Fri, 21 Sep 2001 04:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272240AbRIUIg5>; Fri, 21 Sep 2001 04:36:57 -0400
Received: from ip122-15.asiaonline.net ([202.85.122.15]:51329 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S272080AbRIUIgp>; Fri, 21 Sep 2001 04:36:45 -0400
Message-ID: <3BAAFC04.1F7B9C7C@rcn.com.hk>
Date: Fri, 21 Sep 2001 16:36:20 +0800
From: David Chow <davidchow@rcn.com.hk>
Organization: Resources Computer Network Ltd.
X-Mailer: Mozilla 4.76 [zh_TW] (X11; U; Linux 2.4.4-1DC i686)
X-Accept-Language: zh_TW, en
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, Thomas Sailer <sailer@scs.ch>,
        linux-kernel@vger.kernel.org
Subject: Re: via82cxxx_audio locking problems
In-Reply-To: <Pine.LNX.3.96.1010920112905.26319I-100000@mandrakesoft.mandrakesoft.com> <3BAAF129.1090104@humboldt.co.uk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Cox ¼g¹D¡G
> 
> Jeff Garzik wrote:
> 
> > On Thu, 20 Sep 2001, Thomas Sailer wrote:
> >>   Dropping and reacquiring syscall_sem around interruptible_sleep_on
> >>   in via_dsp_do_read, via_dsp_do_write and via_dsp_drain_playback
> >>   should solve the problem. Does anyone see a problem with this?
> 
> > Is there a possibility of do_read being re-entered during that window?
> > I agree its a problem but the solution sounds racy?
> 
> What's probably needed is one semaphore to lock read/write and ioctls
> that look at the playback engine, and another semaphore to lock accesses
> to the AC97 codec. That may be simpler to implement than dropping and
> releasing the syscall_sem.
> 
> --
> Adrian Cox   http://www.humboldt.co.uk/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I receive the same problem when probing the via sound module. Since I am
in a motherboard design project which I also uses the AC97 interface
from VIA. The sample board from VIA didn't have any problem, but have 3
motherboard from 3rd party, each of them uses the VIA694X + VIA686A,
only one of them have no problem using the sound module, I think it is a
hardware problem or the module itself didn't handle some cases. It seems
it should be the same for hardware design, since different codec may
have different effect on the module. All boards are tested with
Windows98 and Linux and then all works fine runnign Windows. The sample
board from VIA is a VIA694T + VIA686B which all of them are pin-2-pin
compatible with the old 694X+686A. I am sure the problem is from the
driver, but it is hardware dependent??? My board design just use exactly
the same chips of the VIA sample board, then we will be save using the
via_82cxxx module properly. I will try to find out which codec is the
trouble boards using. The one I'm surely stable without locking is using
the VIA codec VT1611A . Does you guys require more information about the
codec specs? I can get them from VIA if you want. Thanks.

regards,

David
