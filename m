Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266011AbUBCPqj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 10:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266014AbUBCPqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 10:46:39 -0500
Received: from mailgate.wolfson.co.uk ([194.217.161.2]:1482 "EHLO
	wolfsonmicro.com") by vger.kernel.org with ESMTP id S266011AbUBCPqh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 10:46:37 -0500
Subject: [BUG] unsafe reset in ac97_codec.c
From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1075822947.5204.506.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 03 Feb 2004 15:42:28 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Does anyone know why ac97_codec.c does a register reset of the codec
during device probing. i.e.

/* probing AC97 codec, AC97 2.0 says that bit 15 of register 0x00
(reset) should 
* be read zero.
*
* FIXME: is the following comment outdated?  -jgarzik 
* Probing of AC97 in this way is not reliable, it is not even SAFE !!
*/
codec->codec_write(codec, AC97_RESET, 0L);


IMO, this is unsafe because it can also reset the codec into it's
default power state which can be "power down". This is not normally a
problem for PC's, but some battery powered devices have the default
codec state as "power down" to conserve power.

Was this introduced as a workaround for some buggy device ?
If no one objects I'll submit a patch.

Liam

