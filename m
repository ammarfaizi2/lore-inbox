Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268926AbRI0GdV>; Thu, 27 Sep 2001 02:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268133AbRI0GdM>; Thu, 27 Sep 2001 02:33:12 -0400
Received: from qn-212-127-144-62.quicknet.nl ([212.127.144.62]:19973 "HELO
	smcc.demon.nl") by vger.kernel.org with SMTP id <S266488AbRI0GdF>;
	Thu, 27 Sep 2001 02:33:05 -0400
Message-ID: <XFMail.010927083327.nemosoft@smcc.demon.nl>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20010926191123.A30545@cs.cmu.edu>
Date: Thu, 27 Sep 2001 08:33:27 +0200 (MEST)
Organization: I'm not organized
From: "Nemosoft Unv." <nemosoft@smcc.demon.nl>
To: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: RE: [PATCH -R] Re: 2.4.10 is toxic to my system when I use my US
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, webcam@smcc.demon.nl,
        "Eloy A.Paris" <eloy.paris@usa.net>,
        linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

On 26-Sep-01 Jan Harkes wrote:
> On Wed, Sep 26, 2001 at 10:43:54AM -0400, Eloy A. Paris wrote:
>> I have been doing some tests to determine where the problems is. The
[snip]

> It hit me as well and I found the culprit, the crash happens in
> usb-uhci.c:process_iso, where the following code used to be 'safe'
> 
>       for (i = 0; p != &urb_priv->desc_list; i++) {
> ...
>           list_del (p);
>           p = p->next;
>           delete_desc (s, desc);
>       }
> 
> However, some infidel sneaked the following change into 2.4.10, late in
> the testcycle, which is deadly. This patch needs to be reverted. If the
> behaviour is wanted all uses of list_del in the kernel need to be looked
> at very closely.

Personally, I say the above piece of code is faulty. Refering to a
pointer after you appearently deleted it, is just very bad programming
practice. 

I´d say, fix the usb-uhci file, and do a quick run on all other instances
of list_del. I think most programmers got it right, or 2.4.10 kernels would
be coming down all over the planet.

 - Nemosoft

-----------------------------------------------------------------------------
Try SorceryNet!   One of the best IRC-networks around!   irc.sorcery.net:9000
URL: never        IRC: nemosoft      IscaBBS (bbs.isca.uiowa.edu): Nemosoft
                        >> Never mind the daylight << 
