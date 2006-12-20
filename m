Return-Path: <linux-kernel-owner+w=401wt.eu-S965060AbWLTOAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbWLTOAw (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 09:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965066AbWLTOAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 09:00:52 -0500
Received: from tirith.ics.muni.cz ([147.251.4.36]:55168 "EHLO
	tirith.ics.muni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965060AbWLTOAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 09:00:52 -0500
Message-ID: <458941D1.7070301@gmail.com>
Date: Wed, 20 Dec 2006 14:59:45 +0100
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: locking issue (hardirq+softirq+user)
References: <45893C1C.60305@gmail.com> <1166622618.3365.1389.camel@laptopd505.fenrus.org>
In-Reply-To: <1166622618.3365.1389.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.48.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Wed, 2006-12-20 at 14:35 +0100, Jiri Slaby wrote:
>> Hi!
>>
>> an user still gets NMI watchdog warning, that the machine deadlocked.
> 
> have you tried enabling LOCKDEP ?

No, only PROVE_LOCKING, I apply him to turn this on too.

>> isr() /* i.e. hardirq context */
>> {
>> spin_lock(&lock);
>> ...
>> spin_unlock(&lock);
>> }
> 
> this is ok if you are 100% sure that this never gets called in any other
> way

It holds. Only in request_irq isr function name occurs.

>> timer() /* i.e. softirq context */
>> {
>> unsigned int f;
>> spin_lock_irqsave(&lock, f) /* stack shows, that it locks here */
> 
> this is a bug, the flags are an "unsigned long" not "unsigned int"!
> It may do really bad stuff!

Aah, sorry, I misread the code, I saw flags, but it was port->flags;
board->flags, which is used in irq{save,restore} functions, is ulong.

thanks for the quick reply,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
