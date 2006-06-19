Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750783AbWFSIiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWFSIiX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWFSIiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:38:22 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:12507 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S1751091AbWFSIiV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:38:21 -0400
To: jesper.juhl@gmail.com
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <9a8748490606190121u3c76c6bbif707835ec7e5873c@mail.gmail.com>
	(jesper.juhl@gmail.com)
Subject: Re: [PATCH 4/7] fuse: add POSIX file locking support
References: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu>
	 <E1FplXk-00062M-00@dorka.pomaz.szeredi.hu> <9a8748490606190121u3c76c6bbif707835ec7e5873c@mail.gmail.com>
Message-Id: <E1FsFGX-0002Pp-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 19 Jun 2006 10:37:49 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How about; on fuse startup, pick some semirandom number, store it
> somewhere, then do an XOR of the pointer with the saved value to
> scramble it, when you need to use it, simply XOR it again with the
> stored value...  Not especially strong, but better than nothing and
> better than just adding a constant that people can find out from the
> source

I think Andrew was suggesting a random key for the ADD function.

> (and the scramble value would be differene each time fuse loads, so
> at a minimum a different scramble key every boot) - also, XOR is a
> quite fast operation so overhead should be low.

I think XOR might be even weaker than ADD, because from gessing the
difference between two values (easy) you might be able to guess the
bits of the key.

I'm actually looking for something stronger than XOR or ADD, but it's
all a bit academical I think, because even if userspace knows these
kernel pointers it can't really use them for any malicious purpose.

Miklos
