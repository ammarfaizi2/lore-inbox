Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273858AbRIXLNM>; Mon, 24 Sep 2001 07:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273864AbRIXLNB>; Mon, 24 Sep 2001 07:13:01 -0400
Received: from pc7.prs.nunet.net ([199.249.167.77]:50694 "HELO
	pc7.prs.nunet.net") by vger.kernel.org with SMTP id <S273858AbRIXLMu>;
	Mon, 24 Sep 2001 07:12:50 -0400
Date: 24 Sep 2001 11:13:15 -0000
Message-ID: <20010924111315.25391.qmail@pc7.prs.nunet.net>
From: "Rico Tudor" <rico-linux-kernel@patrec.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.10 cdrom readahead botch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reading within 160 KB of the end-of-track causes pandemonium.

For those unfamiliar with CDROM media, reading past end-of-track (in TAO
recordings) triggers a hard error from the drive.  For SAO, the error
occurs at the end of the last track of the session.

Through 2.4.9, Linux readahead is about 2 sectors, error recovery takes
a second, and DMA settings are preserved.  Even that readahead glitch
can be avoided by lightly padding the end of a track during a burn.

CDROM support in 2.4.10 has taken a giant step into the toilet, and
effectively breaks existing CDROMs.  Reading within 80 CDROM sectors
causes a boatload of error messages, minutes of delay, ATAPI resets,
loss of DMA settings.  I count 15 ATAPI resets when there should be 0.
