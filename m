Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261712AbVBEBSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261712AbVBEBSo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 20:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263369AbVBEBKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 20:10:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:51153 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265016AbVBEBHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 20:07:23 -0500
X-Authenticated: #26200865
Message-ID: <42041C6D.4000905@gmx.net>
Date: Sat, 05 Feb 2005 02:07:57 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: James Simmons <jsimmons@www.infradead.org>
CC: Pavel Machek <pavel@ucw.cz>, Jon Smirl <jonsmirl@gmail.com>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Reliable video POSTing on resume
References: <20050122134205.GA9354@wsc-gmbh.de> <4201825B.2090703@gmx.net> <e796392205020221387d4d8562@mail.gmail.com> <420217DB.709@gmx.net> <4202A972.1070003@gmx.net> <20050203225410.GB1110@elf.ucw.cz> <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net> <9e47339105020321031ccaabb@mail.gmail.com> <420367CF.7060206@gmx.net> <20050204163019.GC1290@elf.ucw.cz> <Pine.LNX.4.56.0502042206090.26459@pentafluge.infradead.org>
In-Reply-To: <Pine.LNX.4.56.0502042206090.26459@pentafluge.infradead.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons schrieb:
>>>int video_helper(struct video_actions *what_to_do)
>>
>>I do not know, synchronously executing userland code from kernel seems
>>like wrong thing to do.
> 
> I'm not a fan for this either. The good news is most graphics cards don't 
> require these tricks. The only ones that do are the ix86 cards. The real 
> solution would be if the hradware vendors open the parts of the spec to do 
> what we need. Many of the older cards could be supported in this way if we
> talk to the vendors. They shouldn't care if the specs are released anymore. 
> The problem would be the latest Radeon card and NVIDIA cards which 
> unfortunely are the most common cards for x86 platforms ;-(

Well, either you call userspace synchronously or you crash on resume.
I know what I prefer. And this synchronous call isn't so bad because
it comes with a timeout. So whatever the userspace program does, after
two seconds the kernel will continue unaffected. Once you execute the code
asynchronously, you get nondeterministic behaviour. That's sure fun for
filling up your random pool, but I wouldn't trust my data to such a system.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
