Return-Path: <linux-kernel-owner+willy=40w.ods.org-S279743AbVBDFDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S279743AbVBDFDx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 00:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S279813AbVBDFDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 00:03:53 -0500
Received: from rproxy.gmail.com ([64.233.170.200]:33565 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S279743AbVBDFDZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 00:03:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=B+JUnpDpWEmMj9AYjX4NMrVgBC1PKkI8vk6NoMEg0EOZj1TFpVolT7Qu+7g63b6iFrUHXgk59SO9Yy5DVO0xxLytkZg7EGNnNX5PPaeaaPU0xdLcVtAU0/S+7WcAjT4rc9d0TcxlonNSXSyfAxF2mUVntiNQ+n0inFkILbe5H0U=
Message-ID: <9e47339105020321031ccaabb@mail.gmail.com>
Date: Fri, 4 Feb 2005 00:03:24 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI] Samsung P35, S3, black screen (radeon))
Cc: ncunningham@linuxmail.org, Pavel Machek <pavel@ucw.cz>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4202DF7B.2000506@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net>
	 <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net>
	 <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz>
	 <1107474198.5727.9.camel@desktop.cunninghams>
	 <4202DF7B.2000506@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reseting a video card from suspend is essentially the same problem as
reseting secondary video cards on boot. The same code can address both
problems.

Some things to consider....

1) With multiple video cards you have to ensure only a single VGA gets
enabled. Running video reset on a card is going to turn on it's VGA
emulation. So you have to ensure that VGA emulation on other cards is
disabled first.

2) I add the 'rom' parameter in sysfs so that you can get to the rom
contents from a user space app. It's there to support running video
reset code. "echo 1 >rom" to see the contents, it is not enabled by
default.

3) The user space reset programs have to be serialized because of the
rule about only a single VGA at a time. Calling vm86 from kernel mode
is not a good idea. Doing this in user space lets you have two reset
programs, vm86 and emu86 for non-x86 machines.

A starting place for a user space reset program:
ftp://ftp.scitechsoft.com/devel/obsolete/x86emu/x86emu-0.8.tar.gz

This thread talks about the VGA routing code:
http://lkml.org/lkml/2005/1/17/347

-- 
Jon Smirl
jonsmirl@gmail.com
