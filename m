Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWCWUgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWCWUgv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWCWUgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:36:51 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:43144 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751491AbWCWUgt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:36:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NQx3Y0FU6ShZRfpZkqYBTIXkfWMtKXIdej2YNFU9D3q1VkLWPoPu+nWaH7vO/Y4ZYzaSPkHKXqhVB2GnyoGtxAV0BTIt/e06TcGJdMt/9p9AS+U6tARu1qe78HUZ3dyv3JV+KrB/BCUuNcRvKanQWiehd1a3uML7PAkvsLcyrcg=
Message-ID: <d120d5000603231236n1294b492x93a107ce3971de5f@mail.gmail.com>
Date: Thu, 23 Mar 2006 15:36:48 -0500
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: "Stas Sergeev" <stsp@aknet.ru>
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>, vojtech@suse.cz
In-Reply-To: <4422F85E.7000200@aknet.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200603220652.k2M6qZgi020656@shell0.pdx.osdl.net>
	 <d120d5000603221332n6a6f9208x5651dc9ec993f4bf@mail.gmail.com>
	 <4422318C.407@aknet.ru>
	 <d120d5000603230651p6b43aad9ocad1aa3c2b51b388@mail.gmail.com>
	 <4422E2DA.7050305@aknet.ru>
	 <d120d5000603231012h1c0f5s8ecde64e67641317@mail.gmail.com>
	 <4422E968.1050506@aknet.ru>
	 <d120d5000603231047q6e777243nb4031b701dbdc494@mail.gmail.com>
	 <4422F85E.7000200@aknet.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/06, Stas Sergeev <stsp@aknet.ru> wrote:
> Hi.
>
> Dmitry Torokhov wrote:
> > So what you actually need is a mediator module controlling concurrent
> > access to the speaker hardware from both pcspkr and snd_pcsp and
> > making sure that one does not disrupt the other. This is completely
> > outside of the scope of the input subsystem tough.
> Strictly speaking - yes. But, to make my life easier, I am trying
> to approach it from the other sides as well:
> Why not to have a SYN_CONFIG option to disable the terminal beeps
> with *any* speaker driver (sparkspkr, m68kspkr etc)?

Because what happens when ther is a third party involved. As you know
the good design account for either "zero", "one" or "many"
clients/accessors. Code in anticipation of having only 2 possible
users is not a good practice.

> Or, why not to have the grabbing capability in the input layer, so
> that the driver can request an exclusive handling of some events?

That can be explored, although does not answer how you do about
allowing concurrent access to the hardware.

> Both the above options look usefull in general, and I can get the
> use of either one. Do you think both of the above options are bad
> in general? (you may disagree with the way I am going to use them,
> but that doesn't make them bad in general, I think)
>
> > You are right, I misunderstood the purpose of snd_pcsp. Still the best
> > solution would be to allow beeps to come through if user keeps them
> > enabled.
> But they really kill the snd_pcsp if they occur. They reprogram the
> PIT channel 2 to a different mode, and the sound doesn't resume
> after the beep, there is just some crackling remains. And it is
> not even under the user's control - Mozilla mailer beeps me when
> receives the mail for example.

Doesn't it go through XBell (xkbbell to disable)?

> So not disabling pcspkr will make
> the snd_pcsp very unreliable.
>

I understand that the beeps kill music currently; they should not if
you have lower level module controlling access.

--
Dmitry
