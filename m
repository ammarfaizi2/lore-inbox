Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWE3Oxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWE3Oxb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 10:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWE3Oxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 10:53:31 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:41612 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932299AbWE3Oxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 10:53:30 -0400
Date: Tue, 30 May 2006 11:53:29 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060530115329.30184aa0@doriath.conectiva>
In-Reply-To: <20060530113801.22c71afe@doriath.conectiva>
References: <20060526182217.GA12687@fks.be>
	<20060526133410.9cfff805.zaitcev@redhat.com>
	<20060529120102.1bc28bf2@doriath.conectiva>
	<20060529132553.08b225ba@doriath.conectiva>
	<20060529141110.6d149e21@doriath.conectiva>
	<20060529194334.GA32440@fks.be>
	<20060529172410.63dffa72@doriath.conectiva>
	<20060529204724.GA22250@fks.be>
	<20060529193330.3c51f3ba@home.brethil>
	<20060530082141.GA26517@fks.be>
	<20060530113801.22c71afe@doriath.conectiva>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2006 11:38:01 -0300
"Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:

| On Tue, 30 May 2006 10:21:41 +0200
| Frank Gevaerts <frank.gevaerts@fks.be> wrote:
| 
| | On Mon, May 29, 2006 at 07:33:30PM -0300, Luiz Fernando N. Capitulino wrote:
| | > On Mon, 29 May 2006 22:47:24 +0200
| | > Frank Gevaerts <frank.gevaerts@fks.be> wrote:
| | > | 
| | > | The panic was caused by the read urb being submitten in ipaq_open,
| | > | regardless of success, and never killed in case of failure. What my
| | > | patch basically does is to submit the urb only after succesfully sending
| | > | the control message, and adding a sleep between tries. As long as this
| | > | patch is not applied, we hardly get any other error because the kernel
| | > | panics as soon as an ipaq reboots.
| | > 
| | >  I see.
| | > 
| | >  Did you try to just kill the read urb in the ipaq_open's error path?
| | 
| | Yes, that's what I did at first. It works, but with the long waits (we see
| | waits up to 80-90 seconds right now) I was afraid that the urb might timeout
| | before the control message succeeds.
| 
|  Hmmm, I see.

 Thinking about this again, are you sure the read urb depends on the
control message? It's quite easy to test, just a add a long timeout after
the read URB was sent (say, five minutes) and waits for the read urb
callback to run.

 If it ran _before_ the timeout expires with no timeout error it does not
depend. Then we can do the simpler solution: just kill the read urb in the
ipaq_open's error path.

-- 
Luiz Fernando N. Capitulino
