Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285352AbSCFXZP>; Wed, 6 Mar 2002 18:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285720AbSCFXZF>; Wed, 6 Mar 2002 18:25:05 -0500
Received: from mnh-1-11.mv.com ([207.22.10.43]:39435 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S285352AbSCFXYv>;
	Wed, 6 Mar 2002 18:24:51 -0500
Message-Id: <200203062326.SAA05223@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Malcolm Beattie <mbeattie@clueful.co.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Benjamin LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Wed, 06 Mar 2002 21:27:00 GMT."
             <20020306212700.A16144@clueful.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 06 Mar 2002 18:26:04 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mbeattie@clueful.co.uk said:
> A "quich hack" that turns out to have rather useful, fun properties is
> to have a little device driver (can be a module) which stores
> "negative pages" in the page cache by allocating page cache pages for
> the device's inode and then invoking the CP "release page" call
> mentioned above. 

Yeah, I was thinking about something like that.  It's unclear how it should
figure out how much memory to grab, though.  You'd have to get some idea
how desperate the host is for memory and balance that off against how 
desperate the VM is.

And you want to avoid doing things that just aggravate the host's situation,
i.e. if it is swapping its brains out, you want the VM to just drop some
clean pages and you definitely don't want it swapping dirty ones and add
to the host's IO load.

>  However, closer
> integration with the main mm system is the "proper" way to do it (but
> depends on stuff like the latency, overheads and information shared
> with CP so is a little more than an afternoon hack.)

Yup.

Is any of your (you or IBM in general) thinking on this written down publically
anywhere?

				Jeff

