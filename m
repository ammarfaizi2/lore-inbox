Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbUKWSBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbUKWSBH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbUKWSAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:00:09 -0500
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:60169 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261420AbUKWR6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 12:58:19 -0500
Date: Tue, 23 Nov 2004 18:58:20 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Justin Thiessen <jthiessen@penguincomputing.com>,
       Arjan van de Ven <arjan@infradead.org>
Cc: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: adm1026 driver port for kernel 2.6.10-rc2  [RE-REVISED DRIVER]
Message-Id: <20041123185820.5b58ef86.khali@linux-fr.org>
In-Reply-To: <20041122194327.GB4698@penguincomputing.com>
References: <20041102221745.GB18020@penguincomputing.com>
	<NN38qQl1.1099468908.1237810.khali@gcu.info>
	<20041103164354.GB20465@penguincomputing.com>
	<20041118185612.GA20728@penguincomputing.com>
	<1100945635.2639.31.camel@laptop.fenrus.org>
	<20041122194327.GB4698@penguincomputing.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > int adm1026_attach_adapter(struct i2c_adapter *adapter)
> > > {
> > > 	if (!(adapter->class & I2C_CLASS_HWMON)) {
> > > 		return 0;
> > > 	}
> > 
> > no need for extra { }'s in such a case
> 
> Of course there's no _need_.  But I find the result stylistically
> easier to read.  Is there any real objection?

There isn't as far as I can tell. The CodingStyle document doesn't
mention a preference for any form or the other, nor does Greg's talk
about coding style. This means that you are free. If anyone wants it the
other way and is brave enough, he/she can submit an incremental patch
for Greg to consider and see how Greg receives it ;)

> > > static ssize_t show_in(struct device *dev, char *buf, int nr)
> > > {
> > > 	struct adm1026_data *data = adm1026_update_device(dev);
> > > 	return sprintf(buf,"%d\n", INS_FROM_REG(nr, data->in[nr]));
> > > }
> > 
> > any chance you could make this use snprintf instead ?
> 
> I'll defer to Jean's response...

And I'll defer to Arjan's myself. As said in another post, no other i2c
client driver does use snprintf. If there is no good reason for them to
do (and actually I don't see any) let's stick to sprintf for everyone.
If there is, then we shall fix all drivers, not only adm1026.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
