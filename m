Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVBAIwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVBAIwW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 03:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVBAIvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 03:51:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:12473 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261868AbVBAIvA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 03:51:00 -0500
Date: Tue, 1 Feb 2005 00:22:41 -0800
From: Greg KH <greg@kroah.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH 2.6] I2C: Prevent buffer overflow on SMBus block read in i2c-viapro
Message-ID: <20050201082241.GA22023@kroah.com>
References: <20050125224258.GA18228@kroah.com> <btE2IXvS.1106731047.5606340.khali@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <btE2IXvS.1106731047.5606340.khali@localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 10:17:27AM +0100, Jean Delvare wrote:
> 
> Hi Greg, all,
> 
> > Hm, all distros leave the i2c-dev /dev nodes writable only by root, so
> > this isn't that "big" of an issue.
> 
> Agreed. Non-root write access to these devices would probably be a
> security issue per se anyway, buffer overflow or not. However, I can't
> tell if e.g. some embedded systems wouldn't set a particular group on
> these device files and allow write access to this group, so as to allow
> some daemon to write data to an EEPROM or something similar. This is why
> I thought I better warn and push the patch upstream. I wasn't exactly
> requesting 2.6.10.1 to be released ;)
> 
> On second thought, I doubt that embedded designs would rely on a VIA Pro
> chip anyway. But you never know.
> 
> > > @@ -268,6 +268,8 @@
> > >  		break;
> > >  	case VT596_BLOCK_DATA:
> > >  		data->block[0] = inb_p(SMBHSTDAT0);
> > > +		if (data->block[0] > I2C_SMBUS_BLOCK_MAX)
> > > +			data->block[0] = I2C_SMBUS_BLOCK_MAX;
> >
> > But data->block[0] just came from the hardware, right?  Not from a user.
> 
> True, except that with a write access to the device file and depending on
> the client chip, the user might have just programmed the chip for it to
> answer with this specific value. See right below.
> 
> > Now if we have broken hardware, then we might have a problem here, but
> > otherwise I don't see it as a security issue right now.
> 
> It doesn't take broken hardware.
> 
> (Warning: I am going technical at this point, people not interested in
> the gory details of the I2C and SMBus protocols should better stop here
> ;))

<snip>

Thanks for the good description.  I've applied your patch to my trees
and will push it upward soon.

thanks,

greg k-h
