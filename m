Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVA0UnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVA0UnL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 15:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVA0UnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 15:43:09 -0500
Received: from rproxy.gmail.com ([64.233.170.207]:59873 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261179AbVA0Ule (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 15:41:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=kqqClabjLc1wOqhK2cDfLl1gXQchqLaLzNDViADyWCXyMzAzO0luhsLp7XWyx5s7hkGXdiwRSOlzeTwKn/OZiQYTXwv90rZpFAC1cFTbWxw1zMv0+R/gSOjdYxItVLwuhyrKa6F8yrNzPrtM+i2aRpZWQYpxcK9qGcU7+G79G+8=
Message-ID: <d120d50005012712411b6a1bf7@mail.gmail.com>
Date: Thu, 27 Jan 2005 15:41:32 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: i8042 access timings
Cc: Linus Torvalds <torvalds@osdl.org>, Jaco Kroon <jaco@kroon.co.za>,
       sebekpi@poczta.onet.pl, Vojtech Pavlik <vojtech@suse.cz>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050127202947.GD6010@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200501260040.46288.sebekpi@poczta.onet.pl>
	 <41F888CB.8090601@kroon.co.za>
	 <Pine.LNX.4.58.0501270948280.2362@ppc970.osdl.org>
	 <20050127202947.GD6010@pclin040.win.tue.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005 21:29:47 +0100, Andries Brouwer <aebr@win.tue.nl> wrote:
> On Thu, Jan 27, 2005 at 10:09:24AM -0800, Linus Torvalds wrote:
> 
> > So what _might_ happen is that we write the command, and then
> > i8042_wait_write() thinks that there is space to write the data
> > immediately, and writes the data, but now the data got lost because the
> > buffer was busy.
> 
> Hmm - I just answered the same post and concluded that I didnt understand,
> so you have progressed further. I considered the same possibility,
> but the data was not lost since we read it again later.
> Only the ready flag was lost.
> 

No, note that if there was valid data we would dee 0xa5 instead of
0x5a that was in the buffer - because in i8042_command we invert data
coming from AUX port. So Linus's theory seems feasible.
 

-- 
Dmitry
