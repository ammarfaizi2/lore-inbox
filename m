Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281760AbRKUO0Q>; Wed, 21 Nov 2001 09:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281675AbRKUO0I>; Wed, 21 Nov 2001 09:26:08 -0500
Received: from barn.holstein.com ([198.134.143.193]:24589 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S281395AbRKUOZz>;
	Wed, 21 Nov 2001 09:25:55 -0500
Date: Wed, 21 Nov 2001 09:00:16 -0500
Message-Id: <200111211400.fALE0Gm03949@pcx4168.holstein.com>
From: "Todd M. Roy" <troy@holstein.com>
To: kaos@ocs.com.au
Cc: markorr@intersurf.com, linux-kernel@vger.kernel.org, bug-fileutils@gnu.org
In-Reply-To: <5682.1006173890@ocs3.intra.ocs.com.au> (message from Keith Owens
	on Mon, 19 Nov 2001 23:44:50 +1100)
Subject: Re: [2.4.15pre6] Funny error on "make modules_install" - cosmetic cleanup probably needed
Reply-To: troy@holstein.com
In-Reply-To: <5682.1006173890@ocs3.intra.ocs.com.au>
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 11/21/2001 09:00:21 AM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 11/21/2001 09:00:22 AM,
	Serialize complete at 11/21/2001 09:00:22 AM
X-Priority: 3 (Normal)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed this problem with the latest version of fileutils
from alpha.gnu.org, (fileutils-4.1.1.tar.bz2) I reverted to 4.1
and the problem disappeared.

-- todd --


>  X-RocketRCL: 1598;1;2282498317
>  X-Apparently-To: todd_m_roy@yahoo.com via web13602.mail.yahoo.com; 19 Nov 2001 04:49:52 -0800 (PST)
>  X-Yahoo-Received: from mux1.sc5.mail.yahoo.com
>    by web13602.mail.yahoo.com; 19 Nov 2001 04:49:52 -0800 (PST)
>  X-Yahoo-Received: from mta431.mail.yahoo.com
>    by mux1.sc5.mail.yahoo.com; 19 Nov 2001 04:49:52 -0800 (PST)
>  X-Yahoo-Forwarded: from tavkhelidzem@yahoo.com to mikheil.tavkhelidze@btinternet.com
>  X-Yahoo-Forwarded: from kratkin@yahoo.com to kratkin@egartech.com
>  X-Yahoo-Forwarded: from jasondmichaelson@yahoo.com to micha044@tc.umn.edu
>  X-Yahoo-Forwarded: from andrew_ip_ml@yahoo.com to aip_ml@cwlinux.com
>  X-Yahoo-MsgId: <mta431.mail.yahoo.com.1006174190.94912.0000>
>  X-Track: 1: 40
>  From:	Keith Owens <kaos@ocs.com.au>
>  Cc:	linux-kernel@vger.kernel.org
>  Date:	Mon, 19 Nov 2001 23:44:50 +1100
>  Sender:	linux-kernel-owner@vger.kernel.org
>  X-Mailing-List:	linux-kernel@vger.kernel.org
>  
>  On Mon, 19 Nov 2001 02:32:58 -0600, 
>  Mark Orr <markorr@intersurf.com> wrote:
>  >make[2]: Entering directory `/usr/src/linux/drivers/cdrom'
>  >mkdir -p /lib/modules/2.4.15-pre6/kernel/drivers/cdrom/
>  >cp cdrom.o cdrom.o /lib/modules/2.4.15-pre6/kernel/drivers/cdrom/
>  >cp: will not overwrite just-created `/lib/modules/2.4.15-pre6/kernel/drivers/cdrom/cdrom.o' with `cdrom.o'
>  
>  There are several places where a module gets installed twice, because
>  of the way that module objects are selected in 2.4 (2.5 does not have
>  this feature).  The fix is easy but it should not be necessary.  IMNSHO
>  it is *wrong* for fileutils to decide that it will not copy a file
>  twice, cp should do what the user asked.  Complain to the fileutils
>  maintainer as a first step.
>  
>  Work around for unexpected cp behaviour, against 2.4.14, untested.
>  
>  Index: 14.1/Rules.make
>  --- 14.1/Rules.make Wed, 07 Mar 2001 23:04:43 +1100 kaos (linux-2.4/T/c/47_Rules.make 1.1.2.2 644)
>  +++ 14.1(w)/Rules.make Mon, 19 Nov 2001 23:42:58 +1100 kaos (linux-2.4/T/c/47_Rules.make 1.1.2.2 644)
>  @@ -173,7 +173,7 @@ modules: $(ALL_MOBJS) dummy \
>   _modinst__: dummy
>   ifneq "$(strip $(ALL_MOBJS))" ""
>   	mkdir -p $(MODLIB)/kernel/$(MOD_DESTDIR)
>  -	cp $(ALL_MOBJS) $(MODLIB)/kernel/$(MOD_DESTDIR)$(MOD_TARGET)
>  +	cp $(sort $(ALL_MOBJS)) $(MODLIB)/kernel/$(MOD_DESTDIR)$(MOD_TARGET)
>   endif
>   
>   .PHONY: modules_install
>  
>  
>  
>  -
>  To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://www.tux.org/lkml/
>  
