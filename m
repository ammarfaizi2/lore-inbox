Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265863AbTL3RBc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 12:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265864AbTL3RBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 12:01:32 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:19347 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S265863AbTL3RBa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 12:01:30 -0500
Message-ID: <3FF1AF65.4010107@blue-labs.org>
Date: Tue, 30 Dec 2003 12:01:25 -0500
From: David Ford <david+powerix@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0: alsa, esd, mpg123
References: <20031230155358.GB23963@butterfly.hjsoft.com>
In-Reply-To: <20031230155358.GB23963@butterfly.hjsoft.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unless esd has ever gotten fixed, esd doesn't handle errors or write() 
return values.

Some sound cards can't handle the flood of data and only accept so many 
bytes at a time.  Esd does a write of 4K, only 2387 bytes (this is an 
example) are actually written.  Esd doesn't pay attention to this and 
starts writing with the next 4K chunk.  This leads to the skips.

On slow machines or slow kernels you don't notice this (as much), on 
faster stuff, it's very apparent.

For what it's worth, there is hardly any error checking at all in esd.

David

John M Flinchbaugh wrote:

>on my debian (unstable) laptop newly running 2.6.0, i've noticed
>an irritating tendency for music to not pause, but instead to
>try to go too fast, skipping small parts of the song (fractions
>of a second).  this results in music with regular beats sounding
>erratic.
>
>i'm using gqmpeg -> mpg123-esd -> esd -> oss -> alsa (maestro3).
>
>switching esd to use -tcp instead of -unix seems to alleviate
>the trouble a bit.  ogg123 playing through esd doesn't seem to
>do it as much either.
>
>has anyone else noted this problem and tuned it away?  thanks.
>  
>

