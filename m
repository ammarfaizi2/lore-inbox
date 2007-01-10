Return-Path: <linux-kernel-owner+w=401wt.eu-S964913AbXAJP3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbXAJP3v (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 10:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbXAJP3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 10:29:50 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:51335 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964913AbXAJP3u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 10:29:50 -0500
From: Bernhard Schiffner <bernhard@schiffner-limbach.de>
To: linux-kernel@vger.kernel.org
Subject: Re: ntp.c : possible inconsistency?
Date: Wed, 10 Jan 2007 16:29:44 +0100
User-Agent: KMail/1.9.4
Cc: Roman Zippel <zippel@linux-m68k.org>
References: <200701101423.36740.bernhard@schiffner-limbach.de> <Pine.LNX.4.64.0701101516420.14458@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0701101516420.14458@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701101629.44528.bernhard@schiffner-limbach.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:3106147cf13cfbe25b2f22b4c4169fde
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Without a further explanation of this craziness, it's a little hard to
> discuss...
Let's try it:
time_constant is created for internal use of ntp.c and added by 4
-               time_constant = min(txc->constant + 4, (long)MAXTC);
+               time_constant = min(txc->constant + 4, (long)MAXTC + 4);

But sometimes it is written back to data referenced from outside. So let's do 
the + 4 backwards ...
-       txc->constant      = time_constant;
+       txc->constant      = time_constant - 4;

otherwise I'd like to speak of an inconsistency. It doesn't depend of actual 
use and other topics.

Bernhard
