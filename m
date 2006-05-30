Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbWE3P4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWE3P4i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 11:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWE3P4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 11:56:38 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:39049 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751478AbWE3P4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 11:56:37 -0400
Date: Tue, 30 May 2006 12:56:33 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060530125633.58ec8d58@doriath.conectiva>
In-Reply-To: <20060530150627.GB27700@fks.be>
References: <20060526133410.9cfff805.zaitcev@redhat.com>
	<20060529120102.1bc28bf2@doriath.conectiva>
	<20060529132553.08b225ba@doriath.conectiva>
	<20060529141110.6d149e21@doriath.conectiva>
	<20060529194334.GA32440@fks.be>
	<20060529172410.63dffa72@doriath.conectiva>
	<20060529204724.GA22250@fks.be>
	<20060529193330.3c51f3ba@home.brethil>
	<20060530082141.GA26517@fks.be>
	<20060530113801.22c71afe@doriath.conectiva>
	<20060530150627.GB27700@fks.be>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 17:06:27 +0200
Frank Gevaerts <frank.gevaerts@fks.be> wrote:

| On Tue, May 30, 2006 at 11:38:01AM -0300, Luiz Fernando N. Capitulino wrote:
| > On Tue, 30 May 2006 10:21:41 +0200
| > Frank Gevaerts <frank.gevaerts@fks.be> wrote:
| > 
| > | On Mon, May 29, 2006 at 07:33:30PM -0300, Luiz Fernando N. Capitulino wrote:
| > | > On Mon, 29 May 2006 22:47:24 +0200
| > | >  I see.
| > | > 
| > | >  Did you try to just kill the read urb in the ipaq_open's error path?
| > | 
| > | Yes, that's what I did at first. It works, but with the long waits (we see
| > | waits up to 80-90 seconds right now) I was afraid that the urb might timeout
| > | before the control message succeeds.
| > 
| >  Hmmm, I see.
| > 
| >  My only (obvious) question is that if it's really safe to send the read
| > urb after the control message..
| 
| Since it is bulk, it is not guaranteed to start before the control
| message anyway, so it should be safe.
| 
| The patch looks correct to me, but I would still like to increase
| KP_RETRIES a bit. If I read the code correctly, the current setup allows
| for 10 seconds between usb connect and acknowledging the control
| message. This is enough if the device is only connected when booted
| (which is the normal use case). However, in our case, we do
| software-initiated reboots of the ipaq while it is attached to the usb
| bus, which can take much longer, so for us KP_RETRIES should be at least
| 1000, maybe 2000. Of course, we can always run a patched kernel for this.

 Hmmm, what do you think about keeping the current default value and
adding a module parameter to change it?

| I'll test the patch later today.
| 
| Anyway, we have not seen the usb_serial_disconnect bug since applying
| your patch, so that bug is also probably gone (we have had nearly 1000
| successfull connects/disconnects since then)

 Nice to know.

-- 
Luiz Fernando N. Capitulino
