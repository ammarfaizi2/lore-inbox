Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132529AbRCZSBD>; Mon, 26 Mar 2001 13:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132528AbRCZSAz>; Mon, 26 Mar 2001 13:00:55 -0500
Received: from [166.70.28.69] ([166.70.28.69]:64830 "EHLO flinx.biederman.org")
	by vger.kernel.org with ESMTP id <S132516AbRCZSAj>;
	Mon, 26 Mar 2001 13:00:39 -0500
To: LA Walsh <law@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
In-Reply-To: <3ABF70B9.573C2F85@sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 26 Mar 2001 10:58:54 -0700
In-Reply-To: LA Walsh's message of "Mon, 26 Mar 2001 08:39:21 -0800"
Message-ID: <m1hf0gza1t.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LA Walsh <law@sgi.com> writes:

> I vaguely remember a discussion about this a few months back.
> If I remember, the reasoning was it would unnecessarily slow
> down smaller systems that would never have block devices in
> the 4-28T range attached.  

With classic 512 byte sectors the top size is right about 2TB.

The basic thought is that 64bit numbers tend to suck, so we don't
want then in any fast paths on a 32bit system.

> However, isn't it possible there will continue to be a series
> of P-IV,V,VI,VII ...etc, addons that will be used for sometime
> to come.  I've even heard it suggested that we might see
> 2 or more CPU's on a single chip as a way to increase cpu
> capacity w/o driving up clock speed.  Given the cheapness of
> .25T drives now, seeing the possibility of 4T drives doesn't seem
> that remote (maybe 5 years?).  
> 
> Side question: does the 32-bit block size limit also apply to 
> RAID disks or does it use a different block-nr type?
For now yes it does.

> 
> So...is it the plan, or has it been though about -- 'abstracting'
> block numbes as a typedef 'block_nr', then at compile time
> having it be selectable as to whether or not this was to
> be a 32-bit or 64 bit quantity -- that way older systems would
> lose no efficiency.  Drivers that couldn't be or hadn't been
> ported to use 'block_nr' could default to being disabled if
> 64-bit blocks were selected, etc.
> 
> So has this idea been tossed about and or previously thrashed?

Using a 64bit number of 32bit systems has so far been trashed.
Though this does look like a real problem that needs to be solved
at some point.  I doubt we can wait past 2.5 though if we want the
code ready when the hardware is.

Eric
