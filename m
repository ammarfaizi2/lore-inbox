Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262080AbTCZUSq>; Wed, 26 Mar 2003 15:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262082AbTCZUSq>; Wed, 26 Mar 2003 15:18:46 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:5382 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262080AbTCZUSp>;
	Wed, 26 Mar 2003 15:18:45 -0500
Date: Wed, 26 Mar 2003 12:29:04 -0800
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       sensors@Stimpy.netroedge.com
Subject: Re: w83781d i2c driver updated for 2.5.66 (without sysfs support)
Message-ID: <20030326202904.GK24689@kroah.com>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048705473.7569.10.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 09:04:33PM +0200, Martin Schlemmer wrote:
> Hi
> 
> Ok, this is the w83781d driver updated for 2.5.66bk2.  It works
> over here.

Looks nice, thanks.

Some of the nasty casts should be fixed up though.  Stuff like:

> +      ERROR7:
> +	if (!is_isa)
> +		i2c_detach_client(&
> +				  (((struct w83781d_data
> +				     *) (i2c_get_clientdata(new_client)))->
> +				   lm75[1]));
> +      ERROR6:
> +	if (!is_isa)
> +		i2c_detach_client(&
> +				  (((struct w83781d_data
> +				     *) (i2c_get_clientdata(new_client)))->
> +				   lm75[0]));
> +      ERROR5:
> +	if (!is_isa)
> +		kfree(((struct w83781d_data *) (i2c_get_clientdata(new_client)))->
> +		      lm75);

Is just obnoxious :)

I'll hold off sending this driver to Linus until it gets cleaned up with
sysfs entries, as I'd rather not pollute /proc and sysctls anymore.

thanks,

greg k-h
