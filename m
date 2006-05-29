Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWE2Wa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWE2Wa1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 18:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWE2Wa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 18:30:27 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:24025 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751439AbWE2Wa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 18:30:26 -0400
Date: Mon, 29 May 2006 19:33:30 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Frank Gevaerts <frank.gevaerts@fks.be>
Cc: Frank Gevaerts <frank.gevaerts@fks.be>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb-serial ipaq kernel problem
Message-ID: <20060529193330.3c51f3ba@home.brethil>
In-Reply-To: <20060529204724.GA22250@fks.be>
References: <20060526182217.GA12687@fks.be>
	<20060526133410.9cfff805.zaitcev@redhat.com>
	<20060529120102.1bc28bf2@doriath.conectiva>
	<20060529132553.08b225ba@doriath.conectiva>
	<20060529141110.6d149e21@doriath.conectiva>
	<20060529194334.GA32440@fks.be>
	<20060529172410.63dffa72@doriath.conectiva>
	<20060529204724.GA22250@fks.be>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 22:47:24 +0200
Frank Gevaerts <frank.gevaerts@fks.be> wrote:

| On Mon, May 29, 2006 at 05:24:10PM -0300, Luiz Fernando N. Capitulino wrote:
| > On Mon, 29 May 2006 21:43:35 +0200
| > Frank Gevaerts <frank.gevaerts@fks.be> wrote:
| > 
| > | On Mon, May 29, 2006 at 02:11:10PM -0300, Luiz Fernando N. Capitulino wrote:
| > | > 
| > | >  Frank, could you try this one please?
| > | > 
| > | >  I have no sure whether this makes sense, but every USB-Serial driver
| > | > I know exits in the write URB callback if the URB got an error.
| > | 
| > | It looks sane to me at least.
| > | The machine is now running with this patch (and my ipaq_open patch, see
| > | http://www.ussg.iu.edu/hypermail/linux/kernel/0605.2/1901.html).
| > 
| >  Hmmm. Then does the workqueue problem began to happen _after_ you applied
| > your patch?
| 
| No. I saw it a few times before that as well. Here is the oldest one I found (using 2.6.15)

 Okay.

| >  Are you sure your patch is the right thing to do? Does it look reasonable
| > to submit that urb 1000 times that way?
| 
| It only submits it once, just after the control message has succeeded.

 Oh, that's right. I didn't see the return statement.

| The loop is needed because sometimes the ipaq takes a very long time
| (more than a minute) before it starts accepting the control message.

 Ok.

| >  At first, it seems something else.
| > 
| >  Couldn't you run your test-case in a kernel previous to the TTY layer
| > buffering revamp change?
| 
| We first used 2.6.15. We got different types of error : a panic in
| ipaq_read_bulk_callback(), the bug I mentionned in
| http://www.ussg.iu.edu/hypermail/linux/kernel/0605.2/1770.html and the
| current problem. We first tried upgrading to 2.6.16, which did not help.
| 
| The panic was caused by the read urb being submitten in ipaq_open,
| regardless of success, and never killed in case of failure. What my
| patch basically does is to submit the urb only after succesfully sending
| the control message, and adding a sleep between tries. As long as this
| patch is not applied, we hardly get any other error because the kernel
| panics as soon as an ipaq reboots.

 I see.

 Did you try to just kill the read urb in the ipaq_open's error path?

-- 
Luiz Fernando N. Capitulino
