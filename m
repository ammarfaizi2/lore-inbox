Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWFBNje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWFBNje (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 09:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbWFBNje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 09:39:34 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:32978 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751423AbWFBNjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 09:39:33 -0400
Date: Fri, 2 Jun 2006 10:39:29 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk,
       linux-usb-devel@lists.sourceforge.net, zaitcev@redhat.com
Subject: Re: [PATCH RFC 0/11] usbserial: Serial Core port.
Message-ID: <20060602103929.0a89a920@doriath.conectiva>
In-Reply-To: <20060601234833.adf12249.zaitcev@redhat.com>
References: <1149217397133-git-send-email-lcapitulino@mandriva.com.br>
	<20060601234833.adf12249.zaitcev@redhat.com>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Pete,

On Thu, 1 Jun 2006 23:48:33 -0700
Pete Zaitcev <zaitcev@redhat.com> wrote:

| On Fri, 02 Jun 2006 00:03:06 -0300, "Luiz Fernando N.Capitulino" <lcapitulino@mandriva.com.br> wrote:
| 
| This looks interesting, although I do not know if it buys us much.

 Yeah, it will be a lot of work to port all the USB-Serial drivers to the
new interface. We have to discuss if it really pays off.

 IMHO, yes, it does. Currently, USB-Serial is duplicating code and solutions
from the Serial Core implementation. From the kernel POV, we're maintaining
two interfaces to solve (almost) the same problem.

 Killing one of the interfaces would make people concetrate in only one
of them.

| The code seems sane at first view. The private lock inside pl2303
| saves you from the most obvious races.

 But I wonder why I couldn't just use the Serial Core's spinlock for
that.

| >  The tests I've done so far weren't anything serious: as the mobile supports a
| > AT command set, I have used the ones (with minicom) which transfers more data.
| > Of course that I also did module load/unload tests, tried to disconnect the
| > device while it's transfering data and so on.
| 
| Next, it would be nice to test if PPP works, and if getty and shell work
| (with getty driving the USB-to-serial adapter).

 Hmmmm. I'll have to buy a new simcard for that (I can't use GPRS with the
one I have), then it will have to wait some days.

 Would be good to get some help here. :)

| > +static void serial_send_xchar(struct uart_port *port, char ch)
| > +{
| > +	USBSERIAL_PORT->serial->type->uart_ops->send_xchar(port, ch);
| >  }
| 
| I think you just inherited a mistake in usb-serial design. It attempts
| to act as an adaptation layer (like, say, USB core itself) instead of
| a library like libata. Why can't the UART framework call pl2303?

 Good point.

 In my first version of the port, I added additional code to handle
the multi-port thing. When it worked, I realized that that code wasn't
necessary: just registering each port with the Serial Core seems
enough.

 Then yes, I think we can do it.

 Will think more about that and try a new version in the weekend.

 Well, for some reason the patchset e-mails didn't reach LKML.
That's strange, because our replies are going there.

 Either, git-send-email has a bug or I did something wrong.

 Anyways, I just uploaded the patchset to:

http://distro2.conectiva.com.br/~lcapitulino/patches/usbserial/2.6.17-rc5/

-- 
Luiz Fernando N. Capitulino
