Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161095AbVIPN4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbVIPN4I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 09:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161096AbVIPN4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 09:56:08 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:37160 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161095AbVIPN4H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 09:56:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pPSlTk3dx8ZQnNiNR81JAI6Oz3o6ImrXHgRCemizHVbpnzt2V154nY2rgLRz7npBEBsiShYO25wcEHeEzFG2rRcQ4gPjMhB+WB1POURwXS41t4VzJfEtYZ8hJYuzhs1GSI6DXbD2WI6Td0s+Iek7WC7XnX8Hb+NhFBVOiZ8hV6k=
Message-ID: <9a874849050916065511a6f973@mail.gmail.com>
Date: Fri, 16 Sep 2005 15:55:55 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: Rogier Wolff <R.E.Wolff@bitwizard.nl>
Subject: Re: early printk timings way off
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050916103002.GA19839@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509152342.24922.jesper.juhl@gmail.com>
	 <Pine.LNX.4.58.0509151458330.1800@shark.he.net>
	 <9a87484905091515072c7dd4a8@mail.gmail.com>
	 <Pine.LNX.4.58.0509151537140.29737@shark.he.net>
	 <9a87484905091515495f435db7@mail.gmail.com>
	 <Pine.LNX.4.58.0509151554450.29737@shark.he.net>
	 <9a874849050915160027db1fe9@mail.gmail.com>
	 <20050916103002.GA19839@bitwizard.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/05, Rogier Wolff <R.E.Wolff@bitwizard.nl> wrote:
> On Fri, Sep 16, 2005 at 01:00:45AM +0200, Jesper Juhl wrote:
> >
> > I'll just dig into it myself for now, but thank you, if I get really
> > stuck I may ask him.
> 
> The explanation: "jiffies starts at rollover minus a bit" seems to be
> spot-on: If jiffies are 32bit, and counting at 1000 per second, the
> 2^32 / 1000 works out.
> 
> I expect the kernel to run without turning on (timer) interrupts for a
> while during boot: It is still initializing things like memory and the
> processor. Without those, interrupts won't work. This means that the
> timer interrupt will not count in real-time.
> 
> A "jump" of 27 seconds seems unlikely, except if somehow the
> interrupts are somehow accounted. It could very well be that the
> kernel nowadays has a mechanism of measuring the fact that it missed a
> timer interrupt and corrects for that. This would mean that around the
> "jump", the kernel suddenly realized it missed around 27000 interrupts
> and added 27000 to "jiffies"....
> 
> I'd say: Would be nice to get the timings right, but not worth the
> trouble: There are good technical reasons for the observed facts.
> 
Thank you for that explanation Rogier.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
