Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbWBLMGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbWBLMGn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 07:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWBLMGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 07:06:43 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:50180 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751008AbWBLMGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 07:06:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=iV8gsv177ZEhFA1CjUtkrP8jLh+8PBQzUzrRpjxH5pFKbPCpaKee8igDtpu29ZLwUQhrfJG6fsipSSEHRfZubPoxbihmeqXhvEB8fqofbTIybMXHx+MyjZW4PgmeHiNfJY+YvL0yvmA/KBmbu89kgA8m8RqMHJmPuLppi6tCRRM=
Message-ID: <43EF24C0.2040902@gmail.com>
Date: Sun, 12 Feb 2006 14:06:24 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060206)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Jan Merka <merka@highsphere.net>, Pavel Machek <pavel@ucw.cz>,
       suspend2-devel@lists.suspend2.net, linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler? (Was Re: [Suspend2-devel]
 Re: [ 00/10] [Suspend2] Modules support.)
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602101337.22078.rjw@sisk.pl> <20060210233507.GC1952@elf.ucw.cz> <200602111136.56325.merka@highsphere.net> <B5780C33-81CE-4B8A-9583-B9B3973FCC11@mac.com> <43EEF711.2010409@gmail.com> <43833C9D-40A2-42B3-83D9-3C9D3EB7C434@mac.com>
In-Reply-To: <43833C9D-40A2-42B3-83D9-3C9D3EB7C434@mac.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On Feb 12, 2006, at 03:51, Alon Bar-Lev wrote:
>> 2. Encrypt state - this allow you to be sure that your data is stored
>> encrypted. (Yes... You can encrypt the memory... but then you need a
>> whole initramfs clone in order to allow the user to specify how he
>> want to encrypt/decrypt).
> 
> Why the hell would you even _want_ to encrypt data in RAM?  If you have
> a secure OS install and a passworded screensaver that starts before
> suspend, then there is _nothing_ an attacker could do to the contents of
> RAM without hard-booting, which would just completely erase it, or
> without extremely specialized hardware and expertise.  Picking up a
> machine suspended to RAM is just as secure as picking up one that is on,
> no more or less.

I guess you are not a security aware user...
A machine that is turned on is *MUCH* less secured than a
machine which is turned off and have its disks encrypted. We
can start argue on this issue too... But I won't cooperate...

>> And another fact: Suspend-to-RAM implementation can be derived form
>> suspend-to-disk but not the other way around.
> 
> No, the two are _entirely_ independent.  Suspend-to-RAM does not need to
> copy memory at all, whereas suspend-to-disk requires it.  That very fact
> means that suspend-to-RAM is orders of magnitude faster than
> suspend-to-disk could ever be, especially as RAM gets exponentially larger.

Well... I see you already planned the implementation and
have all figured out...
But the fact is that suspend-to-RAM can be implemented by
suspend-to-disk without actually store the memory to
external device... But hay... You can implement and maintain
two separate solutions...

> No, suspend-to-ram is for people who need instant response times,
> suspend-to-disk should be an extension or simplification of "Freeze a
> process tree and all associated system status so we can completely give
> up the hardware for a while".  IMHO, the fact that both are called
> "suspend" is just due to historical quirk as opposed to any real
> similarity.

Again... This is a matter of implementation... I believe
that one complete suspend implementation can suite both disk
and RAM... The only difference is if you write the state to
external storage, and how you play with APM. So there is a
good reason why both are called "suspend".

I don't claim that virtualization approach is not
appropriate, and in the future suspend may use this in order
to create its snapshot, and maybe, as you say, you may get
suspend-to-RAM in-kernel and suspend-to-disk in user-space
by dumping each process's container into a file (I don't
know what you do with graphics and caching... but let's
assume you have solution for all).

Let's see what happened so far:

First we had swsusp... For many people it did not work, so
Suspend2 was developed, but was not merged mainly because it
had too many UI components in-kernel.

Then comes the micro-kernel approach to convert swsusp into
uswsusp... Suspend2 which is stable now cannot be merged
since it violates this idea. So users will not get a proper
merged solution for at least one more year.

Now, you come with a different solution (virtualization), so
let's delay suspend feature for how long? At least two years?

We need (and can get) suspend to work *NOW*, laptops are
being more and more common... People expect to have this
ability in a modern operating system, they don't care if it
is implemented in kernel or in user-space, they also don't
care if you change it along the way... And if in the future
Linux will be pure virtual machine, all will be happy....
And use it... But please consider offering a working
solution *NOW*.

Best Regards,
Alon Bar-Lev.

