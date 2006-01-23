Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWAWTuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWAWTuo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWAWTuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:50:44 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:34382 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932463AbWAWTun convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:50:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hKUVh0ELqks5+Wm9WMLn/CQDHlRyUhGKzYhoeXuf21BiFXy7gSo17D7TedZzap/YC5fxjoYlu4aGVsWgZGxqKDb2wuIIgLQh8kxOAgkEdLpb271m0tu34OAQI56FgtrOvIzYO6qr+eX+3ZdN+ZFYFyZdBVe4vV7XdcL27gv35uI=
Message-ID: <5c49b0ed0601231150i39e678f3s9dd99c308ffb5157@mail.gmail.com>
Date: Mon, 23 Jan 2006 11:50:41 -0800
From: Nate Diller <nate.diller@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 1/2][RESEND] Default iosched fixes (was: Fall back io scheduler for 2.6.15?)
Cc: Andrew Morton <akpm@osdl.org>, cmm@us.ibm.com, seelam@cs.utep.edu,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <20060121114841.GT13429@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5c49b0ed0601191604p4fa53404r783b3a703e922b13@mail.gmail.com>
	 <20060120081145.GD4213@suse.de>
	 <5c49b0ed0601201517h3126ac8dp931bab93a85bf9c5@mail.gmail.com>
	 <20060121114841.GT13429@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/06, Jens Axboe <axboe@suse.de> wrote:
> On Fri, Jan 20 2006, Nate Diller wrote:
> > My previous default iosched patch did a poor job dealing with the
> > 'elevator=' boot-time option.  The old behavior falls back to the
> > compiled-in default if the requested one is not registered at boot
> > time.  This patch dynamically evaluates which default
> > to use, and emits a suitable error message when the requested scheduler
> > is not available.  It also does the 'as' -> 'anticipatory' conversion
> > before elevator registration, which along with a modified registration
> > function, allows it to correctly indicate which default scheduler is
> > in use.
>
> I'm a little confused by your description - what problem does this patch
> actually solve? We already fall back to the default, and we already do
> the "as" conversion. It does seem to cleanup the code, just curious
> since your description seems to promise a little more than what it
> actually adds.

It makes the ' (default)' printk that happens at elevator registration
time behave (more) correctly.  My original patch rather ignored that
segment of code.  The current behavior is to only print ' (default)'
when one was specified at boot time, and not if 'as' was requested
either, since it doesn't understand the 'as -> anticipatory'
conversion.  Now, it will display correctly the one selected at
compile-time, if none was specified at boot, and when the boot-time
option was 'as'.

It also handles modular defaults better; although they cannot be
specified in kconfig, a default requested at boot-time will now still
work, even if it's a module.  When the boot-time requested scheduler
is not loaded, it will fall back to the compiled-in default; when it
is, it gets used.

NATE
