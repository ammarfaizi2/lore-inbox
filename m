Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbUBWFXM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 00:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbUBWFXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 00:23:12 -0500
Received: from mta04-svc.ntlworld.com ([62.253.162.44]:35474 "EHLO
	mta04-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261811AbUBWFXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 00:23:11 -0500
Message-ID: <40398E3C.7020900@ntlworld.com>
Date: Mon, 23 Feb 2004 05:23:08 +0000
From: Michael <leahcim@ntlworld.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040210
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ALSA] emu10k1 driver oops loading large soundfont 2.6.3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

please CC: me on replies

In struct snd_emu10k1_memblk in include/sound/emu10k1.h first_page and 
last_page are defined as short.
                                                                                

Loading a soundfont that goes beyond 32767 pages causes an oops because 
{first|last}_page go negative in snd_emu10k1_sample_new 
(sound/pci/emu10k1/emu10k1_patch.c) as sfxload loads the font.

Changing {first|last}_page to int allows the soundfont to load and it 
appears to work fine.

-- 
Michael.

