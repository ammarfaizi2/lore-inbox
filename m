Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbUKVTpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbUKVTpc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbUKVTnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:43:52 -0500
Received: from gateway.penguincomputing.com ([64.243.132.186]:61145 "EHLO
	inside.penguincomputing.com") by vger.kernel.org with ESMTP
	id S262551AbUKVTmB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:42:01 -0500
X-Mda: Mail::Internet Mail::Sendmail Sendmail +mmhack 1.1 on Linux
Cc: greg@kroah.com, phil@netroedge.com, khali@linux-fr.org,
       sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org
User-Agent: Mutt/1.4.1i
Subject: Re: adm1026 driver port for kernel 2.6.10-rc2  [RE-REVISED DRIVER]
In-Reply-To: <1100945635.2639.31.camel@laptop.fenrus.org>
Content-Disposition: inline
Date: Mon, 22 Nov 2004 11:43:27 -0800
Message-Id: <20041122194327.GB4698@penguincomputing.com>
References: <20041102221745.GB18020@penguincomputing.com>
 <NN38qQl1.1099468908.1237810.khali@gcu.info>
 <20041103164354.GB20465@penguincomputing.com>
 <20041118185612.GA20728@penguincomputing.com>
 <1100945635.2639.31.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Arjan van de Ven <arjan@infradead.org>
Content-Transfer-Encoding: 8BIT
From: Justin Thiessen <jthiessen@penguincomputing.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 11:13:56AM +0100, Arjan van de Ven wrote:
> On Thu, 2004-11-18 at 10:56 -0800, Justin Thiessen wrote:
> > MODULE_PARM(gpio_input,"1-17i");
> 
> new 2.6 drivers should NOT use MODULE_PARM, it's deprecated.
> use module_param() instead

Ok.  You mean module_param_array() in these particular cases, right?

> > int adm1026_attach_adapter(struct i2c_adapter *adapter)
> > {
> > 	if (!(adapter->class & I2C_CLASS_HWMON)) {
> > 		return 0;
> > 	}
> 
> no need for extra { }'s in such a case

Of course there's no _need_.  But I find the result stylistically easier to 
read.  Is there any real objection?

> > static ssize_t show_in(struct device *dev, char *buf, int nr)
> > {
> > 	struct adm1026_data *data = adm1026_update_device(dev);
> > 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in[nr]));
> > }
> 
> any chance you could make this use snprintf instead ?

I'll defer to Jean's response...

<snip awkward locking construct>

> this locking construct is rahter awkward; is it possible to refactor the
> code such that you can down and up in the same function ?

Yes, at the cost of some minor code duplication or the introduction of
another variable.  Is that preferable?  Is holding the lock across function
calls a Bad Idea?

Justin Thiessen
---------------
jthiessen@penguincomputing.com

