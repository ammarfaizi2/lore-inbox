Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUD0XSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUD0XSg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 19:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUD0XSV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 19:18:21 -0400
Received: from imap.gmx.net ([213.165.64.20]:35285 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264402AbUD0XSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 19:18:06 -0400
X-Authenticated: #21910825
Message-ID: <408EEA1C.2030906@gmx.net>
Date: Wed, 28 Apr 2004 01:17:48 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Marc Boucher <marc@linuxant.com>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org, rusty@rustcorp.com.au,
       pmarques@grupopie.com, jon787@tesla.resnet.mtu.edu, malda@slashdot.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
References: <20040427165819.GA23961@valve.mbsi.ca>
In-Reply-To: <20040427165819.GA23961@valve.mbsi.ca>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Boucher wrote:
> Hi everyone,
> 
> On Tue, Apr 27, 2004 at 04:09:36AM +0200, Carl-Daniel Hailfinger wrote:
> 
>>Hi,
>>
>>LinuxAnt offers binary only modules without any sources.
> 
> 
> Not true. Linuxant modules come with full source for operating-system specific
> code.

As somebody else already asked: Where is that source?


>>To circumvent our
>>MODULE_LICENSE checks LinuxAnt has inserted a "\0" into their declaration:
>>
>>MODULE_LICENSE("GPL\0for files in the \"GPL\" directory; for others, only
>>LICENSE file applies");
> 
> 
> 
> Paulo Marques said:
> 
>>The way I see it, they know a C string ends with a '\0'. This is like saying 
>>that a English sentence ends with a dot. If they wrote "GPL\0" they are 
>>effectively saying that the license *is* GPL period.
>>
>>So, where the source code? :)
> 
> 
> Unfortunately Linuxant cannot release the source for the proprietary portions
> [...]

Then why do you claim the license of the proprietary portions is GPL?


> Willy Tarreau <willy () w ! ods ! org> wrote:
> 
>> [...]
>>
>>>The attached patch blacklists all modules having "Linuxant" or "Conexant"
>>>in their author string. This may seem a bit broad, but AFAIK both
>>>companies never have released anything under the GPL and have a strong
>>>history of binary-only modules.
>>
>>What would be smarter would be to try to understand why they do this.
> 
> Exactly. Linuxant's intent is NOT to circumvent any license checks (see
> below for why this specific workaround was put in) which would be unnecessary
> since the drivers in question do not use any GPL_ONLY functions, as far as
> I know.

As far as you know. Can we assume you didn't bother to check?


>>At the moment, it seems to me that their only problem is to taint the kernel.
> 
> 
> Actually, we also have no desire nor purpose to prevent tainting. The purpose

Then why the fuck did you prevent tainting this way?


> of the workaround is to avoid repetitive warning messages generated when
> multiple modules belonging to a single logical "driver"  are loaded (even when
> a module is only probed but not used due to the hardware not being present).
> Although the issue may sound trivial/harmless to people on the lkml, it was a
> frequent cause of confusion for the average person.

"Repetitive messages". The way you did it, there are no messages at all.

If you had wanted to avoid repetitive messages, you could have
 - asked on linux-kernel to not output further warnings if the kernel is
   already tainted
 - given at least one module a non-GPL MODULE_LICENSE.

So you are nothing but a liar caught red-handed. And such a bad liar at that.


> Other Linuxant drivers (like DriverLoader and Riptide) do not need nor use this
> workaround because they are not composed of multiple modules and one set of
> warning messages is usually bearable. 
> 
> 
>>Why ? I don't this that any old modutils/module-utils found in any distros
>>don't load properly such modules. So perhaps they only want not to taint
>>the kernel because it appears dirty to their customers who will not receive
>>any more support from LKML. So perhaps what we really need is to add a new
>>MODULE_SUPPORT field stating where to get support from in case of bugs,
>>oopses or panics on a tainted kernel. Thus, the module author would be able
>>to insert something such as "support_XXX@author.com" which will be displayed
>>on each oops/panic/etc... Even if this is a long list because the customer
>>uses connexant, nvidia, checkpoint and I don't know what, at least he will
>>get 3 email addresses for his support. And it might reassure these authors
>>to know that the customer will ask them before asking us with our automatic
>>replies "unload your binary modules...".
> 
> 
> Linuxant would very much welcome such steps to improve the current situation,
> and is willing to eliminate workarounds once they are no longer necessary.

Let me translate that.
"Linuxant has willfully screwed kernel developers. If they want Linuxant
to stop, they first have to do the following things: [long list]"

Since your modules are out there, we need a way to mark them as
proprietary. My patch did exactly that and nothing else.

Carl-Daniel
-- 
http://www.hailfinger.org/

