Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281373AbRKQLid>; Sat, 17 Nov 2001 06:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281339AbRKQLiX>; Sat, 17 Nov 2001 06:38:23 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:63760 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S281373AbRKQLiM>;
	Sat, 17 Nov 2001 06:38:12 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Pinyowattayakorn, Naris" <np151003@exchange.SanDiegoCA.NCR.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Driver callback routine when panic() is called 
In-Reply-To: Your message of "Fri, 16 Nov 2001 20:30:23 CDT."
             <61A60D883863D411A36600D0B785B50C06D5FEA4@susdayte51.daytonoh.ncr.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 17 Nov 2001 22:38:00 +1100
Message-ID: <17427.1005997080@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2001 20:30:23 -0500, 
"Pinyowattayakorn, Naris" <np151003@exchange.SanDiegoCA.NCR.COM> wrote:
>Is there any call that can be used for a driver to register system crash
>callback routines. Thus, If panic( ) is called, such a callback can save
>device-state information to be written into the system crash dump file. 

notifier_chain_register(&panic_notifier_list, ...)

See the kdb patch[1] for example code.  Remember that all but one cpus
are dead by the time you are called, I hope all your IRQs go to the
single live cpu.

[1] ftp://oss.sgi.com/projects/kdb/download/ix86

