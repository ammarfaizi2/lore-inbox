Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315582AbSENJtp>; Tue, 14 May 2002 05:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315584AbSENJto>; Tue, 14 May 2002 05:49:44 -0400
Received: from gateway.ukaea.org.uk ([194.128.63.73]:23013 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S315582AbSENJtn>; Tue, 14 May 2002 05:49:43 -0400
Message-ID: <3CE0DDBE.F9EC80AC@ukaea.org.uk>
Date: Tue, 14 May 2002 10:49:50 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...  Please correct me if I'm wrong but:

I think this patch is broken wrt serialization of channels on buggy
chipsets.

The hwgroup was serialized so that in certain cases, it can contain BOTH
channels, and thus only one channel is active at a time (e.g. cmd640). 
With this patch, you are now serializing only channels, not hwgroups
(which makes hwgroup totally redundant, yes?), and I can't see which bit
of your patch protects the chipsets that need both channels to be
serialized.

I think I see where you're going with the cleanup (and this isn't
unrelated to the conversation about IDE-62) but as it stands, this patch
will IMHO totally fsck any machines with dodgy chipsets.

Neil
