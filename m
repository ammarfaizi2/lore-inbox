Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUEMTy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUEMTy2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264693AbUEMTxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:53:49 -0400
Received: from smtp-out2.xs4all.nl ([194.109.24.12]:19722 "EHLO
	smtp-out2.xs4all.nl") by vger.kernel.org with ESMTP id S264926AbUEMTvY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:51:24 -0400
In-Reply-To: <20040513121141.37f32035.akpm@osdl.org>
References: <40A26FFA.4030701@pobox.com> <20040512193349.GA14936@elte.hu> <200405121947.i4CJlJm5029666@turing-police.cc.vt.edu> <Pine.LNX.4.58.0405121255170.11950@bigblue.dev.mdolabs.com> <200405122007.i4CK7GPQ020444@turing-police.cc.vt.edu> <20040512202807.GA16849@elte.hu> <20040512203500.GA17999@elte.hu> <20040512205028.GA18806@elte.hu> <20040512140729.476ace9e.akpm@osdl.org> <20040512211748.GB20800@elte.hu> <20040512221823.GK1397@holomorphy.com> <61D92BA6-A504-11D8-BD91-000A95CD704C@wagland.net> <20040513121141.37f32035.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-46-943942460"
Message-Id: <D0659356-A516-11D8-BD91-000A95CD704C@kungfoocoder.org>
Content-Transfer-Encoding: 7bit
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       jgarzik@pobox.com, netdev@oss.sgi.com, wli@holomorphy.com,
       davidel@xmailserver.org, Valdis.Kletnieks@vt.edu
From: Paul Wagland <paul@kungfoocoder.org>
Subject: Re: MSEC_TO_JIFFIES is messed up...
Date: Thu, 13 May 2004 21:50:41 +0200
To: Andrew Morton <akpm@osdl.org>
X-Pgp-Agent: GPGMail 1.0.1 (v33, 10.3)
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-46-943942460
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed


On May 13, 2004, at 21:11, Andrew Morton wrote:

> Paul Wagland <paul@wagland.net> wrote:
>>  This changes behaviour when HZ==(z)000
>>
>>  JIFFIES_TO_MSECS  goes from
>>  ((x) * 1000) / (z)000  to (((x) + (z) - 1)/(z))
>>
>>  i.e. for x=1, z=2 this goes from ((1)*1000)/2000)=0 to 
>> (((1)+(2)-1)/2)=1
>
> hm, so you're saying that we now round 0.5 up to 1 rather than down to 
> zero?

More precisely, we round .x up, where before it was rounded down, but 
yeah, _and_ only when HZ is a multiple of 1000, and greater than 1000. 
This is also only the case for the patch as proposed by wli, currently 
I don't know of any architectures that have a HZ of 2000 or more... but 
I just note that it _is_ a behaviour change in those cases, whether or 
not it is important is for other people to decide :-)

Cheers,
Paul

--Apple-Mail-46-943942460
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iD8DBQFAo9GRtch0EvEFvxURAhORAJ4gYSRI0mv2qgrEBqqWSAsJ9IVVoACgl9eP
801yhelPMICs2UkqMg82H4s=
=snV2
-----END PGP SIGNATURE-----

--Apple-Mail-46-943942460--

