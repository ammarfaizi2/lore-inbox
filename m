Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270153AbTGPFzY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 01:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270151AbTGPFzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 01:55:23 -0400
Received: from mail.kroah.org ([65.200.24.183]:42465 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270158AbTGPFzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 01:55:18 -0400
Date: Tue, 15 Jul 2003 23:10:09 -0700
From: Greg KH <greg@kroah.com>
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t1: i2c+sensors still whacky (hi Greg :)
Message-ID: <20030716061009.GA5037@kroah.com>
References: <20030715090726.GJ363@zip.com.au> <20030715161127.GA2925@kroah.com> <20030716060443.GA784@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716060443.GA784@zip.com.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 04:04:43PM +1000, CaT wrote:
> On Tue, Jul 15, 2003 at 09:11:27AM -0700, Greg KH wrote:
> > On Tue, Jul 15, 2003 at 07:07:27PM +1000, CaT wrote:
> > So, if you don't have any i2c code loaded, everything works?  How about
> 
> Yes.
> 
> > just loading the i2c driver and not the sensor driver?
> 
> All's fine.
> 
> > Oh, how about enabiling debugging in the i2c driver that you are using?
> 
> Well this is what I did:
> 
> 11 [15:53:38] root@theirongiant:/usr/src/linux/drivers/i2c>> grep 'define DEBUG' . -r
> ./i2c-core.c:#define DEBUG 1            /* needed to pick up the dev_dbg() calls */
> ./scx200_acb.c:#define DEBUG 0
> ./i2c-sensor.c:#define DEBUG 1
> ./i2c-algo-bit.c:/* #define DEBUG 1 */
> ./i2c-dev.c:#define DEBUG 1
> ./i2c-algo-pcf.c:/* #define DEBUG 1 */          /* to pick up dev_dbg calls */
> ./busses/i2c-amd756.c:/* #define DEBUG 1 */
> ./busses/i2c-ali15x3.c:/* #define DEBUG 1 */
> ./busses/i2c-i801.c:/* #define DEBUG 1 */
> ./busses/i2c-piix4.c:#define DEBUG 1
> ./busses/i2c-sis96x.c:/* #define DEBUG */
> ./busses/i2c-ali1535.c:/* #define DEBUG 1 */
> ./chips/adm1021.c:#define DEBUG 1
> ./chips/lm75.c:/* #define DEBUG 1 */
> 
> Did I do the right thing?

Looks good, but are you _really_ building all of those drivers into your
kernel?  Make them modules, that way booting will not require a small
nap :)

Then load only the i2c bus driver that you have.  See if that causes the
system to slow down, or cause any kernel log messages?

Only then try loading a i2c client driver, for your hardware.

Exactly what i2c hardware do you have anyway?

thanks,

greg k-h
