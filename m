Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbUKXVkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbUKXVkR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 16:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbUKXVh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 16:37:28 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:21935 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262860AbUKXVgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 16:36:18 -0500
Date: Wed, 24 Nov 2004 13:36:00 -0800
From: Greg KH <greg@kroah.com>
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: phil@netroedge.com, khali@linux-fr.org, sensors@Stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: adm1026 driver port for kernel 2.6.10-rc2 (patch includes driver, patch to Kconfig, and patch to Makefile)
Message-ID: <20041124213600.GA3165@kroah.com>
References: <20041102221745.GB18020@penguincomputing.com> <NN38qQl1.1099468908.1237810.khali@gcu.info> <20041103164354.GB20465@penguincomputing.com> <20041118185612.GA20728@penguincomputing.com> <20041123165236.GA4936@penguincomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123165236.GA4936@penguincomputing.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, this looks like a bug:

> +static ssize_t set_pwm_enable(struct device *dev, const char *buf,
> +		size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adm1026_data *data = i2c_get_clientdata(client);
> +	int     val;
> +	int     old_enable;
> +
> +	if ((val >= 0) && (val < 3)) {

You are using val before assigning it anything.  The compiler warns you
about this issue.

Care to fix this up and resend the whole patch?

Oh, and it should be "Signed-off-by:" not "Signed off by:" like you had
used :)

thanks,

greg k-h
