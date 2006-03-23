Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751483AbWCWTen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbWCWTen (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 14:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWCWTen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 14:34:43 -0500
Received: from mail.aknet.ru ([82.179.72.26]:4879 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1751483AbWCWTen (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 14:34:43 -0500
Message-ID: <4422F85E.7000200@aknet.ru>
Date: Thu, 23 Mar 2006 22:34:54 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: Linux kernel <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
References: <200603220652.k2M6qZgi020656@shell0.pdx.osdl.net>	 <d120d5000603221332n6a6f9208x5651dc9ec993f4bf@mail.gmail.com>	 <4422318C.407@aknet.ru>	 <d120d5000603230651p6b43aad9ocad1aa3c2b51b388@mail.gmail.com>	 <4422E2DA.7050305@aknet.ru>	 <d120d5000603231012h1c0f5s8ecde64e67641317@mail.gmail.com>	 <4422E968.1050506@aknet.ru> <d120d5000603231047q6e777243nb4031b701dbdc494@mail.gmail.com>
In-Reply-To: <d120d5000603231047q6e777243nb4031b701dbdc494@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Dmitry Torokhov wrote:
> So what you actually need is a mediator module controlling concurrent
> access to the speaker hardware from both pcspkr and snd_pcsp and
> making sure that one does not disrupt the other. This is completely
> outside of the scope of the input subsystem tough.
Strictly speaking - yes. But, to make my life easier, I am trying
to approach it from the other sides as well:
Why not to have a SYN_CONFIG option to disable the terminal beeps
with *any* speaker driver (sparkspkr, m68kspkr etc)?
Or, why not to have the grabbing capability in the input layer, so
that the driver can request an exclusive handling of some events?
Both the above options look usefull in general, and I can get the
use of either one. Do you think both of the above options are bad
in general? (you may disagree with the way I am going to use them,
but that doesn't make them bad in general, I think)

> You are right, I misunderstood the purpose of snd_pcsp. Still the best
> solution would be to allow beeps to come through if user keeps them
> enabled.
But they really kill the snd_pcsp if they occur. They reprogram the
PIT channel 2 to a different mode, and the sound doesn't resume
after the beep, there is just some crackling remains. And it is
not even under the user's control - Mozilla mailer beeps me when
receives the mail for example. So not disabling pcspkr will make
the snd_pcsp very unreliable.

