Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbTDHT6o (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 15:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbTDHT6o (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 15:58:44 -0400
Received: from granite.he.net ([216.218.226.66]:26117 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261715AbTDHT6n (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 15:58:43 -0400
Date: Tue, 8 Apr 2003 13:12:40 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] [PATCH] USB speedtouch: don't open a connection if no firmware
Message-ID: <20030408201239.GA5828@kroah.com>
References: <200304080926.43403.baldrick@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304080926.43403.baldrick@wanadoo.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 09:26:43AM +0200, Duncan Sands wrote:
> @@ -967,13 +969,12 @@
>  
>  	dbg ("Allocated new SARLib vcc 0x%p with vpi %d vci %d", new, vpi, vci);
>  
> -	MOD_INC_USE_COUNT;
> -
> -	if (instance->firmware_loaded)
> -		udsl_fire_receivers (instance);
> +	udsl_fire_receivers (instance);
>  
>  	dbg ("udsl_atm_open successful");
>  
> +	MOD_INC_USE_COUNT;
> +
>  	return 0;
>  }
>  

Any way you can convert this driver to not use MOD_INC_USE_COUNT, as
it's racy and not really supported anymore?  But if you _really_ have to
use it, you need to call it at the first possible chance to make any
race window smaller.

thanks,

greg k-h
