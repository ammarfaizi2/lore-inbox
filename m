Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161093AbWBYT43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161093AbWBYT43 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 14:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161094AbWBYT43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 14:56:29 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:47750 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161093AbWBYT43 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 14:56:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nh3JKu7mGsfwXr5z3FzOQ/9uXCy1U4STIJOl1291OcXffLYzqwUR2xVtB4pa05X61ajRpQTd2QxZslqBzbvhXV0yczjK+kdXgSzu4HFVVTuiCf3vbNxJ4f89CQ218IWMO5NpHv16RJxcJwBLA/YY/wTNQTWz2W1g693ZSSiGzuo=
Message-ID: <9a8748490602251156y6dc22a7by53b85570feb8d4a7@mail.gmail.com>
Date: Sat, 25 Feb 2006 20:56:27 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Avi Kivity" <avi@argo.co.il>
Subject: Re: New reliability technique
Cc: "Victor Porton" <porton@ex-code.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4400B562.6020203@argo.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1FCzMX-0000Ym-00@porton.narod.ru>
	 <9a8748490602250526p2187e04ej9a680e6b2b948e7d@mail.gmail.com>
	 <9a8748490602250527l78e057ecvcd2e656b8ff5c9f2@mail.gmail.com>
	 <4400B562.6020203@argo.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/06, Avi Kivity <avi@argo.co.il> wrote:
> Jesper Juhl wrote:
>
> >On 2/25/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> >
> >>On 2/25/06, Victor Porton <porton@ex-code.com> wrote:
> >>
> >>
> >>>A minute ago I invented a new reliability enhancing technique.
> >>>
> >>>In idle cycles (or periodically in expense of some performance) Linux can
> >>>calculate MD5 or CRC sums of _unused_ (free) memory areas and compare these
> >>>sums with previously calculated sums.
> >>>
> >>>Additionally it can be done for allocated memory, if it will be write
> >>>protected before the first actual write. Moreover, all memory may be made
> >>>write-protected if it is not written e.g. more than a second. (When it
> >>>is written kernel would unlock it and allow to write, by a techniqie like
> >>>to how swap works.) If write-protected memory appears to be modified by
> >>>a check sum, this likewise indicates a bug.
> >>>
> >>>If a sum is inequal, it would notice a bug in kernel or in hardware.
> >>>
> >>>I suggest to add "Check free memory control sums" in config.
> >>>
> >>>
> >>>
> >>Implement it then and send a patch.
> >>
> >>
> >>
> >
> >But, doesn't slab poisoning and the like already cover this ground somewhat?
> >
> >
> >
> No, they don't. They cover only a very small percentage of memory.
>

Ohh, ok, then it makes sense as a debug thing.

Let's see an implementation then.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
