Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264509AbTLGUiJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 15:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264512AbTLGUiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:38:09 -0500
Received: from ws23-90.kotiportti.fi ([193.185.141.90]:8340 "EHLO
	mood.kotiportti.fi") by vger.kernel.org with ESMTP id S264509AbTLGUiG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:38:06 -0500
Date: Sun, 7 Dec 2003 22:38:02 +0200
From: Ville Hallivuori <vph@iki.fi>
To: Anssi Saari <as@simpukka.saunalahti.fi>
Cc: davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Fwd: Re: CMPCI patch for 2.4.23 (fix multi channel audio, spdiff, game port)
Message-ID: <20031207203802.GA6685@vph.iki.fi>
Reply-To: vph@iki.fi
References: <20031207201207.ED1F11B246@simpukka.saunalahti.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031207201207.ED1F11B246@simpukka.saunalahti.fi>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Indeed, it did, at least what little spdif functionality there was with
> the original 2.4.23 driver. I have an onboard CM8738 on ASUS A7S333 and
> use the optical spdif output exclusively.

> 		spdif out?			spdif AC3 passthrough?
> vanilla 2.4.22	yes				yes
> vanilla 2.4.23	yes, if enabled with cmictl	no
> this patch	no				no
> 
> The fix isn't quite right, so further work would be much appreciated. I
> sent this mail to you two directly as I'm not sure if I can just post a
> followup to lkml when reading it through usenet.

I don't have spdiff hardware (nor do I have register chart...), so I
can not be certain, but try changing:
#define	   SPDF_0	0x01
#define	   SPDF_1	0x02
to 
#define	   SPDF_0	0x02
#define	   SPDF_1	0x01

And change from function set_spdif_monitor line:
  maskw(s->iobase + CODEC_CMI_FUNCTRL1, ~SPDO2DAC, channel == 2 ? SPDO2DAC : 0);
to:
  maskw(s->iobase + CODEC_CMI_FUNCTRL1, ~SPDO2DAC, channel == 1 ? SPDO2DAC : 0);

If this does not help. try looking for similar value pairs -- it seems
that channel number assumptions are present in quite many places...

-- 
[Ville Hallivuori][vph@iki.fi][http://www.iki.fi/vph/]
[ID 8E1AD461][FP16=C9 50 E2 DF 48 F6 33 62  5D 87 47 9D 3F 2B 07 5D]
[ID 58543419][FP20=8731 941D 15AB D4A0 88A0  FC8F B55C F4C4 5854 3419]
[ID 8061C24E][FP20=C722 12DA 841E D811 DBFE  2FB3 174C E291 8061 C24E]
