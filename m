Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262451AbUFJTPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbUFJTPN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 15:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbUFJTPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 15:15:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31640 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262451AbUFJTOB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 15:14:01 -0400
Date: Thu, 10 Jun 2004 20:14:00 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Greg KH <greg@kroah.com>
Cc: sensors@stimpy.netroedge.com,
       "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Finding user/kernel pointer bugs [no html]
Message-ID: <20040610191359.GJ12308@parcelfarce.linux.theplanet.co.uk>
References: <1086838266.32059.320.camel@dooby.cs.berkeley.edu> <20040610044903.GE12308@parcelfarce.linux.theplanet.co.uk> <20040610165821.GB32577@kroah.com> <20040610191004.GA1661@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040610191004.GA1661@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 12:10:04PM -0700, Greg KH wrote:
> @@ -170,8 +170,11 @@
>  static int DIV_TO_REG(int val)
>  {
>  	int answer = 0;
> -	while ((val >>= 1))
> +	val >>= 1;
> +	while (val) {
>  		answer++;
> +		val >>= 1;
> +	}
>  	return answer;

That's less readable than the original...

> -		data_ptrs = (u8 **) kmalloc(rdwr_arg.nmsgs * sizeof(u8 *),
> -					    GFP_KERNEL);
> +		data_ptrs = kmalloc(rdwr_arg.nmsgs * sizeof(u8 __user *), GFP_KERNEL);

While we are at it, what's the type of ->nmsgs?
