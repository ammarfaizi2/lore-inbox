Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbTFNMM6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 08:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265646AbTFNMM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 08:12:58 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:46854 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S264375AbTFNMM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 08:12:57 -0400
Path: Home.Lunix!not-for-mail
Subject: 2.4.21: cmedia PCM not working
Date: Sat, 14 Jun 2003 12:25:43 +0000 (UTC)
Organization: lunix confusion services
NNTP-Posting-Host: quasar.home.lunix
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 1055593543 4776 10.0.0.20 (14 Jun 2003 12:25:43
    GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Sat, 14 Jun 2003 12:25:43 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:243645
X-Mailer: Perl5 Mail::Internet v1.51
Message-Id: <bcf487$4l8$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just compiled and tried kernel 2.4.21. All seems fine except that I 
have no sound over /dev/dsp (other sources like e.g. "line" work fine).

My soundchip is a SiS 7012, which seems to have a cmedia CMI65.

Having a look at the changes, I see this new line in ac97_codec.c:

	{0x434D4941, "CMedia",			&cmedia_ops,		AC97_NO_PCM_VOLUME },

Commenting out only the AC97_NO_PCM_VOLUME field (and leaving the rest of
the line) makes my audio work again.
While indeed the volume slider never allowed me to linearly control
the volume, it DOES have an effect: 
   - at level 0 there is no sound
   - at any oher level, there is pcm sound. The volume is in no way
     influenced by the value, as long as it's not zero

So I suspect that while indeed you don't want a pcm volume level for
a CMI65, just adding that line also gets rid of some needed 
initialization.
-- 
#define struct union /* Great space saver */
