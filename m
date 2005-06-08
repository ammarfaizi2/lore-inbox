Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVFHGRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVFHGRj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 02:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVFHGRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 02:17:39 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:21931 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262115AbVFHGRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 02:17:24 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, Adam Morley <adam.morley@gmail.com>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: psmouse doesn't seem to reinitialize after mem suspend (acpi) when using i8042 on ALi M1553 ISA bridge with 2.6.11.11 or 2.6.12-rc5?
Date: Wed, 8 Jun 2005 01:17:20 -0500
User-Agent: KMail/1.8.1
References: <b70d73800506051924546c8931@mail.gmail.com> <200506072252.40120.dtor_core@ameritech.net> <b70d738005060721584aa25e71@mail.gmail.com>
In-Reply-To: <b70d738005060721584aa25e71@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506080117.20803.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 June 2005 23:58, Adam Morley wrote:
> On 6/7/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > On Monday 06 June 2005 02:28, Adam Morley wrote:
> > > Hi Dimitry,
> > >
> > > On 6/5/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > > > On Sunday 05 June 2005 21:24, Adam Morley wrote:
> > > >  > When I do a mem suspend (echo mem > /sys/power/state), either through
> > > > > a lid switch ACPI action, or manually echo'ing the parameter, the
> > > > > mouse doesn't work after un-suspending.  It seems like it is no longer
> > > > > detected/initialized.  cat'ing the device file doesn't produce output,
> > > > > and gpm and X don't get mouse inputs.
> > > >
> > > > Could you please try booting 2.6.12-rc5 with "i8042.debug" on the kernel
> > > > command line; suspend, resume and post your dmesg?
> > >
> > > Sure.  Here it is.  Suspend was done using acpid using a lid action.
> > > psmouse was modprobe -r'ed before suspend and modprobe'ed back in
> > > after resume.
> > >
> > 
> > We are trying to resume but KBC signals timeout condition every time we
> > ping AUX port:
> > 
> > > drivers/input/serio/i8042.c: 60 -> i8042 (command) [220701]
> > > drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [220701]
> > > drivers/input/serio/i8042.c: d4 -> i8042 (command) [220703]
> > > drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [220703]
> > > drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12, timeout) [220725]
> > > drivers/input/serio/i8042.c: d4 -> i8042 (command) [220726]
> > > drivers/input/serio/i8042.c: ed -> i8042 (parameter) [220726]
> > > drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12, timeout) [220747]
> > > drivers/input/serio/i8042.c: 60 -> i8042 (command) [220748]
> > > drivers/input/serio/i8042.c: 45 -> i8042 (parameter) [220748]
> > > drivers/input/serio/i8042.c: 60 -> i8042 (command) [220943]
> > > drivers/input/serio/i8042.c: 47 -> i8042 (parameter) [220943]
> > > drivers/input/serio/i8042.c: d4 -> i8042 (command) [220943]
> > > drivers/input/serio/i8042.c: f2 -> i8042 (parameter) [220943]
> > > drivers/input/serio/i8042.c: fe <- i8042 (interrupt, AUX, 12, timeout) [220965]
> > 
> > Could you please try the patch below?
> 
> Ok, patch applied (against 2.6.12-rc5, clean, offset 2 lines for both
> hunk 3 and 4).  Mouse still doesn't work on resume.  dmesg
> w/i8042.debug set on kernel command line attached covering one
> suspend/resume.
> 

OK, that did not work... Could you try compiling without support for EC
(Embedded Controller) and also try enabling PNP support.

CCing Vojtech - maybe he has some ideas... 

-- 
Dmitry
