Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273724AbRIQW3N>; Mon, 17 Sep 2001 18:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273726AbRIQW3D>; Mon, 17 Sep 2001 18:29:03 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:62726 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S273722AbRIQW25>;
	Mon, 17 Sep 2001 18:28:57 -0400
Date: Mon, 17 Sep 2001 15:26:25 -0700
From: Greg KH <greg@kroah.com>
To: David Acklam <dackl@post.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: compiled-in (non-modular) USB initialization bug
Message-ID: <20010917152625.E32389@kroah.com>
In-Reply-To: <20010917140500.C32389@kroah.com> <Pine.LNX.4.30.0109171717200.2285-300000@Enterprise.udcnet.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0109171717200.2285-300000@Enterprise.udcnet.dyn.dhs.org>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 05:19:05PM -0500, David Acklam wrote:
> 
> I've edited the dmesg output to put a 'marker' between what's modular and
> what's compiled-in. You will note the input0 init is post-FS-mount.

I think you have a timing issue.
The USB input driver is loaded and started before init starts, but it
takes an ammount of time before the USB device is seen by the USB core
and initialized.  This seems to happen _after_ init starts up :)

Other than simply sitting and spinning in the USB init code for all of
the devices to be found before continuing on, I don't know what could be
done for this.

Anyone else have any ideas?

thanks,

greg k-h
