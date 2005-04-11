Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVDKKPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVDKKPq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 06:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVDKKPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 06:15:46 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:12887 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261759AbVDKKPM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 06:15:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fz6Mh1mD0MgoPljNW/d/d9Oms8THx8i1sUkwTrtKatc1uXM+ppfdVST3RNe+7WguvUipPkN71XRFFwqBuG2WCbBlgKErKoS21cy8x9MRu9ZUo0qN5JcFvw5FERTd5H3dd5mr6dc40lpIFId1HQnVrxpSf/Gchzok4XNk7eTu5E0=
Message-ID: <aec7e5c305041103154461ac5c@mail.gmail.com>
Date: Mon, 11 Apr 2005 12:15:08 +0200
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Domen Puncer <domen@coderock.org>
Subject: Re: [PATCH 0/5] autoparam
Cc: Magnus Damm <damm@opensource.se>, linux-kernel@vger.kernel.org
In-Reply-To: <20050409182128.GA5542@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050320223814.25305.52695.65404@clementine.local>
	 <20050409182128.GA5542@nd47.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/05, Domen Puncer <domen@coderock.org> wrote:
> On 21/03/05 00:06 +0100, Magnus Damm wrote:
> > Here are a set of patches that makes it possible to autogenerate kernel command
> > line documentation from the source code. The approach is rather straightforward
> > - the parameter name, the type and the description are stored in a section
> > called __param_strings. After vmlinux is built this section is extracted using
> > objcopy and a script is used to generate a primitive - but up to date -
> > document.
> 
> I think it's a great idea. A needed feature with simple implementation.
> I like it.

Thanks! And together with the "disable built-in" patch we have a much
more user-friendly system...

> > Right now the section is left in the kernel binary. The document is currently
> > not generated from the Makefile, so the curious user should perform:
> 
> Any plans to make this a complete patch?

Yes, if there is enough interest. I think autogenerating documents
from source code is the right way to do it, but I am not sure about
the disadvantages. Maybe someone could enlighten me? The latest patch
does not support obsolete MODULE_PARM() parameters - so I need to add
that to next release but that is no biggie.

> > $ objcopy -j __param_strings vmlinux -O binary foo
> > $ chmod a+x scripts/section2text.rb
> > $ cat foo | ./scripts/section2text.rb
> >
> > And yeah, you need to install ruby to run the script.
> 
> Attached a perl script, that has almost the same output. (I think
> perl is more usual on linux machines)

Great, thanks! I prefer to do prototype hacking in ruby, but I realize
that "the magic duct tape language" is more suitable.. =)

Also, I am thinking of using a prefix with the parameter type to
determine the origin of the parameter, ie:

prefix "s:" means from __setup()
prefix "e:" means from early_param()
prefix "m:" means from module_param()
prefix "o:" means from obsolete MODULE_PARM()

Then I would like to let the script convert the types to a common set of types.
I thought about treating descriptions without parameters as errors,
and generate warnings about parameters without description. And to
reduce the amount of warnings I think it is a good idea to add a
SETUP_DESC() as suggested by Matt Domsch.

> > The ruby script section2text.rb does some checks to see if MODULE_PARM_DESC()
> > is used without module_param(). You will find interesting typos.
> >
> > Future work that extends this idea could include replacing __setup(name) with
> > __setup(name, descr). And storing the documentation somewhere to make it easy
> > for the end user to look up the generated parameter list from the boot loader.
> 
> And kernel-parameters.txt will never again have obsoleted options :-)

Exactly! =)

/magnus
